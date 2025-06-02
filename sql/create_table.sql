CREATE TABLE IF NOT EXISTS customers (
   customer_id INT PRIMARY KEY,
   name VARCHAR (100) NOT NULL,
   signup_date DATE,
   region TEXT
);

CREATE TABLE IF NOT EXISTS products (
  product_id INT PRIMARY KEY,
  name TEXT,
  category TEXT,
  price NUMERIC(10,2)
);

CREATE TABLE IF NOT EXISTS orders (
  order_id INT PRIMARY KEY,
  customer_id INT REFERENCES customers(customer_id),
  order_date DATE
);

CREATE TABLE IF NOT EXISTS order_items (
  order_item_id INT PRIMARY KEY,
  order_id INT REFERENCES orders(order_id),
  product_id INT REFERENCES products(product_id),
  quantity INT
);