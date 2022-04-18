/* 
VEHICLE TABLE CREATION QUERY 
2022-04-10 

Roughly based on GBFS free_bike_status.json schema,
with some version differences between providers.
See https://github.com/MobilityData/gbfs-json-schema
and District of Columbia Department of Transportation
dockless APIs https://ddot.dc.gov/page/dockless-api
*/

CREATE TABLE vehicles (
	provider TEXT NOT NULL,
	bike_id TEXT NOT NULL,
	vehicle_type TEXT,
	is_reserved BOOL,
	is_disabled BOOL,
	battery_level INT,
	lat DECIMAL(10, 8) NOT NULL,
	lon DECIMAL(11, 8) NOT NULL,
	time_scraped TIMESTAMPTZ NOT NULL
);