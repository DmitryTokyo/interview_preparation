-- Тестирование на таблице без индексов
EXPLAIN ANALYZE
SELECT * FROM cars_no_index WHERE brand_id = 10;

-- Тестирование на таблице с индексами
EXPLAIN ANALYZE
SELECT * FROM cars_with_index WHERE brand_id = 10;

-- Тестирование на таблице с индексами при выборке только нужных даннх
EXPLAIN ANALYZE
SELECT car_id FROM cars_with_index WHERE brand_id = 10;


-- Тестирование на таблице без индексов
EXPLAIN ANALYZE
SELECT * FROM cars_no_index WHERE brand_id = 10 AND model_id = 50;

-- Тестирование на таблице с индексами
EXPLAIN ANALYZE
SELECT * FROM cars_with_index WHERE brand_id = 10 AND model_id = 50;


-- Тестирование на таблице без индексов
EXPLAIN ANALYZE
SELECT * FROM cars_no_index WHERE colors @> ARRAY['white'];

-- Тестирование на таблице с индексами
EXPLAIN ANALYZE
SELECT * FROM cars_with_index WHERE colors @> ARRAY['white'];