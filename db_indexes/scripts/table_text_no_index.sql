CREATE TABLE text_no_index (
    id SERIAL PRIMARY KEY,
    content TEXT
);

INSERT INTO text_no_index (content)
SELECT md5(random()::text) || ' Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
FROM generate_series(1, 100000);