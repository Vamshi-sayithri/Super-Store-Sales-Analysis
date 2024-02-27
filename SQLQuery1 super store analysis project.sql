select * from SampleSuperstore
select Top 5*from SampleSuperstore 

--(1)----'What are the total sales and total Profits of each year'
select YEAR(Order_date) as Year, sum(Sales) as total_sales,sum(Profit) as total_Profit
from SampleSuperstore group by YEAR(Order_date) order by Year ASC

--(2)---What are the total profits and total sales per quarter?
select datepart(year,Order_date) as Year,
case
   when datepart(quarter,Order_date)=1 then 'Q1'
   when datepart(quarter,Order_date)=2 then 'Q2'
   when datepart(quarter,Order_date)=3 then 'Q3'
   else 'Q4'
end as Quarter,
cast(sum(Sales) as decimal(10,2)) as total_sales,
cast(sum(Profit) as decimal(10,2)) as total_Profit
from SampleSuperstore group by datepart(year,Order_date),datepart(quarter,Order_date) order by Year,quarter
 --sub 2nd one
select
case
   when datepart(quarter,Order_date)=1 then 'Q1'
   when datepart(quarter,Order_date)=2 then 'Q2'
   when datepart(quarter,Order_date)=3 then 'Q3'
   else 'Q4'
end as Quarter,
cast(sum(Sales) as decimal(10,2)) as total_sales,
cast(sum(Profit) as decimal(10,2)) as total_Profit
from SampleSuperstore group by datepart(quarter,Order_date) order by quarter desc

--(3)--- What region generates the highest sales and profits?

select region,cast(sum(Sales) as decimal(10,2)) as total_sales,cast(sum(Profit) as decimal(10,2)) as total_Profit from SampleSuperstore
group by region order by total_profit desc


---(4)-- what state and city brings in the highest sales and profits?


select top 10 state,cast(sum(sales)as decimal(10,2)) as total_sales,cast(sum(profit)as decimal(10,2))as total_profits,round((sum(profit)/sum(sales))* 100,2) as Profit_margin
from SampleSuperstore group by state
order by total_profits desc
---4.1

select top 10 state,cast(sum(sales)as decimal(10,2)) as total_sales,cast(sum(profit)as decimal(10,2))as total_profits
from SampleSuperstore group by state
order by total_profits asc

--4.2

select top 10 city,cast(sum(sales)as decimal(10,2)) as total_sales,cast(sum(profit)as decimal(10,2))as total_profits,round((sum(profit)/sum(sales))* 100,2) as Profit_margin
from SampleSuperstore group by city
order by total_profits desc

--4.3

select top 10 city,cast(sum(sales)as decimal(10,2)) as total_sales,cast(sum(profit)as decimal(10,2))as total_profits
from SampleSuperstore group by city
order by total_profits asc


--(5)-- The relationship between discount and sales and the total discount per category

select cast(discount as decimal(10,2)) as discount,avg(sales) as Avg_Sales from SampleSuperstore
group by discount
order by discount

--5.1--Total discount per product category:
select category,cast(sum(discount)as decimal(10,2)) as total_discount from SampleSuperstore group by category order by total_discount desc

--5.2---total discount by  each category and sub-category 

select category,sub_category,cast(sum(discount)as decimal(10,2)) as total_discount from SampleSuperstore group by category,sub_category
order by total_discount desc

--6. --What category generates the highest sales and profits in each region and state ?

SELECT category, SUM(sales) AS total_sales, SUM(profit) AS total_profit, ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin
FROM SampleSuperstore
GROUP BY category
ORDER BY total_profit DESC

---6.1---Highest total sales and profits per Category in each region

SELECT region, category,cast(SUM(sales) as decimal(10,2)) AS total_sales, cast(SUM(profit) as decimal(10,2)) AS total_profit
FROM SampleSuperstore
GROUP BY region, category
ORDER BY total_profit DESC;

--6.2--Top Highest total sales and profits per Category in each state

SELECT top 15 state, category, cast(SUM(sales) as decimal(10,2)) AS total_sales, cast(SUM(profit) as decimal(10,2)) AS total_profit
FROM SampleSuperstore
GROUP BY state, category
ORDER BY total_profit DESC;

--6.3--Top Lowest total sales and profits per Category in each state


SELECT top 15 state, category, cast(SUM(sales) as decimal(10,2)) AS total_sales, cast(SUM(profit) as decimal(10,2)) AS total_profit
FROM SampleSuperstore
GROUP BY state, category
ORDER BY total_profit ASC;

--7.-- What subcategory generates the highest sales and profits in each region and state ?
---Subcategories with their total sales, total profits and profit margins

SELECT sub_category, SUM(sales) AS total_sales, SUM(profit) AS total_profit, ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin
FROM SampleSuperstore
GROUP BY sub_category
ORDER BY total_profit DESC;

--7.1--Top 15 Subcategories with the highest total sales and total profits in each region

SELECT top 15 region, sub_category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM SampleSuperstore
GROUP BY region, sub_category
ORDER BY total_profit DESC;

--7.2--Top 15 Subcategories with the lowest total sales and total profits in each region

SELECT top 15 region, sub_category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM SampleSuperstore
GROUP BY region, sub_category
ORDER BY total_profit ASC;

--7.3--Top 15 Highest total sales and profits per Subcategory in each state

SELECT top 15 state, sub_category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM SampleSuperstore
GROUP BY state, sub_category
ORDER BY total_profit DESC;

--7.4--Top 15 Highest total sales and profits per Subcategory in each state

SELECT top 15 state, sub_category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM SampleSuperstore
GROUP BY state, sub_category
ORDER BY total_profit ASC;

--8. What are the names of the products that are the most and least profitable to us?
--Top 15 most profitable products

SELECT top 15 product_name, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM SampleSuperstore
GROUP BY product_name
ORDER BY total_profit DESC;

--8.1--Top 15 less profitable products

SELECT top 15 product_name, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM SampleSuperstore
GROUP BY product_name
ORDER BY total_profit ASC;

--9. What segment makes the most of our profits and sales ?
--Goods Segment ordered by total profits
SELECT segment, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM SampleSuperstore
GROUP BY segment
ORDER BY total_profit DESC;


--10. How many customers do we have (unique customer IDs) in total and how much per region and state?
--Total number of customers

SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM SampleSuperstore

--10.2--Total customers per region

SELECT region, COUNT(DISTINCT customer_id) AS total_customers
FROM SampleSuperstore
GROUP BY region
ORDER BY total_customers DESC;


--10.3--Top 15 states with the most customers

SELECT top 15 state, COUNT(DISTINCT customer_id) AS total_customers
FROM SampleSuperstore
GROUP BY state
ORDER BY total_customers desc;

--10.4--Top 15 states with the least customers

SELECT top 15 state, COUNT(DISTINCT customer_id) AS total_customers
FROM SampleSuperstore
GROUP BY state
ORDER BY total_customers asc;

--11. Customer rewards program
--Top 15 customers that generated the most sales compared to total profits.

SELECT top 15  customer_id, 
SUM(sales) AS total_sales,
SUM(profit) AS total_profit
FROM SampleSuperstore
GROUP BY customer_id
ORDER BY total_sales DESC


--12. Average shipping time per class and in total
---Average shipping time

select round(avg(datediff(day,order_date,ship_date)),1) as avg_shipping_time from SampleSuperstore

--12.1--Average shipping time by shipping mode
SELECT ship_mode,round(avg(datediff(day,order_date,ship_date)),1) AS avg_shipping_time
FROM SampleSuperstore
GROUP BY ship_mode
ORDER BY avg_shipping_time



















