use customers;
select * from student3;
insert into student3 values
(4,"Rajan","Mishra",27),
(5,"Gaurav","Tiwari",28);
select * from department;
## Inner join
select  first_name,last_name,age,department_name from student3 inner join department 
on student3.student_id=department.student_id;
## Left Join
select  first_name,last_name,age,department_name from student3 left join department 
on student3.student_id=department.student_id;
## Right Join
select  first_name,last_name,age,department_name from student3 right join department 
on student3.student_id=department.student_id;
## Full Join
select  first_name,last_name,age,department_name from student3 left join department 
on student3.student_id=department.student_id
union
select  first_name,last_name,age,department_name from student3 right join department 
on student3.student_id=department.student_id;
## Cross Join
select  first_name,last_name,age,department_name from student3 cross join department;
## Natural join
select  first_name,last_name,age,department_name from student3 natural join department;


