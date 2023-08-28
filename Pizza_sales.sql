-- KPI’s
SELECT SUM(total_price)FROM pizza_sales
/*----------------------------------------------------------------------------------------------------------------------------------*/
SELECT SUM(total_price) / COUNT(distinct order_id) AS avg_order_value FROM pizza_sales
/*----------------------------------------------------------------------------------------------------------------------------------*/
SELECT SUM(quantity) AS total_pizza_sold FROM pizza_sales
/*----------------------------------------------------------------------------------------------------------------------------------*/
SELECT COUNT(distinct order_id) AS total_orders FROM pizza_sales
/*----------------------------------------------------------------------------------------------------------------------------------*/
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) 
AS avg_pizzas_per_order
FROM pizza_sales
/*----------------------------------------------------------------------------------------------------------------------------------*/


-- Hourly Trend for Total Pizzas Sold
SELECT DATEPART(HOUR, order_time) AS Order_Hours, SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)



-- Weekly Trend for Orders
SELECT DATEPART(ISO_WEEK,order_date) AS Week_Number,YEAR(order_date) AS Year, count(DISTINCT order_id) as Total_Orders
from pizza_sales
group by DATEPART(ISO_WEEK,order_date),YEAR(order_date)
order by Week_Number,Year


-- % of Sales by Pizza Category
SELECT pizza_category,SUM(total_price) AS Total_Sales, SUM(total_price) * 100/ 
(SELECT SUM(total_price) FROM pizza_sales) AS PCT
FROM pizza_sales
GROUP BY pizza_category


-- % of Sales by Pizza Size
SELECT pizza_size,cast(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales, CAST(SUM(total_price) * 100/ 
(SELECT SUM(total_price) FROM pizza_sales WHERE datepart(QUARTER,order_date)=1)AS DECIMAL(10,2) ) AS PCT
FROM pizza_sales
WHERE DATEPART(QUARTER,order_date)=1
GROUP BY pizza_size
ORDER BY PCT DESC


-- Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC


-- Top 5 Pizzas by Revenue
SELECT TOP 5 pizza_name , SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
order by Total_Revenue DESC


-- Bottom 5 Pizzas by Revenue
SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC


-- Top 5 Pizzas by Quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC


-- Bottom 5 Pizzas by Quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC


-- op 5 Pizzas by Total Orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC


-- Borrom 5 Pizzas by Total Orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC


