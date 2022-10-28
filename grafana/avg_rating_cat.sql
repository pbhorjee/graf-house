
select distinct Category,
                avg_rat as `Average Rating` from
     (SELECT Distinct Category,
            sum(mul_rat)  OVER (PARTITION BY Category) as sum_mul_ratings_cat,
             Num_Ratings,
             Average_Rating * Num_Ratings as mul_rat,
            sum(Num_Ratings) OVER (PARTITION BY Category) as sum_num_ratings_cat,
            sum_mul_ratings_cat / sum_num_ratings_cat as avg_rat
     FROM  appStoreData.t_released_cat_bytes_app);
