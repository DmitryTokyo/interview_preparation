-- Insert 1000 records into table without index
EXPLAIN ANALYZE
INSERT INTO cars_no_index (car_name, brand_id, model_id, price, colors)
SELECT
    'Test Car ' || i,
    (random() * 100)::INT + 1,
    (random() * 500)::INT + 1,
    (random() * 40000 + 10000)::NUMERIC(10, 2),
    ARRAY[
        (SELECT unnest(ARRAY['white', 'black', 'red', 'blue', 'green', 'yellow', 'gray'])
         ORDER BY random()
         LIMIT 1)
    ]
FROM generate_series(1, 1000) AS i;


-- Insert 1000 records into table with index
EXPLAIN ANALYZE
INSERT INTO cars_with_index (car_name, brand_id, model_id, price, colors)
SELECT
    'Test Car ' || i,
    (random() * 100)::INT + 1,
    (random() * 500)::INT + 1,
    (random() * 40000 + 10000)::NUMERIC(10, 2),
    ARRAY[
        (SELECT unnest(ARRAY['white', 'black', 'red', 'blue', 'green', 'yellow', 'gray'])
         ORDER BY random()
         LIMIT 1)
    ]
FROM generate_series(1, 1000) AS i;