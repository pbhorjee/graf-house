CREATE FUNCTION catReplace AS(cat) ->
    replaceRegexpOne(
        replaceRegexpOne(
            replaceRegexpOne(Category, '(Health & Fitness)', 'Health'), '(Music & Audio)', 'Music'),
        '(Action|Adventure|Arcade|Board|Card|Casino|Casual|Educational|Puzzle|Racing|Music|Role Playing|Simulation|Sports|Strategy|Trivia|Word)',
        'Games');


DROP TABLE IF EXISTS appStoreData.t_released_cat_bytes_app;

CREATE TABLE IF NOT EXISTS appStoreData.t_released_cat_bytes_app
(
    released       DateTime('UTC'),
    app_id         String,
    app_name       String,
    category       String,
    size_bytes     Int64,
    average_rating Float64,
    num_ratings    Int64
) ENGINE = MergeTree ORDER BY Released;

INSERT INTO appStoreData.t_released_cat_bytes_app
SELECT Released, App_Id, App_Name, Primary_Genre AS Category, Size_Bytes, Average_User_Rating AS Average_Rating,
       Reviews AS Num_Ratings
FROM appStoreData.t_apple_app_store_s3
WHERE Category IN ('Games', 'Music', 'Health')
  AND Size_Bytes > 0
UNION ALL
SELECT parseDateTimeBestEffortOrZero(concat(splitByNonAlpha(Released)[2], '-', splitByNonAlpha(Released)[1], '-',
                                            splitByNonAlpha(Released)[3])) AS Released, `App Id` AS App_Id,
       `App Name` AS App_Name,
       replaceRegexpOne(
               catReplace(Category) AS Category,
       BYTE_SIZED(Bytes) AS Size_Bytes,
       Rating AS Average_Rating, `Rating Count` AS Num_Ratings
FROM appStoreData.t_google_play_s3
WHERE Category IN ('Games', 'Music', 'Health') SETTINGS input_format_allow_errors_num = 1000
    , date_time_input_format = 'best_effort';

