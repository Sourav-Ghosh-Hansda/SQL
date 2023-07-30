create database myDB;
use myDB;
ALTER database myDB READ ONLY=1;
#READ ONLY=0; to drop the databse
create table employee(
employee_id INT,
first_name VARCHAR(50),
last_name VARCHAR(50),
hourly_pay Decimal(5,2),
hire_date DATE
);
RENAME table workers to employees;
alter table employees 
add phone_number VARCHAR(50);
alter table employees 
rename column phone_number TO email;
alter table employees 
modify column email VARCHAR(100);
alter table employees 
modify email VARCHAR(100)
after last_name;
alter table employees
drop email;
insert into employees values
(1,"Eugene","Crabs",25.50,"2023-01-02"),
(2,"Squidward","Tentacles",15.00,"2023-01-03"),
(3,"Spongebob","Squarepants",12.50,"2023-01-04"),
(4,"Patrick","Star",12.50,"2023-01-05"),
(5,"Sandy","Cheeks",17.25,"2023-01-06");
insert into employees (employee_id,first_name,last_name)
values (6,"Sheldon","Cooper");
select * from employees;
select last_name,first_name from employees;
select * from employees 
where employee_id=1;
