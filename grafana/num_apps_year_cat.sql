
SELECT distinct toDateTime(toStartOfMonth(Released))                  as Month_Released,
                Category,
                count(*) OVER (PARTITION BY Month_Released, Category) as `Num Released`
FROM appStoreData.t_released_cat_bytes_app
where toYear(Released) > 1970
  and Category like 'Games'
ORDER BY Released DESC;

SELECT distinct toDateTime(toStartOfMonth(Released))                  as Month_Released,
                Category,
                count(*) OVER (PARTITION BY Month_Released, Category) as `Num Released`
FROM appStoreData.t_released_cat_bytes_app
where toYear(Released) > 1970
  and Category like 'Health'
ORDER BY Released DESC;

SELECT distinct toDateTime(toStartOfMonth(Released))                  as Month_Released,
                Category,
                count(*) OVER (PARTITION BY Month_Released, Category) as `Num Released`
FROM appStoreData.t_released_cat_bytes_app
where toYear(Released) > 1970
  and Category like 'Music'
ORDER BY Released DESC;
