show databases;
create database customers;
use customers;
#drop database customers;
#create table in database
create table customer_info(
id integer AUTO_INCREMENT,
first_name varchar(25),
last_name varchar(25),
salary integer,
PRIMARY KEY(id));
show tables;
#drop table customer_info;
insert into customer_info values
(1,'John','Daniel',50000),
(2,'Deepak','Sharma',60000),
(3,'Gaurav','Kaitri',70000),
(4,'Sourav','Hansda',10000),
(5,'Ben','Parker',80000),
(6,'Steve','Rogers',null);
select * from customer_info 
where salary is null;
select * from customer_info
where salary is not null;
UPDATE customer_info set salary=56000
where first_name='Steve';
delete from customer_info where last_name='Rogers';
Alter table customer_info ADD email varchar(25);
Alter table customer_info ADD dob DATE;
Alter TABLE customer_info modify dob YEAR;
desc customer_info;
ALTER TABLE customer_info drop column email;
UPDATE customer_info 
SET dob = 1994 
WHERE first_name = 'John';
select * from customer_info;
create table student(
id int not null,
first_name varchar(25) not null,
last_name varchar(25) not null,
age int 
);
desc student;
alter table student modify age int not null;
create table person(
id int not null,
first_name varchar(25) not null,
last_name varchar(25) not null,
age int not null,
UNIQUE(id)
);
insert into person values
(1,'Sourav','Hansda',24);
select * from person;
alter table person Add UNIQUE(first_name);
desc person;
Alter table person 
add CONSTRAINT uc_person unique(age,first_name);
alter table person 
drop index uc_person;
create table person1(
id int not null, 
first_name VARCHAR(25) not null,
last_name VARCHAR(25),
age int,
constraint pk_person primary key(id,last_name)
);
desc person1;
alter TABLE person1
drop PRIMARY KEY;
alter table person1
add PRIMARY KEY(id);
create table person2(
id int not null, 
first_name VARCHAR(25),
last_name VARCHAR(25),
city_name VARCHAR(25)
);
#drop TABLE person2;
create table student2(
id int not null,
first_name varchar(24),
last_name varchar(25),
age int 
);
