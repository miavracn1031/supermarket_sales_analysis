DROP DATABASE IF EXISTS supermarket_sales;
CREATE DATABASE IF NOT EXISTS supermarket_sales;
USE supermarket_sales;

CREATE TABLE sales
(
	invoice_id VARCHAR (20) PRIMARY KEY,
	branch CHAR (1) NOT NULL,
	city VARCHAR (10) NOT NULL,
	customer_type VARCHAR(20) NOT NULL,
	gender ENUM ('M','F') NOT NULL,
	total DOUBLE NOT NULL
	
);
	
CREATE TABLE products 
(
	product_line VARCHAR (50) NOT NULL,
	unit_price DOUBLE NOT NULL,
	quantity INT NOT NULL,
	total DOUBLE NOT NULL,
	date DATE NOT NULL,
	time TIME NOT NULL,
	pmnt_method CHAR(50) NOT NULL,
	invoice_id VARCHAR (20) NOT NULL,
	cogs DOUBLE NOT NULL,
	gross_income DOUBLE NOT NULL,
	FOREIGN KEY(invoice_id) REFERENCES sales (invoice_id) 
);


SELECT COUNT(*)
FROM sales;

/*total sum of all invoices*/

SELECT 
    ROUND(SUM(total), 2) sum_total
FROM
    sales;
    
/* total sum of gross income*/

SELECT 
    ROUND(SUM(gross_income), 2) gross_income
FROM
    products;
    
/*average sum of gross_income*/

SELECT 
    ROUND(AVG(gross_income), 2) avg_gross_income
FROM
    products;

/*average sum of all invoices*/
    
SELECT 
    ROUND(AVG(total), 2) avg_total
FROM
    sales;
    
  /*count of sales for each branch*/
  
SELECT 
    branch, COUNT(*) total_sales
FROM
    sales
GROUP BY branch;

/*count of each payment method*/

SELECT 
    payment, COUNT(*) total_payment_method
FROM
    products
GROUP BY payment;

/* most product sold*/

SELECT 
    product_line, COUNT(*) total_product_sold
FROM
    products
GROUP BY product_line
ORDER BY total_product_sold;

/*total quantity per product_line*/

SELECT 
    product_line, SUM(quantity) product_quantity
FROM
    products
GROUP BY product_line
ORDER BY product_quantity;

/*total amount of each product sold*/

SELECT 
    product_line, ROUND(SUM(total), 2) as total_amount_product
FROM
    products
GROUP BY product_line
order by total_amount_product DESC;

/*total amount spent per city*/

SELECT 
    city, ROUND(SUM(p.total), 2) total_per_city
FROM
    products p
        INNER JOIN
    sales s ON p.invoice_id = s.invoice_id
GROUP BY city
ORDER BY total_per_city DESC;

/*gross income per branch*/

SELECT 
    branch, ROUND(SUM(p.total), 2) total_per_branch
FROM
    products p
        INNER JOIN
    sales s ON p.invoice_id = s.invoice_id
GROUP BY branch
ORDER BY total_per_branch;

/*price level: cheap, medium, expensive- case statement*/

SELECT 
    COUNT(*),
    CASE
        WHEN unit_price BETWEEN 10 AND 20 THEN 'cheap'
        WHEN unit_price BETWEEN 20 AND 50 THEN 'mid'
        ELSE 'expensive'
    END AS unit_price
FROM
    products
GROUP BY CASE
    WHEN unit_price BETWEEN 10 AND 20 THEN 'cheap'
    WHEN unit_price BETWEEN 20 AND 50 THEN 'mid'
    ELSE 'expensive'
END;
    
/*probability of product_line of being bought again*/

SELECT 
   unit_price
   from products
order by unit_price asc;


/*gross income by producst*/

SELECT 
    product_line, ROUND(SUM(gross_income), 2) AS gross_income
FROM
    products
GROUP BY product_line
ORDER BY gross_income;

/*gross income per branch*/

SELECT 
    branch, ROUND(SUM(gross_income), 2) AS gross_income
FROM
    products p
        INNER JOIN
    sales s ON p.invoice_id = s.invoice_id
GROUP BY branch
ORDER BY gross_income;

/*average amount spent by customer type*/

SELECT 
    customer_type, ROUND(AVG(sales.total), 2) as amount_per_customer_type
FROM
    sales
GROUP BY customer_type
order by amount_per_customer_type;