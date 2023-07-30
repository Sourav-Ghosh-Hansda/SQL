use customers;
show tables;
select * from person2;
create index index_city_name
on person2(city_name);
DESC person2;
create index index_age
on student2(age);
DESC student2;
create index index_age_first_name
on student2(age,first_name);

alter table student2
drop index index_age;