DROP TABLE IF EXISTS appStoreData.googleAppData;

CREATE TABLE IF NOT EXISTS appStoreData.googleAppData
(
    `App Name`          String  default '',
    `App Id`            String  default '',
    Category            String  default '',
    Rating              Float64 default 0.,
    `Rating Count`      Int32   default 0,
    Installs            String  default '',
    `Minimum Installs`  Int64   default 0,
    `Maximum Installs`   Int64   default 0,
    Free                Bool    default false,
    Price               Float64 default 0.,
    Currency            String  default '',
    Size                String  default '',
    `Minimum Android`   String  default '',
    `Developer Id`      String  default '',
    `Developer Website` String  default '',
    `Developer Email`   String  default '',
    Released            Date    default toDate('1970-01-01'),
    `Last Updated` 	    Nullable(Date),
    `Content Rating`    String  default '',
    `Privacy Policy`    String  default '',
    `Ad Supported`      Bool default false,
    `In App Purchases`  Bool default false,
    `Editors Choice`    Bool default false,
    `Scraped Time` 	    Nullable(DateTime('UTC'))
)
engine = MergeTree
ORDER BY Released
SETTINGS index_granularity = 8192;
