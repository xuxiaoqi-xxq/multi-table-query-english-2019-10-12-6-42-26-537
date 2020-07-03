#MySQL

# 1.Query the existence of ossn course
select * from course where id = 1;

# 2.Query the presence of both 1 and 2 courses
select * from course where id = 1 or id = 2;

# 3.Query the student number and student name and average score of students whose average score is 60 or higher.
-- select id, `name`, avg_score from (
-- 	select s.id,s.`name`, avg(sc.score) as avg_score 
-- 		from student s left join student_course sc on s.id = sc.studentId
-- 	group by s.id, s.`name`) 
-- as result 
-- where avg_score >= 60;
select s.id,s.`name`, avg(sc.score) as avg_score 
	from student s left join student_course sc on s.id = sc.studentId
group by s.id, s.`name`
having avg_score >= 60;

# 4.Query the SQL statement of student information that does not have grades in the student_course table
select s.id, s.`name`, s.age, s.sex, sc.score
	from student_course sc right join student s on sc.studentId = s.id
where sc.score is null;


# 5.Query all SQL with grades
select s.id, s.`name`, s.age, s.sex, sc.score
	from student_course sc right join student s on sc.studentId = s.id
where sc.score is not null;

# 6.Inquire about the information of classmates who have numbered 1 and also studied the course numbered 2
select * from student 
	where id in (
		select studentId from student_course 
			where courseId = '1' or courseId = '2'
            group by studentId
            having count(*) = 2
	);

# 7.Retrieve 1 student score with less than 60 scores in descending order
select * from student 
	where id in (
		select studentId from student_course 
			where score < 60 and courseId = '1' 
		order by score desc);

# 8.Query the average grade of each course. The results are ranked in descending order of average grade. When the average grades are the same, they are sorted in ascending order by course number.
select courseId, avg(score) as avg_score from student_course
group by courseId
order by avg_score desc, courseId asc;

# 9.Query the name and score of a student whose course name is "Math" and whose score is less than 60
select s.`name`, sc.score
	from student s 
    left join student_course sc on s.id = sc.studentId
    left join course c on c.id = sc.courseId
where c.`name` = 'Math' and score < 60;