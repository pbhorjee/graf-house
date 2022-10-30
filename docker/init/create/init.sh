#!/bin/bash
set -e

clickhouse-client -n <<-'EOSQL'
    CREATE DATABASE appStoreData;
    
    create table appStoreData.t_apple_app_store_s3
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
    )
    ENGINE = S3('https://app-store-data-graf-house.s3.amazonaws.com/Google-Playstore.csv.gz', 'CSVWithNames', 'gzip')
    SETTINGS input_format_allow_errors_num = 1000,
        date_time_input_format = 'best_effort';

        
    CREATE TABLE IF NOT EXISTS appStoreData.t_released_cat_bytes_app
    (
        `Released` DateTime('UTC'),
        `App_Id` String,
        `App_Name` String,
        `Category` String,
        `Size_Bytes` Int64,
        `Average_Rating` Float64,
        `Num_Ratings` Int64
    )
    ENGINE = MergeTree
    ORDER BY Released;


    Insert into appStoreData.t_released_cat_bytes_app
    SELECT Released,
        App_Id,
        App_Name,
        Primary_Genre       as Category,
        Size_Bytes,
        Average_User_Rating as Average_Rating,
        Reviews             as Num_Ratings
    FROM appStoreData.t_apple_app_store_s3
    WHERE Category in ('Games', 'Music', 'Health')
    AND Size_Bytes > 0
    UNION ALL
    select parseDateTimeBestEffortOrZero(concat(splitByNonAlpha(Released)[2], '-', splitByNonAlpha(Released)[1], '-',
                                                splitByNonAlpha(Released)[3])) as Released,
        `App Id`                                                                        as App_Id,
        `App Name`                                                                      as App_Name,
        replaceRegexpOne(
                replaceRegexpOne(replaceRegexpOne(Category, '(Health & Fitness)', 'Health'), '(Music & Audio)', 'Music'),
                '(Action|Adventure|Arcade|Board|Card|Casino|Casual|Educational|Puzzle|Racing|Music|Role Playing|Simulation|Sports|Strategy|Trivia|Word)',
                'Games')                                                                as Category,
        multiIf(notEmpty(extract(Size, '(\d+\.?\d+)(?:M)')),
                toInt64(toFloat64(extract(Size, '(\d+\.?\d+)(?:M)')) / 0.000001),
                notEmpty(extract(Size, '(\d+\.?\d+)(?:G)')),
                toInt64(toFloat64(extract(Size, '(\d+\.?\d+)(?:G)')) / 0.000000001), 0) as Size_Bytes,
        Rating                                                                          as Average_Rating,
        `Rating Count`                                                                  as Num_Ratings
    from appStoreData.t_google_play_s3
    where Category in ('Games', 'Music', 'Health')
    SETTINGS input_format_allow_errors_num = 1000
        , date_time_input_format = 'best_effort';

EOSQL