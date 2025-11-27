# Homework_4
## Part 1 — Data Preparation and Parsing
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
