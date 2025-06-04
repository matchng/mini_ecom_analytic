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

--Top 5 Products by Revenue
