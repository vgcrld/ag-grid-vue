/* 

  requires clickhouse database and client

  docker pull yandex/clickhouse-server
  docker pull yandex/clickhouse-client

  -- Run this container and expost port 8123 locally
  docker run -ti --rm -p 8123:8123 --name ch-server yandex/clickhouse-server

  -- Now create the 
  docker run -it --rm --link ch-server yandex/clickhouse-client --host ch-server
*/

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

/*

https accessl

  http://localhost:8123/ping
  http://localhost:8123?query=select * from aggrid.cars FORMAT JSON

  From curl
  echo "select * from aggrid.cars FORMAT JSON" | curl http://localhost:8123/ --data-binary @-
  echo "CREATE DATABASE aggrid" | curl http://localhost:8123/ --data-binary @-
  echo "CREATE DATABASE aggrid" | curl http://localhost:8123/ --data-binary @-

*/