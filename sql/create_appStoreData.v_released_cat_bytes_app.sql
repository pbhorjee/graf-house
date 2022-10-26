
drop view If exists appStoreData.v_released_cat_bytes_app;

CREATE VIEW IF NOT EXISTS appStoreData.v_released_cat_bytes_app
(   `Released` DateTime,
    `App_Id` String,
    `App_Name` String,
    `Category` String,
    `Size_Bytes` Int64
) AS
    SELECT Released,
           App_Id,
        App_Name,
        Primary_Genre as Category,
        Size_Bytes
    FROM appStoreData.t_apple_app_store
    WHERE Category in ('Games', 'Music', 'Health')
        AND Size_Bytes > 0
UNION ALL
    select Released,
           `App Id` as App_Id,
           `App Name` as App_Name,
           replaceRegexpOne(
                   replaceRegexpOne(replaceRegexpOne(Category, '(Health & Fitness)', 'Health'), '(Music & Audio)',
                                    'Music'),
                   '(Action|Adventure|Arcade|Board|Card|Casino|Casual|Educational|Puzzle|Racing|Music|Role Playing|Simulation|Sports|Strategy|Trivia|Word)',
                   'Games') as Category,
           multiIf(notEmpty(extract(Size, '(\d+\.?\d+)(?:M)')),
                   toInt64(toFloat64(extract(Size, '(\d+\.?\d+)(?:M)')) / 0.000001),
                   notEmpty(extract(Size, '(\d+\.?\d+)(?:G)')),
                   toInt64(toFloat64(extract(Size, '(\d+\.?\d+)(?:G)')) / 0.000000001),
                   0)       as Size_Bytes
    from appStoreData.t_google_play
    where Category in ('Games', 'Music', 'Health')
      AND Size_Bytes > 0;
