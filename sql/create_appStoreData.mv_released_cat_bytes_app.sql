DROP TABLE IF EXISTS appStoreData.mv_released_cat_bytes_app;

CREATE MATERIALIZED VIEW IF NOT EXISTS appStoreData.mv_released_cat_bytes_app
(
    `Released` DateTime,
    `App_Id` String,
    `App_Name` String,
    `Category` String,
    `Size_Bytes` Int64,
    `Average_Rating` Float64,
    `Num_Ratings` Int64
)
ENGINE = MergeTree
ORDER BY Released
AS
SELECT `Released`,
       `App_Id`,
       `App_Name`,
       `Category`,
       `Size_Bytes`,
       `Average_Rating`,
       `Num_Ratings`
FROM appStoreData.t_released_cat_bytes_app
ORDER BY Released;