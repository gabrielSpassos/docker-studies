#!/bin/bash

echo "Create MySQL Container with Podman"
CONTAINER_ID=$(podman run --rm --detach --env MYSQL_ROOT_PASSWORD=pass -p 3306:3306 --name mysql_partition_poc arm64v8/mysql:latest)
echo "Connect to mysql client: "
echo "mysql -uroot -ppass -h127.0.0.1 -P3306"

sleep 10
echo "Creating person db... "
echo "CREATE DATABASE db;" | mysql -uroot -ppass -h127.0.0.1 -P3306
echo ".........."

sleep 3
echo "Creating person table with unique key and partition... "
echo "use db; CREATE TABLE IF NOT EXISTS person (
      id INT,
      first_name VARCHAR(255) NOT NULL,
      last_name VARCHAR(255) NOT NULL,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      PRIMARY KEY(first_name,last_name)
    ) PARTITION BY KEY() 
    PARTITIONS 12;" | mysql -uroot -ppass -h127.0.0.1 -P3306
echo ".........."

sleep 3
echo "Find all persons"
echo "use db; select * from person" | mysql -uroot -ppass -h127.0.0.1 -P3306
echo ".........."

echo "Inserting data into person table... "
echo "use db; insert into person (id,first_name,last_name) values (1,'Gabriel','Passos');" | mysql -uroot -ppass -h127.0.0.1 -P3306
echo "use db; insert into person (id,first_name,last_name) values (2,'Joao','Ninguem');" | mysql -uroot -ppass -h127.0.0.1 -P3306
echo "use db; insert into person (id,first_name,last_name) values (3,'Gabriel','Passos');" | mysql -uroot -ppass -h127.0.0.1 -P3306
echo ".........."

echo "Find all persons"
echo "use db; select * from person" | mysql -uroot -ppass -h127.0.0.1 -P3306
echo ".........."

echo "use db; SHOW CREATE TABLE person;" | mysql -uroot -ppass -h127.0.0.1 -P3306

echo "use db; EXPLAIN select * from person;" | mysql -uroot -ppass -h127.0.0.1 -P3306

echo "use db; EXPLAIN select * from person where first_name = 'Gabriel' and last_name = 'Passos';" | mysql -uroot -ppass -h127.0.0.1 -P3306

echo "Stop MySQL Container with Podman" 
podman container stop $CONTAINER_ID

echo "DONE."