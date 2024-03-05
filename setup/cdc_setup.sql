-- CDC set up script on PostgreSQL (run the queries against the database where the respective tables are stored).

-- 1: ensure logical replication has been turned on
select name, setting from pg_settings where name in ('wal_level', 'rds.logical_replication');

-- 2: create replication slot for db
select pg_create_logical_replication_slot('airbyte_slot', 'pgoutput');

-- 3: ensure replication slot has been created
select * from pg_replication_slots;

-- 4: check publication tables in db (should be empty)
select * from pg_publication_tables;

-- 5: add the replication identity for each table in db
alter table actor replica identity default;
alter table address replica identity default;
alter table category replica identity default;
alter table city replica identity default;
alter table country replica identity default;
alter table customer replica identity default;
alter table film replica identity default;
alter table film_actor replica identity default;
alter table film_category replica identity default;
alter table inventory replica identity default;
alter table language replica identity default;
alter table payment replica identity default;
alter table rental replica identity default;
alter table staff replica identity default;
alter table store replica identity default;

-- 6. create the postgres publication for all tables in db
create publication airbyte_publication for table actor, address, category, city, country, customer, film, film_actor, film_category, inventory, language, payment, rental, staff, store;

-- 7: check again the publication tables in db (should have 15 rows)
select * from pg_publication_tables;
