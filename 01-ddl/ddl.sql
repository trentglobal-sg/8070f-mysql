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

-- create the student table
create table students (
 student_id int unsigned primary key auto_increment,
 name varchar(100) not null,
 gender varchar(2) not null,
 swimming_grade tinyint unsigned DEFAULT 0,
 date_of_birth datetime
) engine = innodb;

-- ALTER TABLE:MODIFY COLUMN: make changes to the columns of an existing table
alter table students modify column date_of_birth datetime not null;

-- ALTER TABLE:ADD COLUMN: add a new column to a table
alter table students add column parent_id int unsigned not null;

-- ALTER TABLE: ADD CONSTRAINT
-- configure students.parent_id column as FK to parents.parent_id column
alter table students add constraint fk_parents_students
      foreign key (parent_id) references parents(parent_id);

-- INSERTing rows into a table (Data Manipulation Language)
insert into parents (name, contact_number, address) values ("Tan Ah Kow", "1231234", "Yishun Ring Road");

-- We use the DQL (Data Query Language) to see the content of a table
select * FROM parents;

-- INSERT A student; every student needs a FK to the parent
insert into students (name, gender, swimming_grade, date_of_birth, parent_id)
 values ("Tan Ah Mew", "f", 1, "2024-05-31", 1);

 -- add a temporary students that is to be deleted
 alter table students add column test varchar(100);

-- ALTER TABLE: DROP COLUMN
 -- to delete a column
 alter table students drop column test;


 -- DDL
 -- CREATE TABLE
 -- ALTER TABLE
 -- - add colulmn
 -- - modify column
 -- - drop column
 -- DROP TABLE