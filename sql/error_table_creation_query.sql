/* 
ERROR TABLE CREATION QUERY 
2022-04-16

Table for logging scraper errors.
*/

CREATE TABLE errors (
	time_scraped TIMESTAMPTZ NOT NULL,
	provider TEXT NOT NULL,
	time_failed TIMESTAMPTZ NOT NULL,
	traceback TEXT NOT NULL
);