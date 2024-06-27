# Podman MySQL Partition And Unique Contraint POC

> This was done on MacOS 

Based on https://github.com/diegopacheco/devops-playground/tree/master/mysql-partition

`PARTITION BY KEY()`: https://dev.mysql.com/doc/refman/8.4/en/partitioning-key.html
> Any columns used as the partitioning key must comprise part or all of the table's primary key, if the table has one

## Run

```bash
./execute-mysql-container.sh
```

## Output

```bash
Create MySQL Container with Podman
Connect to mysql client: 
mysql -uroot -ppass -h127.0.0.1 -P3306
Creating person db... 
mysql: [Warning] Using a password on the command line interface can be insecure.
..........
Creating person table with unique key and partition... 
mysql: [Warning] Using a password on the command line interface can be insecure.
..........
Find all persons
mysql: [Warning] Using a password on the command line interface can be insecure.
..........
Inserting data into person table... 
mysql: [Warning] Using a password on the command line interface can be insecure.
mysql: [Warning] Using a password on the command line interface can be insecure.
mysql: [Warning] Using a password on the command line interface can be insecure.
ERROR 1062 (23000) at line 1: Duplicate entry 'Gabriel-Passos' for key 'person.PRIMARY'
..........
Find all persons
mysql: [Warning] Using a password on the command line interface can be insecure.
id	first_name	last_name	created_at
2	Joao	Ninguem	2024-06-25 22:59:46
1	Gabriel	Passos	2024-06-25 22:59:46
..........
mysql: [Warning] Using a password on the command line interface can be insecure.
Table	Create Table
person	CREATE TABLE `person` (\n  `id` int DEFAULT NULL,\n  `first_name` varchar(255) NOT NULL,\n  `last_name` varchar(255) NOT NULL,\n  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,\n  PRIMARY KEY (`first_name`,`last_name`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci\n/*!50100 PARTITION BY KEY ()\nPARTITIONS 12 */
mysql: [Warning] Using a password on the command line interface can be insecure.
id	select_type	table	partitions	type	possible_keys	key	key_len	ref	rows	filtered	Extra
1	SIMPLE	person	p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11	ALL	NULL	NULL	NULL	NULL	2	100.00	NULL
mysql: [Warning] Using a password on the command line interface can be insecure.
id	select_type	table	partitions	type	possible_keys	key	key_len	ref	rows	filtered	Extra
1	SIMPLE	person	p5	const	PRIMARY	PRIMARY	2044	const,const	1	100.00	NULL
Stop MySQL Container with Podman
0d136cefe1b5a092797e02333d5aa5a9787a8abd7e9041152436bf4764b34cb8
DONE.
```