
select * from (
      SELECT toYear(Released) as Year,
             Category,
             row_number() OVER (PARTITION BY Year, Category ORDER BY Year ASC, Category ASC, Size_Bytes DESC) as Size_Rank,
             formatReadableSize(Size_Bytes) as Size,
             Size_Bytes,
             App_Name,
             App_Id
      FROM appStoreData.t_released_cat_bytes_app
      GROUP BY Year,
               Category,
               Size_Bytes,
               App_Id,
               App_Name
      ORDER BY Year DESC, Size_Bytes DESC)
where Size_Rank <= 10
  and Year > 1970
    AND Size_Bytes > 0;

