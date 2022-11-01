DROP TABLE IF EXISTS appStoreData.t_google_play;

CREATE TABLE IF NOT EXISTS appStoreData.t_google_play
(
    `App Name`          String  DEFAULT '',
    `App Id`            String  DEFAULT '',
    Category            String  DEFAULT '',
    Rating              Float64 DEFAULT 0.,
    `Rating Count`      Int32   DEFAULT 0,
    Installs            String  DEFAULT '',
    `Minimum Installs`  Int64   DEFAULT 0,
    `Maximum Installs`  Int64   DEFAULT 0,
    Free                Bool    DEFAULT FALSE,
    Price               Float64 DEFAULT 0.,
    Currency            String  DEFAULT '',
    Size                String  DEFAULT '',
    `Minimum Android`   String  DEFAULT '',
    `Developer Id`      String  DEFAULT '',
    `Developer Website` String  DEFAULT '',
    `Developer Email`   String  DEFAULT '',
    Released            Date    DEFAULT toDate('1970-01-01'),
    `Last Updated` Nullable(Date),
    `Content Rating`    String  DEFAULT '',
    `Privacy Policy`    String  DEFAULT '',
    `Ad Supported`      Bool    DEFAULT FALSE,
    `In App Purchases`  Bool    DEFAULT FALSE,
    `Editors Choice`    Bool    DEFAULT FALSE,
    `Scraped Time` Nullable(DateTime('UTC'))
) ENGINE = MergeTree ORDER BY Released SETTINGS index_granularity = 8192;
