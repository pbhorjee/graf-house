DROP TABLE IF EXISTS appStoreData.t_apple_app_store;

CREATE TABLE IF NOT EXISTS appStoreData.t_apple_app_store
(
    App_Id                  String          DEFAULT '',
    App_Name                String          DEFAULT '',
    AppStore_Url            String          DEFAULT '',
    Primary_Genre           String          DEFAULT '',
    Content_Rating          String          DEFAULT '',
    Size_Bytes              Int64           DEFAULT 0,
    Required_IOS_Version    String          DEFAULT '',
    Released                DateTime('UTC') DEFAULT toDateTime('1970-01-01 00:00:00', 'UTC'),
    Updated Nullable(DateTime('UTC')),
    Version                 String          DEFAULT '',
    Price                   Float64         DEFAULT 0.,
    Currency                String          DEFAULT '',
    Free                    Bool            DEFAULT 0,
    DeveloperId             Int32           DEFAULT 0,
    Average_User_Rating     Float64         DEFAULT 0.,
    Developer_Url           String          DEFAULT '',
    Developer_Website       String          DEFAULT '',
    Developer               String          DEFAULT '',
    Reviews                 Int32           DEFAULT 0,
    Current_Version_Score   Float64         DEFAULT 0.,
    Current_Version_Reviews Int32           DEFAULT 0
) ENGINE = MergeTree ORDER BY Released SETTINGS index_granularity = 8192;
