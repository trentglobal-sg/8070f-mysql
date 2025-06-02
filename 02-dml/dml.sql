-- The DML is C, U and D of CRUD for the ROWS in the table
-- C = Create --> INSERT INTO
-- U = Update --> UPDATE
-- D = Delete --> DELETE FROM

-- INSERT INTO allows us to add a new row to a table
-- INSERT INTO <table name> (<col1>, <col2>, <col3>) VALUES (<value1>, <valule2>, <value3>)
INSERT INTO parents (name, contact_number, address) VALUES ("Jon Snow", "1231234", "Somewhere Street");

-- We try to BATCH PROCESSING with databases whenever possible
INSERT INTO parents (name, contact_number, address) VALUES
    ("Peter Barker", "7127123", "New York City"),
    ("Tony Stare", "4564561", "Avenger Tower");

INSERT INTO students (name, gender, swimming_grade, date_of_birth, parent_id) VALUES
  ("Mary Barker", "F", NULL, "2023-01-02", 3),
  ("James Stare", "M", 1, "2023-04-05", 2);

CREATE TABLE venues (
 venue_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(100) NOT NULL,
 capacity INT UNSIGNED DEFAULT 10
) engine = innodb;

INSERT INTO venues (name)  VALUES ('Yishun Swimming Complex');

-- UPDATE EXISTING ROWS
-- UPDATE <table name> SET col1=val1, col2=val2... WHERE <some col>=<some value>
UPDATE parents
SET contact_number=98754321
WHERE parent_id=2;

-- DELETE EXISTING ROWS
-- DELETE FROM <table name> WHERE <some col>=<some value>
DELETE FROM parents WHERE parent_id = 2;

-- We can try to update the primary key of a row after it has been used
--UPDATE parents SET parent_id=5 WHERE parent_id=2;

INSERT INTO students (name, gender, swimming_grade, date_of_birth, parent_id) VALUES
  ("John Cena", "M", NULL, "2023-01-02", 1);

UPDATE students SET parent_id=2 WHERE student_id=5;