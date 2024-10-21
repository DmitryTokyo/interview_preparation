CREATE TABLE IF NOT EXISTS cars_no_index
(
    car_id   SERIAL PRIMARY KEY,
    car_name VARCHAR(100),
    brand_id INT,
    model_id INT,
    price    DECIMAL(10, 2),
    colors   TEXT[]
);

-- Insert 500.000 records
INSERT INTO cars_no_index (car_name, brand_id, model_id, price, colors)
SELECT
    'Car ' || i AS car_name,
    (random() * 100)::INT + 1 AS brand_id,
    (random() * 500)::INT + 1 AS model_id,
    (random() * 40000 + 10000)::NUMERIC(10, 2) AS price,
    ARRAY(
        SELECT unnest(ARRAY['white', 'black', 'red', 'blue', 'green', 'yellow', 'gray'])
        ORDER BY random()
        LIMIT (random() * 3 + 1)::INT
    ) AS colors
FROM generate_series(1, 500000) AS i;