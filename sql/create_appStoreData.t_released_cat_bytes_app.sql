DROP table IF EXISTS appStoreData.t_released_cat_bytes_app;

CREATE TABLE IF NOT EXISTS appStoreData.t_released_cat_bytes_app
(
    `Released` DateTime('UTC'),
    `App_Id` String,
    `App_Name` String,
    `Category` String,
    `Size_Bytes` Int64,
    `Average_Rating` Float64,
    `Num_Ratings` Int64
)
ENGINE = MergeTree
ORDER BY Released;

Insert into appStoreData.t_released_cat_bytes_app
SELECT Released,
       App_Id,
       App_Name,
       Primary_Genre       as Category,
       Size_Bytes,
       Average_User_Rating as Average_Rating,
       Reviews             as Num_Ratings
FROM appStoreData.t_apple_app_store_s3
WHERE Category in ('Games', 'Music', 'Health')
  AND Size_Bytes > 0
UNION ALL
select parseDateTimeBestEffortOrZero(concat(splitByNonAlpha(Released)[2], '-', splitByNonAlpha(Released)[1], '-',
                                            splitByNonAlpha(Released)[3])) as Released,
       `App Id`                                                                        as App_Id,
       `App Name`                                                                      as App_Name,
       replaceRegexpOne(
               replaceRegexpOne(replaceRegexpOne(Category, '(Health & Fitness)', 'Health'), '(Music & Audio)', 'Music'),
               '(Action|Adventure|Arcade|Board|Card|Casino|Casual|Educational|Puzzle|Racing|Music|Role Playing|Simulation|Sports|Strategy|Trivia|Word)',
               'Games')                                                                as Category,
       multiIf(notEmpty(extract(Size, '(\d+\.?\d+)(?:M)')),
               toInt64(toFloat64(extract(Size, '(\d+\.?\d+)(?:M)')) / 0.000001),
               notEmpty(extract(Size, '(\d+\.?\d+)(?:G)')),
               toInt64(toFloat64(extract(Size, '(\d+\.?\d+)(?:G)')) / 0.000000001), 0) as Size_Bytes,
       Rating                                                                          as Average_Rating,
       `Rating Count`                                                                  as Num_Ratings
from appStoreData.t_google_play_s3
where Category in ('Games', 'Music', 'Health')
SETTINGS input_format_allow_errors_num = 1000
    , date_time_input_format = 'best_effort';
