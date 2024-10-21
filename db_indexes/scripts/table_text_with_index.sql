CREATE TABLE text_with_gin_index (
    id SERIAL PRIMARY KEY,
    content TEXT
);

CREATE INDEX idx_content_gin ON text_with_gin_index USING GIN (to_tsvector('english', content));

INSERT INTO text_with_gin_index (content)
SELECT md5(random()::text) || ' Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
FROM generate_series(1, 100000);
