-- sql/load_data.sql
COPY customers    FROM '/workspaces/mini_ecom_analytic/data/customers.csv'    DELIMITER ',' CSV HEADER;
COPY products     FROM '/workspaces/mini_ecom_analytic/data/products.csv'     DELIMITER ',' CSV HEADER;
COPY orders       FROM '/workspaces/mini_ecom_analytic/data/orders.csv'       DELIMITER ',' CSV HEADER;
COPY order_items  FROM '/workspaces/mini_ecom_analytic/data/order_items.csv'  DELIMITER ',' CSV HEADER;
