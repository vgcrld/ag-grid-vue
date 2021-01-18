#!/bin/sh

# HTTP command to clickhouse
curl_cmd="curl http://localhost:8123 --data-binary @-"

# Setup commands
drop_database="DROP DATABASE IF EXISTS aggrid"
create_database="CREATE DATABASE aggrid"
create_table="CREATE TABLE aggrid.cars ( id String, make String, model String, price Float64, tags Array(String) ) ENGINE = MergeTree() PRIMARY KEY id"

# Run setup
eval "echo '$drop_database' | $curl_cmd"
eval "echo '$create_database' | $curl_cmd"
eval "echo '$create_table' | $curl_cmd"

# Add some data
cat <<EOF | $curl_cmd
INSERT INTO aggrid.cars 
  (id, make, model, price, tags) 
  VALUES 
    (generateUUIDv4(), 'Toyota', 'Camry', 33400, ['import']),
    (generateUUIDv4(), 'Ford', 'Ranger', 12400, ['domestic']),
    (generateUUIDv4(), 'Porsche', '911 Turbo', 123400, ['import', 'exotic']),
    (generateUUIDv4(), 'Toyota', 'Tacoma', 48400, ['import', 'truck']),
    (generateUUIDv4(), 'Ford', 'Focus', 8400, ['domestic','car', 'used']),
    (generateUUIDv4(), 'Porsche', 'Cayene', 92400, ['import', 'suv']),
    (generateUUIDv4(), 'Honda', 'Civic', 23400, ['import','car','used']),
    (generateUUIDv4(), 'Lexus', 'ct200h', 28300, ['domestic','hybryd','car','used']),
    (generateUUIDv4(), 'Rolls Royce', 'Phaeton', 1400622, ['import', 'exotic'])
EOF


