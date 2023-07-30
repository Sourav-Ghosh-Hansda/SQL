use practice;
create table client(
cid int not null,
cname VARCHAR(25),
email VARCHAR(50),
primary key(cid)
);
create table product(
pid int not null,
price numeric(10,2),
type varchar(20),
PRIMARY key(pid)
);
create TABLE orders(
cid int not null,
pid int not null,
date DATE,
quantity int,
FOREIGN KEY(cid) REFERENCES client(cid),
FOREIGN KEY(pid) REFERENCES product(pid)
);
show tables;