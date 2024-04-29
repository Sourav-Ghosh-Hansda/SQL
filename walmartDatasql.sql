-- Create database
CREATE DATABASE IF NOT EXISTS walmartSales;
-- Create table
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    vat FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment_method VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);
-------------------------------------------------- Feature Engineering-----------------------------------------------------------------------------------
-- time_of_day
select time from sales;
SELECT time,
(CASE 
    WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
    WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
    ELSE 'Evening'					
END) AS time_of_day
FROM sales;
ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);
SET SQL_SAFE_UPDATES = 0;
UPDATE sales 
SET time_of_day = (
    CASE 
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'      
    END
);
-- day_name
SELECT date FROM sales;
SELECT date, DAYNAME(date) FROM sales;
ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);
UPDATE sales 
SET day_name = (
    DAYNAME(date)
);
-- month_name
SELECT date, MONTHNAME(date) FROM sales;
ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);
UPDATE sales 
SET month_name = (
    MONTHNAME(date)
);
---------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- Generic----------------------------------------------------------------------------------------
-- How many unique cities does the data have?
select distinct city from sales;
-- In which city is each branch?
select distinct branch from sales;
select distinct city,branch from sales;
---------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- Product----------------------------------------------------------------------------------------
-- How many product lines does the data have?
select count(distinct product_line) from sales;
-- What is the most common payment method?
select payment_method,count(payment_method) as cnt from sales group by payment_method order by cnt DESC;
-- What is the most selling product line?
select product_line,count(product_line) as pl from sales group by product_line order by pl DESC;
-- What is the total revenue by month?
select month_name as month, sum(total) as total_revenue from sales group by month_name order by total_revenue DESC;
-- What month had the largest COGS?
select month_name as month,sum(cogs) as cogs from sales group by month_name order by cogs DESC;
-- What product line had the largest revenue?
select product_line, sum(total) as total_revenue from sales group by product_line order by total_revenue DESC;
-- What is the city with the largest revenue?
select branch,city,sum(total) as total_revenue from sales group by city, branch order by total_revenue DESC;
-- What product line had the largest VAT?
select product_line,avg(vat) as VAT from sales group by product_line order by VAT DESC;
-- Fetch each product line and add a column to those product line showing "Good","Bad".Good if its greater than average sales

-- Which branch sold more products than average product sold?
select branch, sum(quantity) as qty from sales group by branch having sum(quantity) > (select avg(quantity)from sales);
-- What is the most common product line by gender?
select gender, product_line,count(gender) as total_cnt from sales group by gender, product_line order by total_cnt DESC;
-- What is the average rating of each product line?
select product_line,round(avg(rating),2) as avg_rating from sales group by product_line order by avg_rating DESC;
---------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- Sales------------------------------------------------------------------------------------------
-- Number of sales made in each time of the day per weekday?
select time_of_day, count(*) as total_sales from sales where day_name="Sunday" or day_name="Monday" group by time_of_day order by total_sales DESC;
-- Which customer types bring the most revenue?
select customer_type, sum(total) as total_revenue from sales group by customer_type order by total_revenue DESC;
-- Which city has the largest tax percent/ VAT(Value Added Tax)?
select city, avg(vat) as VAT from sales group by city order by VAT DESC;
-- Which customer type pays the most in VAT?
select customer_type, avg(vat) as VAT from sales group by customer_type order by VAT DESC;
---------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- Cuustomer---------------------------------------------------------------------------------------
-- How many unique customer types does the data have?
select distinct(customer_type) from sales;
-- How many unique payment methods does the data have?
select distinct(payment_method) from sales;
-- What is the most common customer type?
select customer_type,count(customer_type) as customer_number from sales GROUP BY customer_type order by customer_number DESC;
-- Which customer type buys the most?
select customer_type,count(*) as cstm_cnt from sales group by customer_type;
-- What is the gender of most of the customers?
select gender,count(*) as gender_cnt from sales group by gender order by gender_cnt DESC;
-- What is the gender distribution per branch?
select gender,count(*) as gender_cnt from sales where branch="B" group by gender order by gender_cnt DESC;
-- Which time of the day do customers give most ratings?
select time_of_day,AVG(rating) as avg_rating from sales group by time_of_day order by avg_rating DESC;
-- Which time of the day do customers give most ratings per branch?
select time_of_day,AVG(rating) as avg_rating from sales where branch="A" group by time_of_day order by avg_rating DESC;
-- Which day of the week has the best avg ratings?
select day_name,AVG(rating) as avg_rating from sales group by day_name order by avg_rating DESC;
-- Which day of the week has the best average ratings per branch?
select day_name,AVG(rating) as avg_rating from sales where branch="C" group by day_name order by avg_rating DESC;
---------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- Revenue And Profit Calculations ---------------------------------------------------------------
-- COGS(Cost of goods sold) = units Price * quantity
-- VAT = 5 % * COGS
-- VAT is added to the COGS and this is what is billed to the customer
-- total(gross sales) = VAT + COGS
-- gross Profit(gross Income) = total(gross sales) - COGS
-- Gross Margin is gross profit expressed in percentage of the total(gross profit / revenue)
-- Gross Margin = gross income / total revenue
-- Example with the first row in our DB :
-- Data given:
-- UnitPrice=45.79
-- Quantity=7
-- COGS=45.79*7=320.53
-- VAT=5%*COGS=5%320.53=16.0265
-- $total=VAT+COGS\=16.0265+320.53=336.5565
-- Gross Margin Percentage= gross income / total revenue=16.0265/336.5565=0.047619~4.7619%
---------------------------------------------------------------------------------------------------------------------------------------------------------
