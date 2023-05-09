/* joins: select all the computers from the products table:
using the products table and the categories table, return the product name and the category name */
SELECT products.Name AS "Product", categories.Name	AS "Category"
FROM products
INNER JOIN categories ON products.CategoryID = categories.CategoryID;
 
/* joins: find all product names, product prices, and products ratings that have a rating of 5 */
SELECT products.Name AS "Product", products.Price, reviews.Rating
FROM products
INNER JOIN reviews ON products.ProductID = reviews.ProductID
WHERE reviews.Rating = 5;

/* joins: find the employee with the most total quantity sold.  use the sum() function and group by */
/* Sum all the quantities available in order details */

SELECT EmployeeID, sum_column
FROM(
	SELECT SUM(sales.Quantity * sales.PricePerUnit) as sum_column, employees.EmployeeID
	FROM employees
	INNER JOIN sales ON employees.EmployeeID = sales.EmployeeID
	GROUP BY employees.EmployeeID
) AS sum
order by sum_column DESC
LIMIT 1;

/* joins: find the name of the department, and the name of the category for Appliances and Games */
SELECT categories.Name AS "Category Name", departments.Name AS "Department Name"
FROM departments
INNER JOIN categories ON departments.DepartmentID = categories.DepartmentID
WHERE categories.Name = "Games"
OR categories.NAME = "Appliances";

/* joins: find the product name, total # sold, and total price sold,
 for Eagles: Hotel California --You may need to use SUM() */
 
 SELECT products.Name AS product_name, SUM(sales.Quantity) as total_quanity_sold, SUM(sales.PricePerUnit * sales.Quantity) as total_price_sold
 FROM products
 INNER JOIN sales ON sales.ProductID = products.ProductID
 GROUP BY products.Name;

/* joins: find Product name, reviewer name, rating, and comment on the Visio TV. (only return for the lowest rating!) */
SELECT *
FROM(
	SELECT products.Name, reviews.Reviewer, reviews.Rating, reviews.Comment
    FROM products
    INNER JOIN reviews ON products.ProductID = reviews.ProductID
    ) AS SubQuery
WHERE Rating = 1;

-- ------------------------------------------ Extra - May be difficult
/* Your goal is to write a query that serves as an employee sales report.
This query should return:
-  the employeeID
-  the employee's first and last name
-  the name of each product
-  and how many of that product they sold */

SELECT employees.EmployeeID, LastName, FirstName, Name AS "Product Name", Quantity AS "# Products Sold" 
FROM(
	SELECT employees.EmployeeID, employees.FirstName, employees.LastName
	FROM employees
) AS employees
INNER JOIN sales ON employees.EmployeeID = sales.EmployeeID
INNER JOIN products ON sales.ProductID = products.ProductID
ORDER BY LastName;
