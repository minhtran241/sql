-- Active: 1674749813179@@127.0.0.1@3306
CREATE TABLE users(
  id    SERIAL PRIMARY KEY,
  email VARCHAR(40) NOT NULL UNIQUE
);
CREATE TABLE posts(
  id      SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id),
  title   VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE comments(
  id      SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id),
  post_id INTEGER NOT NULL REFERENCES posts(id),
  body    VARCHAR(500) NOT NULL
);

INSERT INTO users(email)
SELECT
  'user_' || seq || '@' || (
    CASE (RANDOM() * 2)::INT
      WHEN 0 THEN 'gmail'
      WHEN 1 THEN 'hotmail'
      WHEN 2 THEN 'yahoo'
    END
  ) || '.com' AS email
FROM GENERATE_SERIES(1, 10) seq;

SELECT * FROM users;

INSERT INTO posts(user_id, title)
WITH expanded AS (
  SELECT RANDOM(), seq, u.id AS user_id
  FROM GENERATE_SERIES(1, 50) seq, users u
), shuffled AS (
  SELECT e.*
  FROM expanded e
  INNER JOIN (
    SELECT ei.seq, MIN(ei.random) FROM expanded ei GROUP BY ei.seq
  ) em ON (e.seq = em.seq AND e.random = em.min)
  ORDER BY e.seq
)
SELECT
  s.user_id,
  'It is ' || s.seq || ' ' || (
    CASE (RANDOM() * 2)::INT
      WHEN 0 THEN 'sql'
      WHEN 1 THEN 'elixir'
      WHEN 2 THEN 'ruby'
    END
  ) as title
FROM shuffled s;

SELECT * FROM posts LIMIT 10;

INSERT INTO comments(user_id, post_id, body)
WITH expanded AS (
  SELECT RANDOM(), seq, u.id AS user_id, p.id AS post_id
  FROM GENERATE_SERIES(1, 200) seq, users u, posts p
), shuffled AS (
  SELECT e.*
  FROM expanded e
  INNER JOIN (
    SELECT ei.seq, MIN(ei.random) FROM expanded ei GROUP BY ei.seq
  ) em ON (e.seq = em.seq AND e.random = em.min)
  ORDER BY e.seq
)
SELECT
  s.user_id,
  s.post_id,
  'Here some comment ' || s.seq AS body
FROM shuffled s;

SELECT * FROM comments LIMIT 10 OFFSET 3;