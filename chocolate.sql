select * from sales;
select SaleDate,Amount,Customers,Boxes from sales;
select Amount,Customers,GeoID from sales;
select SaleDate, Amount,Boxes, Amount/Boxes AS 'Amount per box' from sales;
select * from sales where amount> 10000;
select * from sales where amount> 10000 order by amount desc;
select * from sales where geoid='g1' order by PID,Amount desc;
select * from sales where Amount> 10000 and SaleDate>='2022-01-1';
select SaleDate,Amount from sales where Amount>10000 and year(SaleDate)=2022 order by Amount desc;
select * from sales where Boxes between 0 and 50;
select SaleDate,Amount,Boxes, weekday(SaleDate) as 'Day of Week'from sales where weekday(SaleDate)=4;
select * from people;
select * from people where Team='Delish' OR Team='Jucies';
select * from people where team in('Delish','Jucies');
select * from people where Salesperson like 'B%';
select * from people where Salesperson like '%B%';
select SaleDate,Amount, 
case 	when Amount<1000 then 'Under 1k'
		when Amount<5000 then 'Under 5k'
        when Amount<10000 then 'Under 10k'
	else '10k or more'
    end as 'Amount Category'
from sales;