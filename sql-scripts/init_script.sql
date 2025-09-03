CREATE DATABASE IF NOT EXISTS de_pet_project;

TRUNCATE ALL TABLES FROM IF EXISTS de_pet_project;

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
