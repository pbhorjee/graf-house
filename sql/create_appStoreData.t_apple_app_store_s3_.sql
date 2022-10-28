DROP TABLE IF EXISTS appStoreData.t_apple_app_store_s3;

create table IF NOT EXISTS appStoreData.t_apple_app_store_s3
(
    App_Id                  String,
    App_Name                String,
    AppStore_Url            String,
    Primary_Genre           String,
    Content_Rating          String,
    Size_Bytes              Int64,
    Required_IOS_Version    String,
    Released                DateTime('UTC'),
    Updated                 Nullable(DateTime('UTC')),
    Version                 String,
    Price                   Float64,
    Currency                String,
    Free                    Bool,
    DeveloperId             Int32,
    Developer_Url           String,
    Developer_Website       String,
    Developer               String,
    Average_User_Rating     Float64,
    Reviews                 Int32,
    Current_Version_Score   Float64,
    Current_Version_Reviews Int32
)
ENGINE = S3('https://app-store-data-graf-house.s3.amazonaws.com/appleAppData.csv.gz', 'CSVWithNames', 'gzip')
SETTINGS input_format_allow_errors_num=1000,
    date_time_input_format='best_effort';
