SELECT toStartOfMonth(Released) AS Month_Released, round(Size_Bytes, -4) AS Size_Bytes
FROM appStoreData.t_released_cat_bytes_app
WHERE Category = 'Music'
  AND Size_Bytes > 0
  AND toYear(Month_Released) > 1970
ORDER BY rand()
LIMIT 1000;

SELECT toStartOfMonth(Released) AS Month_Released, round(Size_Bytes, -4) AS Size_Bytes
FROM appStoreData.t_released_cat_bytes_app
WHERE Category = 'Health'
  AND Size_Bytes > 0
  AND toYear(Month_Released) > 1970
ORDER BY rand()
LIMIT 1000;

SELECT toStartOfMonth(Released) AS Month_Released, round(Size_Bytes, -4) AS Size_Bytes
FROM appStoreData.t_released_cat_bytes_app
WHERE Category = 'Games'
  AND Size_Bytes > 0
  AND toYear(Month_Released) > 1970
ORDER BY rand()
LIMIT 1000;