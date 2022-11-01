DROP TABLE IF EXISTS appStoreData.mv_released_cat_bytes_app;

CREATE MATERIALIZED VIEW IF NOT EXISTS appStoreData.mv_released_cat_bytes_app
            (released DateTime, app_id String, app_name String, category String,
             size_bytes Int64, average_rating Float64, num_ratings Int64) ENGINE = MergeTree ORDER BY Released
AS
SELECT released, app_id, app_name, category, size_bytes, average_rating, num_ratings
FROM appStoreData.t_released_cat_bytes_app
ORDER BY Released;