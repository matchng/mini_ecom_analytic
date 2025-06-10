--Create a clean customer dimension table 
DROP TABLE IF EXISTS dim_customers;

CREATE TABLE dim_customers AS(
	SELECT customer_id,
		   INITCAP(TRIM(name)) AS name,
		   signup_date,
		   COALESCE(region, 'Unknown') AS region
	FROM customers
);
ALTER TABLE dim_customers ADD PRIMARY KEY (customer_id);

--Create a clean products dimension table
DROP TABLE IF EXISTS dim_products;

CREATE TABLE dim_products AS (
	SELECT product_id,
		   INITCAP(TRIM(name)) AS product_name,
		   TRIM(category) AS product_category,
		   price,
		   price IS NULL AS is_missing_price
	FROM products
);
ALTER TABLE dim_products ADD PRIMARY KEY (product_id);


-- Create a clean orders fact table
DROP TABLE IF EXISTS fact_orders;
CREATE TABLE fact_orders AS (
	SELECT 
		oi.order_item_id,
		o.order_id,
		o.customer_id,
		o.order_date,
		oi.product_id,
		p.price AS product_price,
		oi.quantity AS quantity,
		(oi.quantity * p.price) AS sales_amount
	FROM orders o 
	JOIN order_items oi ON o.order_id = oi.order_id 
	JOIN products p ON oi.product_id = p.product_id	
);

-- Add primary key to order_item_id in fact table
ALTER TABLE fact_orders 
ADD PRIMARY KEY (order_item_id);

-- Add foreign key from fact_orders.customer_id to dim_customers.customer_id
ALTER TABLE fact_orders 
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id) REFERENCES dim_customers (customer_id);

-- Add foreign key for product_id
ALTER TABLE fact_orders 
ADD CONSTRAINT fk_product
FOREIGN KEY (product_id) REFERENCES dim_products(product_id);

-- Add index on order_date to speed up time-based queries
CREATE INDEX IF NOT EXISTS idx_order_date ON fact_orders(order_date);

