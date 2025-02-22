-- 1. 找出所有至少选修了一门 Comp.Sci.课程的学生的名字，保证结果中没有重复的姓名

select DISTINCT name
from course NATURAL JOIN student NATURAL JOIN takes
WHERE dept_name = 'Comp. Sci.';

-- 2.  找出所有没有选修在 2009 年春季之前开设的任何课程的学生的 ID 和姓名。

SELECT DISTINCT id,name
from takes NATURAL JOIN student
WHERE id NOT IN(select id from takes where year <2009 and semester = 'Spring');

-- 3. 找出每个系教师的最高工资值。可以假设每个系至少有一位教师

SELECT max(salary)
from instructor
GROUP by dept_name;

-- 4. 从前述查询所计算出的每个系最高工资中选出最低值

SELECT MIN(number)
from (SELECT max(salary)as number
        from instructor
        GROUP by dept_name)as sec_table;

-- 5.  创建一门课程“CS-001”，其名称为“Weekly Seminar”，学分为 0 (3.12.a)

INSERT into course
    VALUES('CS-001','Weekly Seminar','Comp. Sci.','0');

-- 6. 创建该课程在 2017 年秋季的一个课程段，sec_id 为 1，课程段地点暂不指定 (3.12.b)

INSERT into section
    VALUES('CS-001','1','Fall','2017',null,null,null);

-- 7. 为 Comp. Sci.系的每个学生都选修上述课程段 (3.12.c)

INSERT into takes
    SELECT id,'CS-001','1','Fall','2017',null
    from student
    where dept_name = 'Comp. Sci.';

-- 8. 删除ID为 '12345' 的学生选修上述课程段的信息 (3.12.d)

delete from takes
where course_id = 'CS-001' and sec_id = '1' and semester =
'Fall' and year = '2017' and id = (SELECT id from student where
ID = '12345');

-- 9. 删除课程 CS-001，如果在运行此删除语句之前，没有先删除这门课程的授课信息（课程段）会发生什么事情？ (3.12.e)

delete from course where course_id = 'CS-001';

delete from takes where course_id = 'CS-001';

-- 会报错，因为课程段是课程的一部分，不能单独删除课程，必须先删除课程段

-- 10. 删除课程名称中包含“advanced”的任意课程的任意课程段所对应的所有 takes 元组，在课程名与单词的匹配中忽略大小写 (3.12.f)

--直接使用 EXISTS
delete from takes
where EXISTS (select *
             from course
             where course.course_id = takes.course_id
             and LOWER(title) like '%advanced%');
delete from course 
where LOWER(title) LIKE '%advanced%';
