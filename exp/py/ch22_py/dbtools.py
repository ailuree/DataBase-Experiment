import mysql.connector
from mysql.connector import Error
import logging
from PIL import Image
import os

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
            database="album"
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

def resize_photo(src_file, dest_name, max_size):
    """调整图片大小"""
    try:
        with Image.open(src_file) as img:
            # 转换为RGB模式
            if img.mode != 'RGB':
                img = img.convert('RGB')
            
            # 计算新的尺寸
            src_w, src_h = img.size
            if src_w > src_h:
                thumb_w = max_size
                thumb_h = int(src_h / src_w * thumb_w)
            else:
                thumb_h = max_size
                thumb_w = int(src_w / src_h * thumb_h)
            
            # 调整大小并保存
            img_resized = img.resize((thumb_w, thumb_h), Image.Resampling.LANCZOS)
            img_resized.save(dest_name, 'JPEG', quality=95)
            return True
    except Exception as e:
        logging.error(f"处理图片失败: {str(e)}")
        return False 