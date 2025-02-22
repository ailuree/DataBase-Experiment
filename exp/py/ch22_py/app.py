from flask import Flask, render_template, request, redirect, url_for, flash, session
from dbtools import create_connection, execute_query, resize_photo
import os
from werkzeug.utils import secure_filename
import uuid
from functools import wraps

app = Flask(__name__)
app.secret_key = 'your_secret_key'  # 用于session和flash消息

# 确保上传目录存在
UPLOAD_FOLDERS = {
    'photo': os.path.join('static', 'Photo'),
    'thumbnail': os.path.join('static', 'Thumbnail')
}

for folder in UPLOAD_FOLDERS.values():
    os.makedirs(folder, exist_ok=True)

def login_required(f):
    """登录验证装饰器"""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'login_user' not in session:
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated_function

@app.route('/')
def index():
    conn = create_connection()
    if not conn:
        return "数据库连接失败", 500
    
    cursor = execute_query(conn, "SELECT id, name, owner FROM album ORDER BY name")
    albums = cursor.fetchall()
    
    for album in albums:
        cursor = execute_query(conn, 
            "SELECT filename FROM photo WHERE album_id = %s LIMIT 1", 
            (album['id'],))
        photo = cursor.fetchone()
        album['cover'] = photo['filename'] if photo else 'None.png'
        
        cursor = execute_query(conn,
            "SELECT COUNT(*) as total FROM photo WHERE album_id = %s",
            (album['id'],))
        album['total_photos'] = cursor.fetchone()['total']
    
    cursor.close()
    conn.close()
    
    return render_template('index.html', 
                         albums=albums, 
                         login_user=session.get('login_user'),
                         login_name=session.get('login_name'))

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        account = request.form['account']
        password = request.form['password']
        
        conn = create_connection()
        if not conn:
            return "数据库连接失败", 500
        
        cursor = execute_query(conn, 
            "SELECT account, name FROM user WHERE account = %s AND password = %s",
            (account, password))
        user = cursor.fetchone()
        
        if user:
            session['login_user'] = user['account']
            session['login_name'] = user['name']
            return redirect(url_for('index'))
        else:
            flash('账号密码错误，请重新输入')
        
        cursor.close()
        conn.close()
    
    return render_template('login.html')

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        account = request.form['account']
        password = request.form['password']
        confirm_password = request.form['confirm_password']
        name = request.form['name']
        
        if password != confirm_password:
            flash('两次输入的密码不一致')
            return redirect(url_for('register'))
        
        conn = create_connection()
        if not conn:
            return "数据库连接失败", 500
        
        cursor = execute_query(conn, 
            "SELECT * FROM user WHERE account = %s", (account,))
        if cursor.fetchone():
            flash('该账号已经存在')
            return redirect(url_for('register'))
        
        cursor = execute_query(conn,
            "INSERT INTO user (account, password, name) VALUES (%s, %s, %s)",
            (account, password, name))
        conn.commit()
        
        flash('注册成功，请登录')
        return redirect(url_for('login'))
    
    return render_template('register.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('index'))

@app.route('/add_album', methods=['GET', 'POST'])
@login_required
def add_album():
    if request.method == 'POST':
        album_name = request.form.get('album_name')
        login_user = session.get('login_user')
        
        conn = create_connection()
        if conn:
            cursor = execute_query(conn, 
                "SELECT IFNULL(MAX(id), 0) + 1 AS album_id FROM album")
            album_id = cursor.fetchone()['album_id']
            
            cursor = execute_query(conn,
                "INSERT INTO album (id, name, owner) VALUES (%s, %s, %s)",
                (album_id, album_name, login_user))
            conn.commit()
            
            cursor.close()
            conn.close()
            
            return redirect(url_for('show_album', album_id=album_id))
    
    return render_template('add_album.html')

@app.route('/edit_album/<int:album_id>', methods=['GET', 'POST'])
@login_required
def edit_album(album_id):
    login_user = session.get('login_user')
    
    conn = create_connection()
    if not conn:
        return "数据库连接失败", 500
    
    if request.method == 'POST':
        album_name = request.form.get('album_name')
        cursor = execute_query(conn,
            "UPDATE album SET name = %s WHERE id = %s AND owner = %s",
            (album_name, album_id, login_user))
        conn.commit()
        cursor.close()
        conn.close()
        return redirect(url_for('index'))
    
    cursor = execute_query(conn,
        "SELECT name, owner FROM album WHERE id = %s", (album_id,))
    album = cursor.fetchone()
    
    if not album or album['owner'] != login_user:
        flash('您不是相册的主人，无法修改相册名称')
    
    cursor.close()
    conn.close()
    return render_template('edit_album.html', album=album, album_id=album_id)

@app.route('/delete_album/<int:album_id>')
@login_required
def delete_album(album_id):
    login_user = session.get('login_user')
    
    conn = create_connection()
    if not conn:
        return "数据库连接失败", 500
    
    cursor = execute_query(conn,
        """SELECT filename FROM photo WHERE album_id = %s 
           AND EXISTS(SELECT 1 FROM album WHERE id = %s AND owner = %s)""",
        (album_id, album_id, login_user))
    
    for photo in cursor.fetchall():
        filename = photo['filename']
        photo_path = os.path.join(UPLOAD_FOLDERS['photo'], filename)
        thumb_path = os.path.join(UPLOAD_FOLDERS['thumbnail'], filename)
        
        if os.path.exists(photo_path):
            os.remove(photo_path)
        if os.path.exists(thumb_path):
            os.remove(thumb_path)
    
    cursor = execute_query(conn,
        """DELETE FROM photo WHERE album_id = %s 
           AND EXISTS(SELECT 1 FROM album WHERE id = %s AND owner = %s)""",
        (album_id, album_id, login_user))
    
    cursor = execute_query(conn,
        "DELETE FROM album WHERE id = %s AND owner = %s",
        (album_id, login_user))
    
    conn.commit()
    cursor.close()
    conn.close()
    
    return redirect(url_for('index'))

@app.route('/show_album/<int:album_id>')
def show_album(album_id):
    conn = create_connection()
    if not conn:
        return "数据库连接失败", 500
    
    cursor = execute_query(conn,
        "SELECT name, owner FROM album WHERE id = %s", (album_id,))
    album = cursor.fetchone()
    album['id'] = album_id
    
    cursor = execute_query(conn,
        "SELECT id, name, filename FROM photo WHERE album_id = %s", (album_id,))
    photos = cursor.fetchall()
    
    cursor.close()
    conn.close()
    
    return render_template('show_album.html', album=album, photos=photos)

@app.route('/upload_photo/<int:album_id>', methods=['GET', 'POST'])
@login_required
def upload_photo(album_id):
    if request.method == 'POST':
        login_user = session.get('login_user')
        
        conn = create_connection()
        cursor = execute_query(conn,
            "SELECT owner, name FROM album WHERE id = %s", (album_id,))
        album = cursor.fetchone()
        
        if not album or album['owner'] != login_user:
            flash('您不是相册的主人，无法上传照片')
            return redirect(url_for('show_album', album_id=album_id))
        
        files = request.files.getlist('photos')
        for file in files:
            if file and file.filename:
                filename = f"{uuid.uuid4()}.jpg"
                
                file_path = os.path.join(UPLOAD_FOLDERS['photo'], filename)
                thumb_path = os.path.join(UPLOAD_FOLDERS['thumbnail'], filename)
                
                file.save(file_path)
                resize_photo(file_path, thumb_path, 150)
                
                cursor = execute_query(conn,
                    "INSERT INTO photo (name, filename, album_id) VALUES (%s, %s, %s)",
                    (file.filename, filename, album_id))
        
        conn.commit()
        cursor.close()
        conn.close()
        
        return redirect(url_for('show_album', album_id=album_id))
    
    return render_template('upload_photo.html', album_id=album_id)

@app.route('/edit_photo/<int:photo_id>', methods=['GET', 'POST'])
@login_required
def edit_photo(photo_id):
    login_user = session.get('login_user')
    
    conn = create_connection()
    if not conn:
        return "数据库连接失败", 500
    
    if request.method == 'POST':
        photo_name = request.form.get('photo_name')
        photo_comment = request.form.get('photo_comment')
        album_id = request.form.get('album_id')
        
        cursor = execute_query(conn,
            """UPDATE photo SET name = %s, comment = %s 
               WHERE id = %s AND EXISTS(
                   SELECT 1 FROM album WHERE id = %s AND owner = %s
               )""",
            (photo_name, photo_comment, photo_id, album_id, login_user))
        
        conn.commit()
        cursor.close()
        conn.close()
        
        return redirect(url_for('show_album', album_id=album_id))
    
    cursor = execute_query(conn,
        """SELECT p.*, a.name as album_name, a.owner 
           FROM photo p JOIN album a ON p.album_id = a.id 
           WHERE p.id = %s""",
        (photo_id,))
    photo = cursor.fetchone()
    
    if not photo or photo['owner'] != login_user:
        flash('您不是相片的主人，无法修改相片信息')
    
    cursor.close()
    conn.close()
    
    return render_template('edit_photo.html', photo=photo)

@app.route('/delete_photo/<int:album_id>/<int:photo_id>')
@login_required
def delete_photo(album_id, photo_id):
    login_user = session.get('login_user')
    
    conn = create_connection()
    if not conn:
        return "数据库连接失败", 500
    
    cursor = execute_query(conn,
        """SELECT p.filename FROM photo p 
           JOIN album a ON p.album_id = a.id 
           WHERE p.id = %s AND a.owner = %s""",
        (photo_id, login_user))
    photo = cursor.fetchone()
    
    if photo:
        filename = photo['filename']
        photo_path = os.path.join(UPLOAD_FOLDERS['photo'], filename)
        thumb_path = os.path.join(UPLOAD_FOLDERS['thumbnail'], filename)
        
        if os.path.exists(photo_path):
            os.remove(photo_path)
        if os.path.exists(thumb_path):
            os.remove(thumb_path)
        
        cursor = execute_query(conn,
            "DELETE FROM photo WHERE id = %s", (photo_id,))
        conn.commit()
    
    cursor.close()
    conn.close()
    
    return redirect(url_for('show_album', album_id=album_id))

@app.route('/photo_detail/<int:album_id>/<int:photo_id>')
def photo_detail(album_id, photo_id):
    conn = create_connection()
    if not conn:
        return "数据库连接失败", 500
    
    cursor = execute_query(conn,
        "SELECT name FROM album WHERE id = %s", (album_id,))
    album_name = cursor.fetchone()['name']
    
    cursor = execute_query(conn,
        "SELECT filename, comment FROM photo WHERE id = %s", (photo_id,))
    photo = cursor.fetchone()
    photo['id'] = photo_id
    
    cursor = execute_query(conn,
        """SELECT a.id, a.filename FROM (
               SELECT id, filename FROM photo 
               WHERE album_id = %s AND id <= %s
               ORDER BY id DESC LIMIT 3
           ) a ORDER BY a.id""",
        (album_id, photo_id))
    nav_photos = list(cursor.fetchall())
    
    records_to_get = 5 - len(nav_photos)
    if records_to_get > 0:
        cursor = execute_query(conn,
            """SELECT id, filename FROM photo 
               WHERE album_id = %s AND id > %s
               ORDER BY id LIMIT %s""",
            (album_id, photo_id, records_to_get))
        nav_photos.extend(cursor.fetchall())
    
    cursor.close()
    conn.close()
    
    return render_template('photo_detail.html',
                         album_id=album_id,
                         album_name=album_name,
                         photo=photo,
                         nav_photos=nav_photos)

if __name__ == '__main__':
    app.run(debug=True) 