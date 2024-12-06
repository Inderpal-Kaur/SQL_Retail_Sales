select * from dbo.[SQL - Retail Sales Analysis];

--CREATE TABLE
Create table reatil
(
transactions_id INT,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR (15),
age INT,
category VARCHAR (15),
quantity INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);

Select * From dbo.[SQL - Retail Sales Analysis]

--SELECT FIRST 10 DATASET
Select top 10 *
From dbo.[SQL - Retail Sales Analysis];


-- COUNT TOTAL DATA
Select count (*)
from dbo.[SQL - Retail Sales Analysis];

--DATA CLEANING
Select *
from dbo.[SQL - Retail Sales Analysis]
where transactions_id is NULL;

Select *
from dbo.[SQL - Retail Sales Analysis]
where sale_date is NULL;

Select *
from dbo.[SQL - Retail Sales Analysis]
where 
transactions_id IS NULL
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR
gender IS NULL
OR
age IS NULL
OR
category IS NULL 
OR
quantiy IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;


-- DELECTE NULL DATA
Delete from dbo.[SQL - Retail Sales Analysis]
where 
transactions_id IS NULL
OR
sale_date IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
OR
gender IS NULL
OR
age IS NULL
OR
category IS NULL 
OR
quantiy IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;

-- Data Exploration

-- How many sales we have?
select count (total_sale)
from dbo.[SQL - Retail Sales Analysis];

-- How many uniuque customers we have ?
Select Count (distinct customer_id)
from dbo.[SQL - Retail Sales Analysis];

-- how many different category we have?
SELECT DISTINCT category FROM dbo.[SQL - Retail Sales Analysis];

-- Data Analysis & Business Key Problems & Answers
 --Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

 select*
 from dbo.[SQL - Retail Sales Analysis]
 where sale_date = '2022-11-05';

 -- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
 
 select * 
 from dbo.[SQL - Retail Sales Analysis]
 where 
 category = 'Clothing'
 AND
 sale_date >= '2022-11-01'
 AND
 sale_date <'2022-12-01'
  AND
 quantiy >= 4;

 -- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
 select category,
 sum (total_sale) as net_sale,
 count (*) as total_orders
 from dbo.[SQL - Retail Sales Analysis]
 group by category;


 -- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

 select 
 Round (AVG(age),2) as Avg_age
 from dbo.[SQL - Retail Sales Analysis]
 where category = 'Beauty';


 -- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select *
from dbo.[SQL - Retail Sales Analysis]
where total_sale > '1000';


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select
category,
gender,
count(*) as total_trans
from dbo.[SQL - Retail Sales Analysis]
group by category,gender
order by 1;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select
year,month,avg_sale
from
(
select 
year (sale_date) as year,
month (sale_date) as month,
AVG (total_sale) as avg_sale,
RANK() OVER (PARTITION BY year (sale_date) ORDER BY avg(total_sale) ) AS rank
from dbo.[SQL - Retail Sales Analysis]
group by year (sale_date),
month (sale_date)
)
as A
where rank =1;



-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select top 5 
customer_id, sum (total_sale) as total_sales
from dbo.[SQL - Retail Sales Analysis]
group by customer_id
order by total_sales desc;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,
count (distinct customer_id) as unique_customers
from dbo.[SQL - Retail Sales Analysis]
group by category;


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

SELECT 
    CASE 
        WHEN DATEPART (HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART (HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS total_orders
FROM 
	dbo.[SQL - Retail Sales Analysis]
GROUP BY 
    CASE 
        WHEN DATEPART (HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART (HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END;

	-- End of the project