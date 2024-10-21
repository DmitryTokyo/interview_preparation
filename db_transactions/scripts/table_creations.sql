CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(50),
    quantity INT
);

INSERT INTO products (product_name, quantity) VALUES ('Product A', 10), ('Product B', 20);