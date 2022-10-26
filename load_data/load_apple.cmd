clickhouse-client --host localhost --port 9000 --user default --password --database appStoreData --input_format_allow_errors_num=1000 --date_time_input_format 'best_effort' \
 --query "
 INSERT INTO t_apple_app_store
 SELECT App_Id, App_Name, AppStore_Url, Primary_Genre, Content_Rating, Size_Bytes,
  Required_IOS_Version, Released, Updated, Version, Price, Currency, Free, DeveloperId,
  Average_User_Rating, Developer_Url, Developer_Website, Developer, Reviews,
  Current_Version_Score, Current_Version_Reviews
 FROM input('App_Id String,
    App_Name String,
    AppStore_Url String,
    Primary_Genre  String,
    Content_Rating String,
    Size_Bytes Int64,
    Required_IOS_Version String,
    Released DateTime(\'UTC\'),
    Updated Nullable(DateTime(\'UTC\')),
    Version String,
    Price Float64  ,
    Currency String,
    Free  Bool ,
    DeveloperId Int32,
    Average_User_Rating  Float64,
    Developer_Url  String,
    Developer_Website String,
    Developer String,
    Reviews Int32,
    Current_Version_Score Float64,
    Current_Version_Reviews Int32')
 FORMAT CSVWithNames
" < appleAppData.csv