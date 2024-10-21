-- Session 1
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT * FROM products WHERE product_id = 1;

-- Session 2
BEGIN;
UPDATE products SET quantity = 25 WHERE product_id = 1;
COMMIT;

-- Session 1
SELECT * FROM products WHERE product_id = 1;