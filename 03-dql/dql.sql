-- SELECT all the rows and all the columns from a table
SELECT * FROM employees;

-- to extract specific columns, we say SELECT <col1>, <col2> ... FROM <table name>
SELECT firstName, lastName, email FROM employees;

-- to extract specific columns, we say SELECT <col1>, <col2> ... FROM <table name>
-- SELECT will return a temporary table
SELECT firstName AS "First Name", lastName AS "Last Name", email AS "Email" FROM employees;

-- Show all the customers but only their customer name, contact last name, 
-- contact first name and phone
SELECT customerName AS "Customer Name", 
       contactLastName AS "Contact Last Name", 
	   contactFirstName AS "Contact First Name", 
	   phone AS "Phone Number"
FROM customers;

-- Find all employees with officeCode 1
SELECT * FROM employees WHERE officeCode=1;

-- Find all employees with officeCode 1 and only show the firstName, lastName and email column s
SELECT firstName, lastName, email FROM employees WHERE officeCode=1;

-- show the customerName, contact first name, contact last name and phone number
-- for customers whose credit limit is above 10K
SELECT customerName, contactFirstName, contactLastName, phone FROM customers
WHERE creditLimit > 10000;

-- We want to invite the entire sales department
-- LIKE allows us to match by a string pattern
-- the % is a WILDCARD. It means ANY CHAACTERS
SELECT * FROM employees WHERE jobTitle LIKE "%sales%";

-- Find all the orders that has complaints or disputes
SELECT * FROM orders WHERE comments LIKE "%complaint%" OR comments LIKE "%dispute%";

-- Matching with an array
SELECT * FROM customers WHERE country IN ("France","USA","Norway");

-- OR
-- Find all customers from USA or with credit limit > 10K
SELECT * FROM customers WHERE country="USA" OR creditLimit > 10000;

-- Find all the products that have than 5000 units in stock
-- and the buy price is above 30
-- sorting in SQL done with ORDER BY
-- by default sorting in ASCENDING ORDER (smallest -> largest)
SELECT * FROM products WHERE quantityInStock > 5000 AND buyPrice > 30 ORDER BY quantityInStock;

-- put DESC to sort by descending order
SELECT * FROM products 
		WHERE quantityInStock > 5000 AND buyPrice > 30
		ORDER BY quantityInStock DESC;

-- LIMIT - is to show the first N results
SELECT * FROM products ORDER BY buyPrice DESC LIMIT 3;

-- the (relative) order of clauses
1. FROM 
2. WHERE
3. SELECT *
4. ORDER BY
5. LIMIT


-- AND has greater precedence than OR, safer to group clauses together with (...)
-- Show all the customers from the USA
-- who has credit limit >= 5K and from the state of NV
-- OR any customers from any country with credit limit >= 1k
SELECT * FROM customers WHERE (country="USA" and state="NV" and creditLimit > 5000)
         OR (country <> "USA" and creditLimit > 1000);


-- for each employee, show their name and the phone number with extension
-- JOIN allows us to combine two or more tables as in one in a result table
-- FROM...JOIN ALWAYS HAPPEN FIRST
SELECT firstName, lastName, phone, extension FROM employees JOIN offices
  ON employees.officeCode = offices.officeCode;


  -- for each employee, show their name and the phone number with extension
-- JOIN allows us to combine two or more tables as in one in a result table
-- 1. FROM...JOIN ALWAYS HAPPEN FIRST
-- 2. WHERE 
-- 3. SELECT specific columns
-- 4. ORDER BY 
SELECT firstName AS `First Name`, lastName, phone, extension FROM employees JOIN offices
  ON employees.officeCode = offices.officeCode
  WHERE country = "USA"
  ORDER BY `First Name`