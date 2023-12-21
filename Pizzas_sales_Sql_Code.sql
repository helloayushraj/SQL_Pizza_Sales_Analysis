SELECT * FROM pizza_sales ;

/*
KPI’s Requirement
*/


-- 1.Total Revenue

SELECT 
     SUM(total_price) AS total_revenue 
FROM pizza_sales;

-- 2.Average Order Value

SELECT 
      SUM(total_price) / COUNT(distinct order_id) AS avg_order_value_sales
FROM pizza_sales;

-- 3.Total Pizzas Sold

SELECT 
     SUM(quantity) AS total_pizza_sold 
FROM pizza_sales;

-- 4. Total Orders

SELECT 
     COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales;

-- 5. Average Pizzas Per Order

SELECT 
     CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) 
	                                                                                     AS average_pizzas_per_order
FROM pizza_sales;



/*
Charts Requirement
*/

-- 1. Daily Trend for Total Orders

SELECT  
     DATENAME(DW, order_date) AS order_day ,
     COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY datename(DW, order_date) 
ORDER BY  total_orders DESC ;

-- 2. Monthly Trend for Total Orders

SELECT
      datename(month, order_date) AS order_month,
	  COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY total_orders DESC;


-- 3. Percentage of Sales by Pizza Category

SELECT 
	  pizza_category, 
	  CAST(SUM(total_price)*100/(SELECT SUM(total_price) FROM pizza_sales) as DECIMAL(10,2)) AS percentage_of_sale_by_pizza_category
FROM pizza_sales
GROUP BY pizza_category
ORDER BY 2 DESC;

-- 4.Percentage of Sales by Pizza Size

SELECT
      pizza_size,
	  CAST(SUM(total_price)*100/(SELECT SUM(total_price) FROM pizza_sales) as DECIMAL(10,2)) AS percentage_of_sales_by_pizza_size
FROM pizza_sales
GROUP BY pizza_size
ORDER BY 2 DESC;


-- 5.Total Pizzas Sold by Pizza Category

SELECT
      pizza_category,
	  COUNT(quantity) AS total_pizza_sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_pizza_sold;

-- 6.1 Top 5 best Sellers(by pizza_name) by Revenue 

SELECT
     TOP 5 pizza_name,
	 CAST(SUM(total_price) as DECIMAL(10,2)) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2 DESC
;

-- 6.2 Top 5 best Sellers(by pizza_name) by Total Quantity

SELECT
     TOP 5 pizza_name,
	 SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2 DESC

-- 6.3 Top 5 best Sellers(by pizza_name) by  Total Orders

SELECT
     TOP 5 pizza_name,
	 COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2 DESC
;


-- 7.1 Top 5 worst Sellers (by pizza_name) by Revenue 

SELECT
     TOP 5 pizza_name,
	 CAST(SUM(total_price) as DECIMAL (10,2)) AS total_revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2 ASC
;

-- 7.2 Top 5 worst Sellers(by pizza_name) by Total Quantity

SELECT
     TOP 5 pizza_name,
	 SUM(quantity) AS total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2 ASC
;

-- 7.3 Top 5 worst Sellers(by pizza_name) by  Total Orders

SELECT
     TOP 5 pizza_name,
	 COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY 2 ASC;


-- ---------------------------------------------------------------------------------------------------------------------------