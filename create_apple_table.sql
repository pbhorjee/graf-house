DROP TABLE IF EXISTS appStoreData.appleAppData;

create table IF NOT EXISTS appStoreData.appleAppData
(
    App_Id                  String          default '',
    App_Name                String          default '',
    AppStore_Url            String          default '',
    Primary_Genre           String          default '',
    Content_Rating          String          default '',
    Size_Bytes              Int64           default 0,
    Required_IOS_Version    String          default '',
    Released                DateTime('UTC') default toDateTime('1970-01-01 00:00:00', 'UTC'),
    Updated                 Nullable(DateTime('UTC')),
    Version                 String          default '',
    Price                   Float64         default 0.,
    Currency                String          default '',
    Free                    Bool            default 0,
    DeveloperId             Int32           default 0,
    Average_User_Rating     Float64         default 0.,
    Developer_Url           String          default '',
    Developer_Website       String          default '',
    Developer               String          default '',
    Reviews                 Int32           default 0,
    Current_Version_Score   Float64         default 0.,
    Current_Version_Reviews Int32           default 0
)
engine = MergeTree
ORDER BY Released
SETTINGS index_granularity = 8192;
