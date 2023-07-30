use customers;
create table student3(
student_id int auto_increment,
first_name varchar(25) not null,
last_name varchar(25) not null,
age int,
primary key(student_id));
insert into student3 values
(1,"Sourav","Hansda",24),
(2,"Suman","Samanta",25),
(3,"Suraj","Juvale",26);
create table department(
student_id int AUTO_INCREMENT,
department_name varchar(25) not null,
foreign key (student_id) references student3(student_id));
desc department;
insert into department values
(1,"Computer Science"),
(2,"Electronics"),
(3,"Mechanical");
select * from student3;
select * from department;
create view student_info as
select first_name,last_name,age from student3 
inner join department on student3.student_id=department.student_id;
#drop view student_info;
select * from student_info;