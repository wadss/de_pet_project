-- создание бд
CREATE DATABASE IF NOT EXISTS de_pet_project

-- очистка всех таблиц в схеме
TRUNCATE ALL TABLES FROM IF EXISTS de_pet_project

-- не понимаю, почему нельзя сразу создать 3 таблицы, но по одной всё ок.
CREATE OR REPLACE TABLE de_pet_project.people
(
    `first_name` String NOT NULL,
    `last_name` String NOT NULL,
    `age` UInt32 NOT NULL,
    `profession` UInt32 NULL,
    `education` UInt32 NULL
)

ENGINE = MergeTree()
ORDER BY (first_name, last_name);

CREATE OR REPLACE TABLE de_pet_project.profession
(
	`id` UInt32 NOT NULL,
	`profession_name` String NOT NULL
)

ENGINE = MergeTree()
ORDER BY id;

CREATE OR REPLACE TABLE de_pet_project.education
(
	`id` UInt32 NOT NULL,
	`education_name` String NOT NULL
)

ENGINE = MergeTree()
ORDER BY id;

-- проверка качества данных

-- SELECT count(DISTINCT *) AS uniq_cnt, count(*) AS cnt FROM people

-- SELECT * 
-- FROM people AS p
-- LEFT JOIN profession AS pr ON p.profession = pr.id

-- SELECT *
-- FROM people AS p
-- LEFT JOIN education AS ed ON p.education = ed.id
