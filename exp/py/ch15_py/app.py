from flask import Flask, render_template, jsonify, request
import mysql.connector
import logging

app = Flask(__name__)

# 配置日志
logging.basicConfig(
    filename='python_error.log',
    level=logging.DEBUG,
    format='%(asctime)s %(levelname)s: %(message)s'
)

# 数据库连接函数
def create_connection():
    try:
        connection = mysql.connector.connect(
            host="localhost",
            user="root",
            password="",
            database="mobile_store"
        )
        logging.info("数据库连接状态: 成功")
        return connection
    except Exception as e:
        logging.error(f"数据库连接失败: {str(e)}")
        return None

# 获取书籍信息的API
@app.route('/get_book_info')
def get_book_info():
    book_id = request.args.get('book_id', 0)
    mode = request.args.get('mode')
    
    logging.info(f"接收到的参数: book_id={book_id}, mode={mode}")
    
    conn = create_connection()
    if not conn:
        return jsonify({"error": "数据库连接失败"}), 500
        
    cursor = conn.cursor(dictionary=True)
    
    try:
        if mode == "prev":
            sql = f"SELECT * FROM product WHERE book_id < {book_id} ORDER BY book_id DESC LIMIT 1"
        else:
            sql = f"SELECT * FROM product WHERE book_id > {book_id} ORDER BY book_id LIMIT 1"
            
        logging.info(f"执行SQL: {sql}")
        cursor.execute(sql)
        result = cursor.fetchone()
        
        if result:
            response = {
                "book_id": result["book_id"],
                "image_name": result["image_name"],
                "description": result["description"]
            }
        else:
            # 如果没有记录，获取最大或最小ID的记录
            if mode == "prev":
                sql = "SELECT * FROM product WHERE book_id = (SELECT MAX(book_id) FROM product)"
            else:
                sql = "SELECT * FROM product WHERE book_id = (SELECT MIN(book_id) FROM product)"
                
            logging.info(f"执行第二次SQL: {sql}")
            cursor.execute(sql)
            result = cursor.fetchone()
            response = {
                "book_id": result["book_id"],
                "image_name": result["image_name"],
                "description": result["description"]
            }
            
        logging.info(f"返回数据: {response}")
        return jsonify(response)
        
    except Exception as e:
        logging.error(f"查询错误: {str(e)}")
        return jsonify({"error": str(e)}), 500
        
    finally:
        cursor.close()
        conn.close()

# 主页路由
@app.route('/')
def home():
    return render_template('index.html')

if __name__ == '__main__':
    app.run(
        host='0.0.0.0',
        port=8080,
        debug=True
    ) 