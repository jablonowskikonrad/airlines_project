CREATE SCHEMA IF NOT EXISTS reporting
;

CREATE VIEW reporting.flight AS
SELECT
    *,
    CASE WHEN dep_delay_new > 0 THEN 1 ELSE 0 END AS is_delayed
FROM
    flight
WHERE
    cancelled = 0
;

CREATE VIEW reporting.top_reliability_roads AS
WITH route_stats AS (
    SELECT
        f.origin_airport_id,
        a_origin.display_airport_name AS origin_airport_name,
        f.dest_airport_id,
        a_dest.display_airport_name AS dest_airport_name,
        f.year,
        COUNT(*) AS cnt,
        ROUND(AVG(CASE WHEN dep_delay_new > 0 THEN 100.0 ELSE 0.0 END), 2) AS reliability,
        ROW_NUMBER() OVER (PARTITION BY f.year ORDER BY AVG(CASE WHEN f.dep_delay_new > 0 THEN 1 ELSE 0 END)::numeric DESC) AS nb
    FROM
        flight f
	JOIN
        airport_list a_origin ON f.origin_airport_id = a_origin.origin_airport_id
    JOIN
        airport_list a_dest ON f.dest_airport_id = a_dest.origin_airport_id
    WHERE
        f.cancelled = 0
    GROUP BY
        f.origin_airport_id,
        a_origin.display_airport_name,
        f.dest_airport_id,
        a_dest.display_airport_name,
        f.year
    HAVING
        COUNT(*) > 10000
)
SELECT
    origin_airport_id,
    origin_airport_name,
    dest_airport_id,
    dest_airport_name,
    year,
    cnt,
    reliability,
    DENSE_RANK() OVER (ORDER BY reliability DESC) AS nb
FROM
    route_stats
ORDER BY
    year, nb
;

CREATE VIEW reporting.year_to_year_comparision AS
SELECT
    year,
    month,
	ROUND(AVG(CASE WHEN dep_delay_new > 0 THEN 100.0 ELSE 0.0 END), 2) AS reliability,
    COUNT(*) AS flights_amount
FROM
    flight
WHERE
    cancelled = 0
GROUP BY
    year, month
;

CREATE VIEW reporting.day_to_day_comparision AS
SELECT
    year,
    day_of_week,
    COUNT(*) AS flights_amount
FROM
    flight
WHERE
    cancelled = 0
GROUP BY
    year, day_of_week
;

CREATE VIEW reporting.day_by_day_reliability AS
SELECT
    TO_DATE(CONCAT(year, '-', LPAD(month::text, 2, '0'), '-', LPAD(day_of_month::text, 2, '0')), 'YYYY-MM-DD') AS date,
    ROUND(AVG(CASE WHEN dep_delay_new > 0 THEN 100.0 ELSE 0.0 END), 2) AS reliability
FROM
    flight
WHERE
    cancelled = 0
GROUP BY
    year, month, day_of_month
ORDER BY
    year, month, day_of_month