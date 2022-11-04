SELECT DISTINCT Category, avg_rat AS `Average Rating`
FROM (SELECT DISTINCT Category, sum(mul_rat) OVER (PARTITION BY Category) AS sum_mul_ratings_cat, Num_Ratings,
                      Average_Rating * Num_Ratings AS mul_rat,
                      sum(Num_Ratings) OVER (PARTITION BY Category) AS sum_num_ratings_cat,
                      sum_mul_ratings_cat / sum_num_ratings_cat AS avg_rat
      FROM appStoreData.t_released_cat_bytes_app);
