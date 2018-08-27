# Almanac

## Install
 - Clone current repository `git clone ...`
 - Move to almanac folder `cd almanac`
 - Copy and modify .env file `cp .env.example .env`
 - Create database: `docker-compose run api rails db:create db:migrate`
 - Start cointainers: `docker-compose up -d`
  -- `postgresql` Postgresql database
  -- `pgadmin` Pgadmin4 for pgsql interface
  -- `swagger` Swagger web server for documentation
  -- `api` Thin web server for api requests
 - Seed database. One of two ways:
  -- `docker-compose run --rm -e "DB_SEED=true" api rails db:seed` - Use database for seed
  -- `docker-compose run --rm -e "CURL_SEED=true" api rails db:seed` - Use curl for seed

## Documentations
[Swagger docs](http://localhost:8080)

# SQL

# Create table

```sql
create temp table users(id bigserial, group_id bigint);
insert into users(group_id) values (1), (1), (1), (2), (1), (3);
```

# Decision

```sql
SELECT MIN(id) as min_id, MIN(group_id) as group_id, COUNT(*)
FROM (
  SELECT *, SUM(group_row_number::int) OVER (ORDER BY id) as group_sequence_num
  FROM (
    SELECT *, CASE WHEN (LAG(group_id) OVER (ORDER BY id)) = group_id THEN 0 ELSE 1 END as group_row_number FROM users
  ) AS first_table
) AS second_table
GROUP BY group_sequence_num
ORDER BY min_id
```
