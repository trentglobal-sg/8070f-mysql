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

-- REVIEW
SELECT customerName, contactFirstName, contactLastName, 
  customers.country AS "Customer Country", creditLimit,
  firstName, lastName, offices.country AS "Office Country"
  FROM customers JOIN employees
    ON customers.salesRepEmployeeNumber = employees.employeeNumber
  JOIN offices
    ON employees.officeCode = offices.officeCode
  WHERE creditLimit > 20000
  ORDER BY creditLimit DESC
  LIMIT 10;

-- INNER JOIN: The LHS must find a match in the RHS for it to be in the results
-- If we just say "JOIN" by default it is INNER JOIN
SELECT *
  FROM customers JOIN employees
  ON customers.salesRepEmployeeNumber = employees.employeeNumber;
   
-- LEFT JOIN: All rows in the LHS table WILL be in the results
SELECT *
  FROM customers LEFT JOIN employees
  ON customers.salesRepEmployeeNumber = employees.employeeNumber;

-- LEFT JOIN: All rows in the LHS table WILL be in the results
SELECT *
  FROM employees LEFT JOIN customers
  ON customers.salesRepEmployeeNumber = employees.employeeNumber
  WHERE jobTitle = "Sales Rep";
   
-- RIGHT JOIN (it's like LEFT JOIN, but all the rows from RHS table is included)
-- FULL OUTER JOIN (LEFT JOIN + RIGHT JOIN) --> NOT SUPPORTED BY MySQL

-- Show all the order number, status, order date, name of customer which placed in it
-- where the order date is in the year 2004
SELECT orderNumber, status, orderDate, customerName 
 FROM orders JOIN customers
   ON orders.customerNumber = customers.customerNumber
   WHERE orderDate >='2004-01-01' AND orderDate<='2004-12-31';

   -- For each order, how many days does it need for it be shipped
select orderNumber, shippedDate - orderDate from orders
where status="shipped"

-- MONTH, YEAR AND DAY functions


-- SELECT DISTINCT(<colName>) find all the unique (non-duplicated) values for a column
-- Example: Find all the unique countries that customers are from
SELECT DISTINCT(country) FROM customers;

-- An aggregate function returns from a single value from a table
SELECT AVG(creditLimit) FROM customers WHERE creditLimit > 0;

-- Count how many customers there are:
SELECT COUNT(*) FROM customers;

SELECT COUNT(DISTINCT(country)) FROM customers;

-- An aggregate function returns from a single value from a table
SELECT MIN(creditLimit) FROM customers WHERE creditLimit > 0;

SELECT MAX(creditLimit) FROM customers;

SELECT SUM(creditLimit) FROM customers;

-- GROUP BY

-- For each country, find out how many customers there are
-- (For a column, for each its distinct value, do some aggregation)
SELECT country, COUNT(*) FROM customers GROUP BY country;

-- For each office code, count how employees there are
SELECT officeCode, COUNT(*) FROM employees
GROUP BY officeCode;


-- How many orders per year was cancelled
SELECT COUNT(*), YEAR(orderDate) FROM orders
WHERE status="cancelled"
GROUP BY YEAR(orderDate)

-- Find all countries which have at least 10 customers
-- Using HAVING -- which is to count groups
SELECT COUNT(*), country FROM customers
GROUP BY country
HAVING COUNT(*) > 10;

-- For each employee, find out how much reveue they earned
-- Find the top ten salesperson by their sales performance
SELECT SUM(amount), employeeNumber, firstName, lastName FROM employees
  JOIN customers
    ON employees.employeeNumber = customers.salesRepEmployeeNumber
  JOIN payments
    ON customers.customerNumber = payments.customerNumber
GROUP BY employeeNumber, firstName, lastName;


-- Find the top ten salesperson by their sales performance
SELECT SUM(amount) AS "Revenue", employeeNumber, firstName, lastName FROM employees
  JOIN customers
    ON employees.employeeNumber = customers.salesRepEmployeeNumber
  JOIN payments
    ON customers.customerNumber = payments.customerNumber
GROUP BY employeeNumber, firstName, lastName
ORDER BY `Revenue` DESC
LIMIT 10;


-- Find the top three salesperson in the US  by their sales performance (only for employees in the US)
-- and they  have close at least three sales
SELECT SUM(amount) AS "Revenue", employeeNumber, firstName, lastName FROM employees
  JOIN customers
    ON employees.employeeNumber = customers.salesRepEmployeeNumber
  JOIN payments
    ON customers.customerNumber = payments.customerNumber
  JOIN offices
    ON employees.officeCode = offices.officeCode
WHERE offices.country = "USA"
GROUP BY employeeNumber, firstName, lastName
HAVING COUNT(*) > 3
ORDER BY `Revenue` DESC
LIMIT 3;

-- Find the best performing product line in the year of 2003
-- Consider only sales in USA
SELECT SUM(quantityOrdered * priceEach) AS "Revenue", productlines.productLine FROM productlines
 JOIN products ON productlines.productLine = products.productLine
 JOIN orderdetails ON products.productCode = orderdetails.productCode
 JOIN orders ON orders.orderNumber = orderdetails.orderNumber
 JOIN customers ON orders.customerNumber = customers.customerNumber
 WHERE country="USA" AND YEAR(orderDate)='2003'
GROUP BY productlines.productLine
ORDER BY `Revenue` DESC
LIMIT 3;