/* 
VEHICLE TABLE PARTITION QUERIES
2022-04-18 

Queries to modify daily partitions for the vehicles table.
For longer-running project, would be worth figuring out
pgpartman to avoid tedious manual partitioning.
*/

CREATE TABLE vehicles_2022_04_18 
	PARTITION OF vehicles
	FOR VALUES FROM	('2022-04-18 00:00:00-04') TO ('2022-04-19 00:00:00-04');

/* No idea why the following runs successfully in psql but the above does not. */
/* As of 2022-04-18, partitions created in AWS database but NOT in local database. */
create table vehicles_2022_04_18 partition of vehicles for values from ('2022-04-18 00:00:00-04') to ('2022-04-19 00:00:00-04');
create table vehicles_2022_04_19 partition of vehicles for values from ('2022-04-19 00:00:00-04') to ('2022-04-20 00:00:00-04');
create table vehicles_2022_04_20 partition of vehicles for values from ('2022-04-20 00:00:00-04') to ('2022-04-21 00:00:00-04');
create table vehicles_2022_04_21 partition of vehicles for values from ('2022-04-21 00:00:00-04') to ('2022-04-22 00:00:00-04');
create table vehicles_2022_04_22 partition of vehicles for values from ('2022-04-22 00:00:00-04') to ('2022-04-23 00:00:00-04');
create table vehicles_2022_04_23 partition of vehicles for values from ('2022-04-23 00:00:00-04') to ('2022-04-24 00:00:00-04');
create table vehicles_2022_04_24 partition of vehicles for values from ('2022-04-24 00:00:00-04') to ('2022-04-25 00:00:00-04');
create table vehicles_2022_04_25 partition of vehicles for values from ('2022-04-25 00:00:00-04') to ('2022-04-26 00:00:00-04');
create table vehicles_2022_04_26 partition of vehicles for values from ('2022-04-26 00:00:00-04') to ('2022-04-27 00:00:00-04');
create table vehicles_2022_04_27 partition of vehicles for values from ('2022-04-27 00:00:00-04') to ('2022-04-28 00:00:00-04');
create table vehicles_2022_04_28 partition of vehicles for values from ('2022-04-28 00:00:00-04') to ('2022-04-29 00:00:00-04');
create table vehicles_2022_04_29 partition of vehicles for values from ('2022-04-29 00:00:00-04') to ('2022-04-30 00:00:00-04');
create table vehicles_2022_04_30 partition of vehicles for values from ('2022-04-30 00:00:00-04') to ('2022-05-01 00:00:00-04');
create table vehicles_2022_05_01 partition of vehicles for values from ('2022-05-01 00:00:00-04') to ('2022-05-02 00:00:00-04');

/* Detach partition in preparation for moving to local database. */
alter table vehicles detach partition vehicles_2022_04_18 concurrently;

/* Attach partition to parent table after detaching. */
alter table vehicles attach partition vehicles_2022_04_18 for values from ('2022-04-18 00:00:00-04') to ('2022-04-19 00:00:00-04');

/* List all partitions associated with vehicles table. */
select * from pg_partition_tree('vehicles');