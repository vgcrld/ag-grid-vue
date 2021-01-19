# Setup Containers for a test environment

It's easy to get clickhouse up and running using the yandex provided servers
on docker hub.

You need to make sure you already have docker running on your mac/windows system.

## Get the containers

Get clickhouse containers from hub.docker.com

These are the Yandex provided containers.  All ready to go.

```shell
docker pull yandex/clickhouse-server
docker pull yandex/clickhouse-client
```

## Star the Containers

Run the client and server with the ports exposed

```shell
docker run -ti --rm -p 8123:8123 --name ch-server yandex/clickhouse-server
docker run -it --rm --link ch-server --name ch-client yandex/clickhouse-client --host ch-server
```

## Create a test Database

These are just some examples for clickhouse. here we are creating a database called
aggrid.cars and pushing some data in.  Five columns including an automatic ID generation
and an Array(String) for tags.

```sql
-- Drop and create new 
DROP DATABASE aggrid
CREATE DATABASE aggrid

-- Drop and Create new
CREATE TABLE aggrid.cars ( id String, make String, model String, price Float64, tags Array(String) ) ENGINE = MergeTree() PRIMARY KEY id

-- Insert some data in
INSERT INTO aggrid.cars (id, make, model, price, tags) 
VALUES 
  (generateUUIDv4(), 'Toyota', 'bob', 33400, ['import']), 
  (generateUUIDv4(), 'Ford', 'Fusion', 16500, ['domestic']), 
  (generateUUIDv4(), 'Porsche', '911 Turbo', 118000, ['import', 'exotic'])


SELECT * from aggrid.cars

-- Cleanup 
ALTER TABLE cars DELETE WHERE make = 'Ford'

ALTER TABLE cars UPDATE make  = 'Honda' where id = '03a54a6a-4334-42c9-8fca-ca1258059901'
ALTER TABLE cars UPDATE price = 216000 where id = 'cb64b7b9-9e0a-4c31-9272-3f41b8109ccc'

-- Cleanup an entire columne
ALTER TABLE cars CLEAR COLUMN price
```