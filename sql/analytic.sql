-- Monthly Revenue Trend
SELECT 
	DATE_TRUNC('month',order_date) as sale_month,
	SUM(sales_amount) as monthly_sales
FROM fact_orders
GROUP BY sale_month
ORDER BY sale_month;

-- Running Total Revenue By Product
SELECT
	fo.order_item_id,
	dp.product_id,
	dp.product_name,
	fo.order_date,
	fo.product_price,
	fo.quantity,
	fo.sales_amount,
	SUM (fo.sales_amount) OVER(PARTITION BY dp.product_id ORDER BY fo.order_date, fo.order_item_id) as running_total
FROM fact_orders fo
JOIN dim_products dp ON fo.product_id = dp.product_id;

--Top 5 Products by Sales
SELECT
	p.product_id,
	p.product_name,
	SUM(fo.sales_amount) as total_sales
FROM dim_products p JOIN fact_orders fo
	ON p.product_id = fo.product_id
GROUP BY p.product_id,p.product_name
ORDER BY total_sales DESC
LIMIT 5;

--Top 5 Products per Region
WITH ranked_region_products AS (
	SELECT 
		p.product_name,
		c.region,
		SUM(fo.sales_amount) as total_sales,
		DENSE_RANK() OVER(PARTITION BY c.region ORDER BY SUM(fo.sales_amount) desc) as ranked_product
	FROM dim_products p JOIN fact_orders fo 
		ON p.product_id = fo.product_id
	JOIN dim_customers c
		ON fo.customer_id = c.customer_id
	GROUP BY c.region, p.product_name
)

SELECT 
	product_name,
	region,
	total_sales,
	ranked_product
FROM ranked_region_products
WHERE ranked_product BETWEEN 1 and 5
ORDER BY region, ranked_product;

-- Cumulative Revenue 
SELECT
  order_date,
  SUM(sales_amount) AS daily_sales,
  SUM(SUM(sales_amount)) OVER (ORDER BY order_date) AS running_total
FROM fact_orders
GROUP BY order_date
ORDER BY order_date;

-- Customer Revenue Contribution Breakdown
SELECT 
  c.customer_id, 
  c.name,
  COUNT(DISTINCT fo.order_id) AS unique_orders,
  COUNT(fo.order_item_id) AS total_order_items,
  COALESCE(SUM(fo.sales_amount),0) AS total_sales,
  SUM(SUM(fo.sales_amount)) OVER () AS total_revenue,
  COALESCE(SUM(sales_amount) / SUM(SUM(sales_amount)) OVER (),0) AS percentage_of_total
FROM customers c 
LEFT JOIN fact_orders fo USING (customer_id)
GROUP BY c.customer_id, c.name
ORDER BY total_sales DESC;
