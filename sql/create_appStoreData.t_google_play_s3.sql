-- noinspection SqlResolveForFile

DROP TABLE IF EXISTS appStoreData.t_google_play_s3;

-- noinspection SqlResolve

CREATE TABLE IF NOT EXISTS appStoreData.t_google_play_s3
(
    `App Name`          String,
    `App Id`            String,
    Category            String,
    Rating              Float64,
    `Rating Count`      Int32,
    Installs            String,
    `Minimum Installs`  Int64,
    `Maximum Installs`  Int64,
    Free                Bool,
    Price               Float64,
    Currency            String,
    Size                String,
    `Minimum Android`   String,
    `Developer Id`      String,
    `Developer Website` String,
    `Developer Email`   String,
    Released            String,
    `Last Updated`      String,
    `Content Rating`    String,
    `Privacy Policy`    String,
    `Ad Supported`      Bool,
    `In App Purchases`  Bool,
    `Editors Choice`    Bool,
    `Scraped Time`      String
) ENGINE = S3('https://app-store-data-graf-house.s3.amazonaws.com/Google-Playstore.csv.gz', 'CSVWithNames',
           'gzip') SETTINGS input_format_allow_errors_num = 1000, date_time_input_format = 'best_effort';