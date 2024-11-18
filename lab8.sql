--1
create database lab8;

--2
CREATE TABLE salesman (
    salesman_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    commission DECIMAL(3, 2)
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    cust_name VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    grade INTEGER,
    salesman_id INTEGER REFERENCES salesman(salesman_id)
);

CREATE TABLE orders (
    order_no INTEGER NOT NULL,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INTEGER REFERENCES customers(customer_id),
    salesman_id INTEGER REFERENCES salesman(salesman_id)
);

INSERT INTO salesman (salesman_id, name, city, commission)
VALUES
    (5001, 'James Hoog', 'New York', 0.15),
    (5002, 'Nail Knite', 'Paris', 0.13),
    (5005, 'Pit Alex', 'London', 0.11),
    (5006, 'Mc Lyon', 'Paris', 0.14),
    (5003, 'Lauson Hen', 'San Jose', 0.12),
    (5007, 'Paul Adam', 'Rome', 0.13);

INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id)
VALUES
    (3002, 'Nick Rimando', 'New York', 100, 5001),
    (3005, 'Graham Zusi', 'California', 200, 5002),
    (3001, 'Brad Guzan', 'London', 0, 5005),
    (3004, 'Fabian Johns', 'Paris', 300, 5006),
    (3007, 'Brad Davis', 'New York', 200, 5001),
    (3009, 'Geoff Camero', 'Berlin', 100, 5003),
    (3008, 'Julian Green', 'London', 300, 5002);

INSERT INTO orders (order_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES
    (70001, 150.5, '2012-10-05', 3005, 5002),
    (70009, 270.65, '2012-09-10', 3001, 5005),
    (70002, 65.26, '2012-10-05', 3002, 5001),
    (70004, 110.5, '2012-08-17', 3009, 5003),
    (70007, 948.5, '2012-09-10', 3005, 5002),
    (70005, 2400.6, '2012-07-27', 3007, 5001),
    (70008, 5760, '2012-09-10', 3002, 5001);

--3
CREATE ROLE junior_dev LOGIN;

--4
CREATE OR REPLACE VIEW salesmen_view AS
    SELECT *
FROM salesman
WHERE city = 'New York';

--5
CREATE OR REPLACE VIEW order_name_view AS
    SELECT o.order_no, o.purch_amt, o.ord_date,
       s.name AS salesman_name, c.cust_name AS customer_name
FROM orders o
JOIN salesman s ON o.salesman_id = s.salesman_id
JOIN customers c ON o.customer_id = c.customer_id;
GRANT ALL ON order_name_view TO junior_dev;
--6
CREATE OR REPLACE VIEW highest_grade_customers_view AS
SELECT *
FROM customers
WHERE grade = (SELECT MAX(grade) FROM customers);

GRANT SELECT ON highest_grade_customers_view TO junior_dev;

--select * from cust_high_grade_view;

--7
CREATE OR REPLACE VIEW num_salesman_view AS
    SELECT city, count(*) as num_of_salesmen
FROM salesman
GROUP BY city;

--8
CREATE OR REPLACE VIEW salesmen_with_more_cust_view AS
    SELECT s.salesman_id, s.name, count(*) as customer_count
FROM salesman s
JOIN customers c on s.salesman_id = c.salesman_id
GROUP BY s.salesman_id, s.name
HAVING COUNT(*) > 1;

--9
CREATE ROLE intern;
GRANT junior_dev TO intern;


