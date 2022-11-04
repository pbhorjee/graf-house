-- noinspection SqlAggregatesForFile

-- noinspection SyntaxErrorForFile

-- noinspection SyntaxErrorForFile

-- noinspection SyntaxErrorForFile

-- noinspection SyntaxErrorForFile

-- noinspection SyntaxError

SELECT DISTINCT toDateTime(toStartOfMonth(Released)) AS Month_Released, Category,
                count(*) OVER (PARTITION BY Month_Released, Category) AS `Num Released`
FROM appStoreData.t_released_cat_bytes_app
WHERE toYear(Released) > 1970
  AND Category LIKE 'Games'
ORDER BY Released DESC;

-- noinspection SyntaxError

SELECT DISTINCT toDateTime(toStartOfMonth(Released)) AS Month_Released, Category,
                count(*) OVER (PARTITION BY Month_Released, Category) AS `Num Released`
FROM appStoreData.t_released_cat_bytes_app
WHERE toYear(Released) > 1970
  AND Category LIKE 'Health'
ORDER BY Month_Released DESC;

-- noinspection SyntaxError

SELECT DISTINCT toDateTime(toStartOfMonth(Released)) AS Month_Released, Category,
                count(*) OVER (PARTITION BY Month_Released, Category) AS `Num Released`
FROM appStoreData.t_released_cat_bytes_app
WHERE toYear(Released) > 1970
  AND Category LIKE 'Music'
ORDER BY Month_Released DESC;


-- noinspection SyntaxError

SELECT toDateTime(toStartOfMonth(Released)) AS Month_Released, Category,
                count(*) OVER (PARTITION BY Month_Released, Category) AS `Num Released`
FROM appStoreData.t_released_cat_bytes_app
WHERE toYear(Released) > 1970
GROUP BY Month_Released, Category
ORDER BY Month_Released DESC;