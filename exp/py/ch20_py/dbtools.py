import mysql.connector
from mysql.connector import Error
import logging

logging.basicConfig(
    filename='python_error.log',
    level=logging.DEBUG,
    format='%(asctime)s %(levelname)s: %(message)s'
)

def create_connection():
    try:
        connection = mysql.connector.connect(
            host="localhost",
            user="root",
            password="",
            database="vote"
        )
        logging.info("数据库连接状态: 成功")
        return connection
    except Error as e:
        logging.error(f"数据库连接失败: {str(e)}")
        return None

def execute_query(connection, query, params=None):
    try:
        cursor = connection.cursor(dictionary=True)
        if params:
            cursor.execute(query, params)
        else:
            cursor.execute(query)
        return cursor
    except Error as e:
        logging.error(f"执行查询失败: {str(e)}")
        return None 