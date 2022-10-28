SELECT toStartOfMonth(Released) as Month_Released,
       round(Size_Bytes, -4)    as Size_Bytes
FROM appStoreData.t_released_cat_bytes_app
WHERE Category = 'Music'
  and Size_Bytes > 0
  and toYear(Month_Released) > 1970
ORDER BY rand()
LIMIT 1000;

SELECT toStartOfMonth(Released) as Month_Released,
       round(Size_Bytes, -4)    as Size_Bytes
FROM appStoreData.t_released_cat_bytes_app
WHERE Category = 'Health'
  and Size_Bytes > 0
  and toYear(Month_Released) > 1970
ORDER BY rand()
LIMIT 1000;

SELECT toStartOfMonth(Released) as Month_Released,
       round(Size_Bytes, -4)    as Size_Bytes
FROM appStoreData.t_released_cat_bytes_app
WHERE Category = 'Games'
  and Size_Bytes > 0
  and toYear(Month_Released) > 1970
ORDER BY rand()
LIMIT 1000;