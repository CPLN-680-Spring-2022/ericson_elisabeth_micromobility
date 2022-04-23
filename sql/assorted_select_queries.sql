/*
ASSORTED SELECT QUERIES

Queries to select various subsets and aggregations.
*/

/* NOTE: Need to cast times to timezone-naive to work with Pandas! */
CAST(time_scraped AS timestamp)


/* duration by ID (not split) */
SELECT 
	provider, 
	bike_id, 
	MIN(time_scraped) AS min_time, 
	MAX(time_scraped) AS max_time,
	MAX(time_scraped) - MIN(time_scraped) AS duration
FROM vehicles
WHERE time_scraped > '2022-04-18 02:00:00-04' 
AND time_scraped < '2022-04-19 04:00:00-04'
GROUP BY provider, bike_id
ORDER BY duration DESC;


/* max ID duration by provider (in one day) */
SELECT provider, MAX(duration) AS max_duration
FROM (
	SELECT 
		provider, 
		bike_id, 
		MIN(time_scraped) AS min_time, 
		MAX(time_scraped) AS max_time,
		MAX(time_scraped) - MIN(time_scraped) AS duration
	FROM vehicles
	WHERE time_scraped >= '2022-04-19 00:00:00-04' 
	AND time_scraped < '2022-04-20 00:00:00-04'
	GROUP BY provider, bike_id
	ORDER BY duration DESC
	) AS temp
GROUP BY provider
ORDER BY max_duration;

/* bounding box and duration by ID */
/* THIS DIDN'T WORK */
SELECT 
	provider,
	bike_id,
	CAST(MIN(time_scraped) AS timestamp) AS min_time, 
	CAST(MAX(time_scraped) AS timestamp) AS max_time,
	MAX(time_scraped) - MIN(time_scraped) AS duration,
	ST_Envelope(geometry) AS bbox
FROM vehicles
WHERE provider = 'Lime'
GROUP BY bike_id
ORDER BY duration DESC;

/* extent by ID */
SELECT 
	provider,
	bike_id,
	MAX(time_scraped) - MIN(time_scraped) AS duration,
	ST_Collect(geometry) AS geometries
FROM vehicles
WHERE provider = 'Lime'
GROUP BY bike_id
ORDER BY duration DESC;