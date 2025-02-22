import pymysql
import sys
from getpass import getpass

def connect_to_database():
    """连接到数据库,返回连接对象"""
    while True:
        try:
            username = input("请输入数据库用户名: ")
            password = getpass("请输入数据库密码: ")
            
            connection = pymysql.connect(
                host='localhost',
                user=username,
                password=password,
                database='uni',  # 假设数据库名为university
                charset='utf8mb4'
            )
            print("成功连接到数据库!")
            return connection
        except pymysql.Error as e:
            print(f"连接失败: {e}")
            retry = input("是否重试? (y/n): ")
            if retry.lower() != 'y':
                sys.exit(1)

def search_instructor(connection):
    """搜索教师并返回匹配的结果"""
    cursor = connection.cursor()
    
    while True:
        search_string = input("请输入要搜索的教师姓名子串: ")
        try:
            query = """
                SELECT ID, name 
                FROM instructor 
                WHERE name LIKE %s
            """
            cursor.execute(query, f"%{search_string}%")
            results = cursor.fetchall()
            
            if results:
                print("\n找到以下匹配的教师:")
                print("ID\t姓名")
                print("-" * 30)
                for id, name in results:
                    print(f"{id}\t{name}")
                return True
            else:
                print("未找到匹配的教师")
                continue
                
        except pymysql.Error as e:
            print(f"查询出错: {e}")
            return False

def get_instructor_id():
    """获取有效的教师ID"""
    while True:
        try:
            id = input("\n请输入教师ID (0-99999): ")
            id_num = int(id)
            if 0 <= id_num <= 99999:
                return id
            else:
                print("ID必须在0到99999之间")
        except ValueError:
            print("请输入有效的数字ID")

def check_instructor_exists(connection, instructor_id):
    """检查教师是否存在"""
    cursor = connection.cursor()
    
    query = "SELECT name FROM instructor WHERE ID = %s"
    cursor.execute(query, (instructor_id,))
    result = cursor.fetchone()
    
    return result is not None

def print_teaching_record(connection, instructor_id):
    """打印教师的教学记录"""
    cursor = connection.cursor()
    
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
    results = cursor.fetchall()
    
    if not results:
        print("\n该教师没有教授任何课程")
        return
        
    print("\n教学记录:")
    print("系名\t\t课程ID\t课程名称\t\t\t课程段号\t学期\t年份\t注册人数")
    print("-" * 100)
    
    for record in results:
        dept_name, course_id, title, sec_id, semester, year, enrollment = record
        print(f"{dept_name:<15} {course_id:<8} {title:<25} {sec_id:<10} {semester:<8} {year:<6} {enrollment}")

def main():
    # 连接数据库
    connection = connect_to_database()
    
    try:
        # 搜索教师
        if not search_instructor(connection):
            return
            
        # 获取教师ID
        instructor_id = get_instructor_id()
        
        # 检查教师是否存在
        if not check_instructor_exists(connection, instructor_id):
            print("未找到该ID的教师")
            return
            
        # 打印教学记录
        print_teaching_record(connection, instructor_id)
        
    except pymysql.Error as e:
        print(f"发生错误: {e}")
    finally:
        connection.close()

if __name__ == "__main__":
    main() 