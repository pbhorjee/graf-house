SELECT *
FROM (SELECT toYear(Released) AS Year, Category,
             row_number() OVER (PARTITION BY Year, Category ORDER BY YEAR ASC, Category ASC, Size_Bytes DESC) AS Size_Rank,
             formatReadableSize(Size_Bytes) AS Size, Size_Bytes, App_Name, App_Id
      FROM appStoreData.t_released_cat_bytes_app
      GROUP BY Year, Category, Size_Bytes, App_Id, App_Name
      ORDER BY Year DESC, Size_Bytes DESC)
WHERE Size_Rank <= 10
  AND Year > 1970
  AND Size_Bytes > 0;

