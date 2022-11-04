DROP FUNCTION IF EXISTS BYTE_SIZED;

CREATE FUNCTION BYTE_SIZED AS(Size) ->
    multiIf(notEmpty(extract(Size, '(\d+\.?\d+)(?:M)')),
                toInt64(toFloat64(extract(Size, '(\d+\.?\d+)(?:M)')) / 0.000001),
           notEmpty(extract(Size, '(\d+\.?\d+)(?:G)')),
                toInt64(toFloat64(extract(Size, '(\d+\.?\d+)(?:G)')) / 0.000000001),
           0);

DROP FUNCTION IF EXISTS CAT_REPLACE;

CREATE FUNCTION CAT_REPLACE AS(Category) ->
    replaceRegexpOne(
        replaceRegexpOne(
            replaceRegexpOne(Category, '(Health & Fitness)', 'Health'),
        '(Music & Audio)', 'Music'),
    '(Action|Adventure|Arcade|Board|Card|Casino|Casual|Educational|Puzzle|Racing|Music|Role Playing|Simulation|Sports|Strategy|Trivia|Word)', 'Games');

DROP FUNCTION IF EXISTS DATETIME_FROM_GOOG_DATE;

CREATE FUNCTION DATETIME_FROM_GOOG_DATE AS (Released) ->
    parseDateTimeBestEffortOrZero(
        concat(splitByNonAlpha(Released)[2], '-',
            splitByNonAlpha(Released)[1], '-',
            splitByNonAlpha(Released)[3]));