-- 1.CREATING RAW TABLES 
DROP TABLE IF EXISTS games;
CREATE TABLE games AS
SELECT * FROM read_json_auto('C:/Users/Lesya/Desktop/Databases/games_dataset.json', maximum_object_size =268435456);
SELECT * FROM games
LIMIT 20;
DROP TABLE IF EXISTS games_raw;
CREATE TABLE games_raw AS
    SELECT
        UNNEST (games.games) AS games
    FROM games;
SELECT * FROM games_raw
LIMIT 20;
CREATE OR REPLACE TABLE games_raw AS
SELECT
    json_extract(games, '$.appid') AS appid,
    json_extract_string(games, '$.name_from_applist') AS name_from_applist,
    json_extract(games, '$.app_details.success') AS is_success,
    json_extract_string(games, '$.app_details.fetched_at') AS fetched_at,
    json_extract_string(games, '$.app_details.data.type') AS type,
    json_extract(games, '$.app_details.data.is_free') AS is_free,
    json_extract_string(games, '$.app_details.data.short_description') AS short_description,
    json_extract_string(games, '$.app_details.data.developers') AS developers,
    json_extract_string(games, '$.app_details.data.publishers') AS publishers,
    json_extract_string(games, '$.app_details.data.release_date.coming_soon') AS coming_soon,
    json_extract_string(games, '$.app_details.data.release_date.date') AS date,
    json_extract_string(games, '$.app_details.data.categories') AS categories,
    json_extract_string(games, '$.app_details.data.price_overview') AS price_overview,
    json_extract_string(games, '$.app_details.data.genres') AS genres
FROM games_raw;
SELECT * FROM games_raw
LIMIT 20;

DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews AS
SELECT * FROM read_json_auto('C:/Users/Lesya/Desktop/Databases/reviews_dataset.json', maximum_object_size =268435456);
SELECT * FROM reviews
LIMIT 20;
DROP TABLE IF EXISTS reviews_raw;
CREATE TABLE reviews_raw AS
    SELECT
        UNNEST (reviews.reviews) AS reviews
    FROM reviews;
SELECT * FROM reviews_raw
LIMIT 20;
CREATE OR REPLACE TABLE reviews_raw AS
SELECT
    json_extract(reviews, '$.appid') AS appid,
    json_extract_string(reviews, '$.review_data.success') AS success,
    json_extract(reviews, '$.review_data.query_summary.num_reviews') AS number_of_reviews
FROM reviews_raw;
SELECT * FROM reviews_raw
LIMIT 20;

-- 2.FILTERING DATA 
DROP TABLE IF EXISTS games_filtered;
CREATE TABLE games_filtered AS
SELECT
    appid,
    name_from_applist AS game_name,
    CAST(JSON_VALUE(price_overview, '$.final') AS DOUBLE) / 100 AS price,
    developers,
    genres,
    categories,
    date
FROM games_raw
WHERE is_success = true
  AND type = 'game'
  AND is_free = 'false'
  AND coming_soon = 'false';
SELECT * FROM games_filtered
LIMIT 20;

DROP TABLE IF EXISTS reviews_filtered;
CREATE OR REPLACE TABLE reviews_filtered AS
SELECT
    appid,
    success,
    number_of_reviews
FROM reviews_raw
WHERE success = 1;
SELECT * FROM reviews_filtered
LIMIT 20;

-- 3.Queries
-- 1.Top 20 games by number of reviews
SELECT
    g.appid,
    g.game_name,
    r.number_of_reviews
    FROM games_filtered g
    LEFT JOIN reviews_filtered r on g.appid = r.appid
ORDER BY number_of_reviews DESC
LIMIT 20;

-- 2.Distribution of game release years
SELECT
    RIGHT(date, 4) AS release_year,
    COUNT(*) AS games_count
FROM games_filtered g
WHERE length(date) >= 4
GROUP BY release_year
ORDER BY release_year DESC;

-- 3.Average price by genre
WITH genre_data AS (
    SELECT
        price,
        UNNEST(from_json(genres, '["JSON"]')) AS genre_json_object
    FROM games_filtered
    WHERE genres IS NOT NULL AND genres != '[]'
)
SELECT
    json_extract_string(genre_json_object, '$.description') AS genre,
    ROUND(AVG(price), 2) AS avg_price,
    COUNT(*) AS games_count
FROM genre_data
GROUP BY genre
ORDER BY avg_price DESC;

-- 4.Identify the most common tags across all games
WITH tags_unpacked AS (
    SELECT
        UNNEST(from_json(categories, '["JSON"]')) AS category_json_object
    FROM games_filtered
    WHERE categories IS NOT NULL
      AND categories != '[]'
)
SELECT
    json_extract_string(category_json_object, '$.description') AS tag_name,
    COUNT(*) AS frequency
FROM tags_unpacked
GROUP BY tag_name
ORDER BY frequency DESC
LIMIT 20;