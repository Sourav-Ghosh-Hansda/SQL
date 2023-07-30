# CREATE table
create table EmployeeDemographics
(EmployeeID int,
First_Name varchar(50),
Last_Name varchar(50),
Age int,
Gender varchar(50)
);
create table EmployeeSalary
(Employee_ID int,
JobTitle varchar(50),
Salary int);
show tables;
# INSERT values into table
insert into EmployeeDemographics values
(1001,'Jim','Halpert',30,'Male'),
(1002,'Pam','Beasley',30,'Female'),
(1003,'Dwight','Schrute',29,'Male'),
(1004,'Angela','Martin',31,'Female'),
(1005,'Toby','Flenderson',32,'Male'),
(1006,'Michael','Scott',35,'Male'),
(1007,'Meredith','Palmer',32,'Female'),
(1008,'Stanely','Hudson',38,'Male'),
(1009,'Kevin','Malone',31,'Male');
select * from EmployeeDemographics;
insert into Employeesalary values
(1001,'Salesman',45000),
(1002,'Receptionist',36000),
(1003,'Salesman',63000),
(1004,'Accountant',47000),
(1005,'HR',50000),
(1006,'Regional Manager',65000),
(1007,'Supplier Relations',41000),
(1008,'Salesman',48000),
(1009,'Accountant',42000);
# distinct 
select * from EmployeeSalary;
select distinct(Gender)
from EmployeeDemographics;
# count
select count(Last_Name) AS LastNameCount
from EmployeeDemographics;
# max 
select max(Salary)
from EmployeeSalary;
# min
select min(Salary)
from EmployeeSalary;
# avg
select avg(Salary)
from EmployeeSalary;
# where
select *
from EmployeeDemographics
where First_Name='Jim';
# != or <>
select *
from EmployeeDemographics
where First_Name <>'Jim';
# And
select *
from EmployeeDemographics
where Age<=32 And Gender='Male';
# Or
select *
from EmployeeDemographics
where Age<=32 OR Gender='Male';
# like
select *
from EmployeeDemographics
where Last_Name like '%S%';
select *
from EmployeeDemographics
where Last_Name like 'S%';
select *
from EmployeeDemographics
where Last_Name like '%S%c%ott%';
# is null & is not null
select *
from EmployeeDemographics
where First_Name is Not Null;
select *
from EmployeeDemographics
where First_Name is Null;
# In 
select *
from EmployeeDemographics
where First_Name IN('Jim','Michael');
# Order By & Group By
select gender,count(gender) AS CountGender
from EmployeeDemographics
where Age>31
GROUP BY gender
ORDER BY CountGender;
select *
from EmployeeDemographics
ORDER BY Age,Gender;
SELECT *
FROM EmployeeDemographics
ORDER BY Age DESC;
SELECT *
FROM EmployeeDemographics
ORDER BY 4 DESC, 5 DESC;
select * from EmployeeDemographics;
select * from EmployeeSalary;
#Inner Join
select * from employeedemographics
Inner JOIN employeesalary
on employeedemographics.EmployeeID=employeesalary.Employee_ID;
# Full Outer Join
SELECT *
FROM employeedemographics
LEFT OUTER JOIN employeesalary
ON employeedemographics.EmployeeID = employeesalary.Employee_ID
UNION
SELECT *
FROM employeedemographics
RIGHT OUTER JOIN employeesalary
ON employeedemographics.EmployeeID = employeesalary.Employee_ID
WHERE employeedemographics.EmployeeID IS NULL; 


