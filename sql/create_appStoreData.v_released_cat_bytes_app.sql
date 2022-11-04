-- noinspection SqlSignatureForFile

DROP TABLE IF EXISTS appStoreData.v_released_cat_bytes_app;

-- noinspection SqlSignature

CREATE VIEW IF NOT EXISTS appStoreData.v_released_cat_bytes_app
            (released DateTime,
             app_id String,
             app_name String,
             category String,
             size_bytes Int64,
             average_rating Float64,
             num_ratings Int64
                )
AS
SELECT Released, App_Id, App_Name, Primary_Genre AS Category, Size_Bytes, Average_User_Rating AS Average_Rating,
       Reviews AS Num_Ratings
FROM appStoreData.t_apple_app_store_s3
WHERE Category IN ('Games', 'Music', 'Health')
  AND Size_Bytes > 0
UNION ALL
SELECT splitByNonAlpha(Released) AS arr_date,
       if(length(arr_date) = 3, parseDateTimeBestEffortOrNull(concat(arr_date[2], '-', arr_date[1], '-', arr_date[3])),
          NULL) AS Released, `App Id` AS App_Id, `App Name` AS App_Name,
       replaceRegexpOne(
               replaceRegexpOne(replaceRegexpOne(Category, '(Health & Fitness)', 'Health'), '(Music & Audio)', 'Music'),
               '(Action|Adventure|Arcade|Board|Card|Casino|Casual|Educational|Puzzle|Racing|Music|Role Playing|Simulation|Sports|Strategy|Trivia|Word)',
               'Games') AS Category,
       multiIf(notEmpty(extract(Size, '(\d+\.?\d+)(?:M)')),
               toInt64(toFloat64(extract(Size, '(\d+\.?\d+)(?:M)')) / 0.000001),
               notEmpty(extract(Size, '(\d+\.?\d+)(?:G)')),
               toInt64(toFloat64(extract(Size, '(\d+\.?\d+)(?:G)')) / 0.000000001), 0) AS Size_Bytes,
       Rating AS Average_Rating, `Rating Count` AS Num_Ratings
FROM appStoreData.t_google_play_s3
WHERE Category IN ('Games', 'Music', 'Health');

