---
title: "sql commands"
date: 2000-01-01
tags: [foo, bar]
---


## 1. Database Commands

|Command|Description|
|---|---|
|`CREATE DATABASE db_name;`|Create a new database|
|`USE db_name;`|Switch to a database|
|`DROP DATABASE db_name;`|Delete a database permanently|
|`ALTER DATABASE db_name READ ONLY = 1;`|Set database to read-only (may not be supported in all versions)|
|`ALTER DATABASE db_name CHARACTER SET utf8;`|Change database character set|
|`SHOW DATABASES;`|List all databases|

---

##  2. Table Commands

|Command|Description|
|---|---|
|`CREATE TABLE table_name (columns);`|Create a new table|
|`ALTER TABLE table_name ADD column_name datatype;`|Add a new column|
|`ALTER TABLE table_name DROP COLUMN column_name;`|Remove a column|
|`ALTER TABLE table_name MODIFY column_name datatype;`|Change column datatype|
|`DROP TABLE table_name;`|Delete table|
|`TRUNCATE TABLE table_name;`|Delete all rows but keep table structure|
|`DESCRIBE table_name;` / `SHOW COLUMNS FROM table_name;`|Show table structure|

---

## 3. View Commands

|Command|Description|
|---|---|
|`CREATE VIEW view_name AS SELECT ...;`|Create a view|
|`SELECT * FROM view_name;`|Query a view|
|`DROP VIEW view_name;`|Delete a view|
|`SHOW FULL TABLES WHERE Table_type = 'VIEW';`|List all views in database|
|`ALTER VIEW view_name AS SELECT ...;`|Modify existing view|

---

## 4. Index Commands

|Command|Description|
|---|---|
|`CREATE INDEX idx_name ON table_name(column_name);`|Create an index on a column|
|`CREATE UNIQUE INDEX idx_name ON table_name(column_name);`|Create unique index|
|`CREATE INDEX idx_name ON table_name(column1, column2);`|Multi-column index|
|`SHOW INDEX FROM table_name;`|Display all indexes of a table|
|`DROP INDEX idx_name ON table_name;`|Delete an index|

---

## 5. Stored Procedure Commands

|Command|Description|
|---|---|
|`CREATE PROCEDURE proc_name() BEGIN ... END;`|Create a procedure|
|`CALL proc_name();`|Execute a procedure|
|`DROP PROCEDURE proc_name;`|Delete a procedure|
|`CREATE PROCEDURE proc_name(IN param INT, OUT out_param INT) BEGIN ... END;`|Procedure with parameters|

---

## 7. Trigger Commands

|Command|Description|
|---|---|
|`CREATE TRIGGER trig_name BEFORE/AFTER INSERT/UPDATE/DELETE ON table_name FOR EACH ROW ...;`|Create trigger|
|`DROP TRIGGER trig_name;`|Delete trigger|
|`SHOW TRIGGERS;`|List all triggers in the current database|

---

## 7️. Miscellaneous Useful Commands

|Command|Description|
|---|---|
|`SHOW TABLES;`|List all tables in current database|
|`SHOW DATABASES;`|List all databases|
|`SHOW CREATE TABLE table_name;`|Show exact CREATE TABLE SQL statement|
|`SHOW CREATE VIEW view_name;`|Show exact CREATE VIEW SQL statement|
|`SHOW CREATE PROCEDURE proc_name;`|Show stored procedure code|
|`SHOW CREATE TRIGGER trig_name;`|Show trigger code|

---

