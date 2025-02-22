from flask import Flask, render_template, request, redirect, url_for, flash, jsonify
from dbtools import create_connection, execute_query
import re

app = Flask(__name__)
app.secret_key = 'your_secret_key'  # 用于flash消息

def validate_id(id_number):
    """验证身份证号码"""
    if len(id_number) != 10:
        return False
    
    # 第一位必须是字母
    if not id_number[0].isalpha():
        return False
    
    # 后9位必须是数字
    if not id_number[1:].isdigit():
        return False
    
    # 这里可以添加更复杂的验证规则
    return True

@app.route('/')
def index():
    sort = request.args.get('sort', 'default')
    conn = create_connection()
    if conn:
        if sort == 'name':
            query = "SELECT * FROM candidate ORDER BY name DESC"
        else:
            query = "SELECT * FROM candidate"
        
        cursor = execute_query(conn, query)
        candidates = cursor.fetchall()
        cursor.close()
        conn.close()
        return render_template('index.html', candidates=candidates, sort=sort)
    return "数据库连接失败", 500

@app.route('/vote', methods=['POST'])
def vote():
    id_number = request.form.get('id').upper()
    name = request.form.get('name')
    
    if not validate_id(id_number):
        flash('无效的身份证号码')
        return redirect(url_for('index'))
    
    conn = create_connection()
    if conn:
        # 检查是否已经投票
        cursor = execute_query(conn, "SELECT * FROM id_number WHERE id = %s", (id_number,))
        if cursor.fetchone():
            flash('您已经参加过本次活动了')
            return redirect(url_for('index'))
        
        # 记录投票
        cursor = execute_query(conn, "INSERT INTO id_number (id) VALUES (%s)", (id_number,))
        cursor = execute_query(conn, "UPDATE candidate SET score = score + 1 WHERE name = %s", (name,))
        conn.commit()
        
        cursor.close()
        conn.close()
        return redirect(url_for('result'))
    return "数据库连接失败", 500

@app.route('/recommend', methods=['GET', 'POST'])
def recommend():
    if request.method == 'POST':
        name = request.form.get('name')
        introduction = request.form.get('introduction')
        
        conn = create_connection()
        if conn:
            # 检查候选人是否已存在
            cursor = execute_query(conn, "SELECT * FROM candidate WHERE name = %s", (name,))
            if cursor.fetchone():
                flash('此候选人已经存在')
                return redirect(url_for('recommend'))
            
            # 添加新候选人
            cursor = execute_query(conn, 
                "INSERT INTO candidate (name, introduction, score) VALUES (%s, %s, 0)",
                (name, introduction))
            conn.commit()
            cursor.close()
            conn.close()
            return redirect(url_for('index'))
        return "数据库连接失败", 500
    return render_template('recommend.html')

@app.route('/result')
def result():
    sort = request.args.get('sort', 'default')
    conn = create_connection()
    if conn:
        if sort == 'name':
            query = "SELECT * FROM candidate ORDER BY name DESC"
        elif sort == 'score':
            query = "SELECT * FROM candidate ORDER BY score DESC"
        else:
            query = "SELECT * FROM candidate"
            
        cursor = execute_query(conn, query)
        candidates = cursor.fetchall()
        
        # 计算总票数和百分比
        total_score = sum(c['score'] for c in candidates)
        for c in candidates:
            c['percent'] = round((c['score'] / total_score * 100) if total_score > 0 else 0, 2)
        
        cursor.close()
        conn.close()
        return render_template('result.html', 
                             candidates=candidates, 
                             total_score=total_score,
                             sort=sort)
    return "数据库连接失败", 500

if __name__ == '__main__':
    app.run(debug=True, port=5000) 