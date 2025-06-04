-- Monthly Revenue Trend
SELECT 
	DATE_TRUNC('month',order_date) as sale_month,
	SUM(total_sales) as monthly_revenue
FROM fact_orders
GROUP BY sale_month
ORDER BY sale_month;

-- Running Total Revenue By Product
SELECT
	dp.product_id,
	dp.product_name,
	fo.order_date,
	fo.product_price,
	fo.quantity,
	fo.total_sales,
	SUM (fo.total_sales) OVER(PARTITION BY dp.product_id ORDER BY fo.order_date) as running_total
FROM fact_orders fo
JOIN dim_products dp ON fo.product_id = dp.product_id;

--Top 5 Products by Sales
SELECT 
	p.product_name,
	SUM(fo.total_sales) as total_revenue
FROM dim_products p JOIN fact_orders fo
	ON p.product_id = fo.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 5;

--Top 5 Products per Region
WITH ranked_region_products AS (
	SELECT 
		p.product_name,
		c.region,
		SUM(fo.total_sales) as total_revenue,
		DENSE_RANK() OVER(PARTITION BY c.region ORDER BY SUM(fo.total_sales) desc) as ranked_product
	FROM dim_products p JOIN fact_orders fo 
		ON p.product_id = fo.product_id
	JOIN dim_customers c
		ON fo.customer_id = c.customer_id
	GROUP BY c.region, p.product_name
)

SELECT 
	product_name,
	region,
	total_revenue,
	ranked_product
FROM ranked_region_products
WHERE ranked_product BETWEEN 1 and 5
ORDER BY region, ranked_product;

