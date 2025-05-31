-- show databases in the server
SHOW DATABASES;

-- create a new database
-- CREATE DATABASE <name of database>
CREATE DATABASE swimming_coach;

-- set the current active database
-- USE <name of database>
USE swimming_coach;

-- CREATE TABLE <name of table> ( <column name> <data type> <options>, <column 2 name> <data type> <options)
create table parents (
    parent_id int unsigned primary key auto_increment,
    name varchar(100) not null,
    contact_number varchar(20) not null,
    address varchar(500) not null
) engine = innodb;

-- show all tables in the current active database
SHOW TABLES;

-- show the columns of a table
DESCRIBE parents;