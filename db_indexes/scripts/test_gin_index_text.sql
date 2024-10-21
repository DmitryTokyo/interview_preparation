EXPLAIN ANALYZE
SELECT * FROM text_no_index
WHERE to_tsvector('english', content) @@ to_tsquery('english', 'Lorem');

EXPLAIN ANALYZE
SELECT * FROM text_with_gin_index
WHERE to_tsvector('english', content) @@ to_tsquery('english', 'Lorem');

-- Скорее всего таблица с индексами покажет более медленный результат

-- Refresh statistics
ANALYZE text_with_gin_index;
ANALYZE text_no_index;

-- Принудительно отключаем последовательное сканирование (для тестирования)
SET enable_seqscan TO off;


EXPLAIN ANALYZE
SELECT * FROM text_no_index
WHERE to_tsvector('english', content) @@ to_tsquery('english', 'Lorem');

EXPLAIN ANALYZE
SELECT * FROM text_with_gin_index
WHERE to_tsvector('english', content) @@ to_tsquery('english', 'Lorem');

-- Включаем обратно последовательное сканирование
SET enable_seqscan TO on;
