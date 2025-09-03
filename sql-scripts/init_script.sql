CREATE DATABASE IF NOT EXISTS de_pet_project;

TRUNCATE ALL TABLES FROM IF EXISTS de_pet_project;

CREATE OR REPLACE TABLE de_pet_project.people
(
    `first_name` String,
    `last_name` String,
    `age` UInt32,
    `profession_name` String NULL,
    `education_name` String NULL
)

ENGINE = MergeTree()
ORDER BY (first_name);


/*
Проверка на наличие NULL значений в колонках:
SELECT *
FROM people
WHERE profession_name IS NULL
OR education_name IS NULL

Отбираем дубликаты:
SELECT *
FROM (SELECT *, ROW_NUMBER() OVER(PARTITION BY *) AS rnk
FROM people)
WHERE rnk >= 2
*/