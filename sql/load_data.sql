-- sql/load_data.sql
COPY customers    FROM '/data/customers.csv'    DELIMITER ',' CSV HEADER;
COPY products     FROM '/data/products.csv'     DELIMITER ',' CSV HEADER;
COPY orders       FROM '/data/orders.csv'       DELIMITER ',' CSV HEADER;
COPY order_items  FROM '/data/order_items.csv'  DELIMITER ',' CSV HEADER;
