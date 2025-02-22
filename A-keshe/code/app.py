from flask import Flask, render_template, request, flash, session, redirect, url_for
import pymysql
from functools import wraps

app = Flask(__name__)
app.secret_key = 'your_secret_key'  # 用于session和flash消息

# 数据库配置
DB_CONFIG = {
    'host': 'localhost',
    'database': 'uni',
    'charset': 'utf8mb4'
}

def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'logged_in' not in session:
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated_function

@app.route('/', methods=['GET'])
def login():
    return render_template('login.html')

@app.route('/login', methods=['POST'])
def do_login():
    username = request.form['username']
    password = request.form['password']
    
    try:
        connection = pymysql.connect(
            **DB_CONFIG,
            user=username,
            password=password
        )
        session['logged_in'] = True
        session['db_username'] = username
        session['db_password'] = password
        connection.close()
        return redirect(url_for('search'))
    except pymysql.Error as e:
        flash(f'登录失败: {str(e)}', 'error')
        return redirect(url_for('login'))

@app.route('/search', methods=['GET', 'POST'])
@login_required
def search():
    if request.method == 'POST':
        try:
            connection = pymysql.connect(
                **DB_CONFIG,
                user=session['db_username'],
                password=session['db_password']
            )
            cursor = connection.cursor()
            
            search_type = request.form['search_type']
            if search_type == 'name':
                search_string = request.form['search_string']
                query = "SELECT ID, name FROM instructor WHERE name LIKE %s"
                cursor.execute(query, f"%{search_string}%")
            else:  # search_type == 'id'
                instructor_id = request.form['instructor_id']
                try:
                    id_num = int(instructor_id)
                    if 0 <= id_num <= 99999:
                        query = "SELECT ID, name FROM instructor WHERE ID = %s"
                        cursor.execute(query, (instructor_id,))
                    else:
                        flash('ID必须在0到99999之间', 'error')
                        return render_template('search.html')
                except ValueError:
                    flash('请输入有效的数字ID', 'error')
                    return render_template('search.html')
            
            results = cursor.fetchall()
            connection.close()
            
            if not results:
                flash('未找到匹配的教师', 'error')
            
            return render_template('search.html', results=results)
            
        except pymysql.Error as e:
            flash(f'查询错误: {str(e)}', 'error')
            return render_template('search.html')
    
    return render_template('search.html')

@app.route('/record/<instructor_id>')
@login_required
def teaching_record(instructor_id):
    try:
        connection = pymysql.connect(
            **DB_CONFIG,
            user=session['db_username'],
            password=session['db_password']
        )
        cursor = connection.cursor()
        
        # 检查教师是否存在
        cursor.execute("SELECT name FROM instructor WHERE ID = %s", (instructor_id,))
        if not cursor.fetchone():
            flash('未找到该ID的教师', 'error')
            return redirect(url_for('search'))
        
        # 获取教学记录
        query = """
            SELECT i.dept_name, c.course_id, c.title, s.sec_id, 
                   s.semester, s.year, COUNT(t.ID) as enrollment
            FROM instructor i
            JOIN teaches te ON i.ID = te.ID
            JOIN section s ON te.course_id = s.course_id 
                AND te.sec_id = s.sec_id 
                AND te.semester = s.semester 
                AND te.year = s.year
            JOIN course c ON s.course_id = c.course_id
            LEFT JOIN takes t ON s.course_id = t.course_id 
                AND s.sec_id = t.sec_id 
                AND s.semester = t.semester 
                AND s.year = t.year
            WHERE i.ID = %s
            GROUP BY i.dept_name, c.course_id, c.title, s.sec_id, s.semester, s.year
            ORDER BY i.dept_name, c.course_id, s.year, s.semester
        """
        cursor.execute(query, (instructor_id,))
        records = cursor.fetchall()
        
        connection.close()
        return render_template('record.html', records=records)
    except pymysql.Error as e:
        flash(f'查询错误: {str(e)}', 'error')
        return redirect(url_for('search'))

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))

if __name__ == '__main__':
    app.run(debug=True) 