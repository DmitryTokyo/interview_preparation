-- Session 1
BEGIN;
SELECT * FROM products WHERE product_id = 1;

-- Session 2
BEGIN;
UPDATE products SET quantity = 15 WHERE product_id = 1;
COMMIT;

-- Session 1
SELECT * FROM products WHERE product_id = 1;
