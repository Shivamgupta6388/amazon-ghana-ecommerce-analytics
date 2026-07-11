-- Objective Questions

-- Task 14
-- 14. Identify the top 5 most valuable customers using a composite score that combines three key metrics: (SQL)
-- Total Revenue (50% weight): The total amount of money spent by the customer.
-- Order Frequency (30% weight): The number of orders placed by the customer, indicating their loyalty and engagement.
-- Average Order Value (20% weight): The average value of each order placed by the customer, reflecting the typical transaction size.

SELECT 
    CustomerID,
    SUM(SalePrice) AS Total_Revenue,
    COUNT(OrderID) AS Order_Frequency,
    AVG(SalePrice) AS Avg_Order_Value,
    (
        (SUM(SalePrice) * 0.5) +
        (COUNT(OrderID) * 0.3) +
        (AVG(SalePrice) * 0.2)
    ) AS Composite_Score
FROM orders
GROUP BY CustomerID
ORDER BY Composite_Score DESC
LIMIT 5;


-- Task 15 
-- Calculate the month-over-month growth rate in total revenue across the entire dataset.

with month_group as (
	select 
		left(OrderDate, 7) as "Month",
		SUM(SalePrice) as "Total_revenue"
	from Orders
    group by left(OrderDate, 7)
),
prev_data as (
	select *,
		LAG(Total_revenue) over(order by Month) as Previous_month_revenue
    from month_group
)

select *,
	round(((Total_revenue - Previous_month_revenue) * 100) / Previous_month_revenue, 2) as Growth_rate
from prev_data;


-- Task 16
-- Calculate the rolling 3-month average revenue for each product category.
with category_data as (
	select 
		ProductCategory,
		left(OrderDate, 7) as "Month",
		SUM(SalePrice) as "Total_revenue"
	from Orders
    group by ProductCategory, left(OrderDate, 7)
)

select *,
	round(AVG(Total_revenue) over(partition by ProductCategory order by month
							rows between 2 PRECEDING and CURRENT ROW), 2) as Rolling_average_3_month
from category_data;

-- Task 17
-- Update the orders table to apply a 15% discount on the `Sale Price` for orders placed by customers who have made at least 10 orders.
with customer_list as (
	SELECT CustomerID
    from orders
    group by CustomerID
    having count(*) >= 10
)

UPDATE orders
SET SalePrice = SalePrice * 0.85
where CustomerID in (
	select * from Customer_list
);


-- Task 18
-- Calculate the average number of days between consecutive orders for customers who have placed at least five orders.
with qualify as (
    select CustomerID
    from orders
    group by CustomerID
    having COUNT(*) >= 5
),
Orders_data as (
    select 
        CustomerID,
        OrderDate,
        DATEDIFF(OrderDate, LAG(OrderDate) over (
            partition by CustomerID order by OrderDate
        )) as day_diff
    from orders 
    where CustomerID in (select CustomerID from qualify)
),
Average_data AS (
    SELECT 
        CustomerID,
        AVG(day_diff) AS avg_diff
    FROM Orders_data
    GROUP BY CustomerID
)

SELECT AVG(avg_diff) AS Average_days_between_orders
FROM Average_data; 


-- Task 19
-- Identify customers who have generated revenue that is more than 30% higher than the average revenue per customer.
WITH Customer_data AS (
    SELECT 
		CustomerID,
        SUM(SalePrice) AS Total_revenue
    FROM orders
    GROUP BY CustomerID
)

select *
from Customer_data
where Total_revenue > (
	select avg(Total_revenue) * 1.3 from Customer_data
)
order by Total_revenue desc;


-- Task 20
-- Determine the top 3 product categories that have shown the highest increase in sales over the past year compared to the previous year
with year_sales as (
    select 
        ProductCategory,
        YEAR(OrderDate) As order_year,
        SUM(SalePrice) as total_sales
    from orders
    group by ProductCategory, YEAR(OrderDate)
),
sales_growth as (
    select *,
        LAG(total_sales) OVER(partition by ProductCategory 
			order by order_year
        ) as previous_sales
    from year_sales
)

select *,
    (total_sales - previous_sales) as sales_increase
from sales_growth
order by sales_increase desc
limit 3;
