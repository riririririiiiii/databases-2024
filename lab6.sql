--1
create database lab6;
 --2
 create table locations(
     location_id serial primary key ,
     street_address varchar(25),
     postal_code varchar(12),
     city varchar(30),
     state_province varchar(12)
 );

create table departments(
    department_id serial primary key ,
    department_name varchar(50) unique,
    budget integer,
    location_id integer references locations
);

create table employees(
    employee_id serial primary key ,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    phone_number varchar(20),
    salary integer,
    department_id integer references departments
);

INSERT INTO locations (street_address, postal_code, city, state_province)
VALUES
    ('123 Main St', '10001', 'New York', 'NY'),
    ('456 Elm St', '20001', 'Washington', 'DC'),
    ('789 Oak St', '94101', 'San Francisco', 'CA'),
    ('321 Maple Ave', '30301', 'Atlanta', 'GA'),
    ('654 Pine Ave', '60601', 'Chicago', 'IL');

INSERT INTO departments (department_name, budget, location_id)
VALUES
    ('Human Resources', 50000, 1),
    ('Sales', 120000, NULL),
    ('Marketing', 75000, 3),
    ('Finance', NULL, 4),
    ('IT', 150000, 5);

INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id)
VALUES
    ('John', 'Doe', 'jdoe@example.com', '555-1234', 60000, 1),
    ('Dana', 'Evans', 'devans@example.com', '555-2468', 68000, 1),
    ('Jane', 'Smith', NULL, '555-5678', 75000, 2),
    ('Evan', 'Walker', 'ewalker@example.com', NULL, 72000, 2),
    ('Alice', 'Brown', 'abrown@example.com', '555-8765', NULL, 3),
    ('Fiona', 'White', 'fwhite@example.com', '555-4680', 76000, 3),
    ('Bob', 'Jones', 'bjones@example.com', NULL, 80000, 4),
    ('George', 'Taylor', 'gtaylor@example.com', '555-5791', 85000, NULL),
    ('Charlie', 'Davis', 'cdavis@example.com', '555-1357', 95000, 5),
    ('Hannah', 'Wilson', NULL, '555-6802', 90000, 5),
    ('Emily', 'Clark', 'eclark@example.com', '555-1111', NULL, NULL),
    ('Frank', 'Knight', 'fknight@example.com', '555-2222', 72000, NULL);

--3
select first_name, last_name,e.department_id, d.department_name
from employees e
join departments d on e.department_id = d.department_id;

--4
select first_name, last_name, e.department_id, d.department_name
from employees e
join departments d on e.department_id = d.department_id
where e.department_id = 80 or e.department_id = 40;

--5
select first_name, last_name, d.department_name, l.city, l.state_province
from employees e
    join departments d on e.department_id = d.department_id
    join locations l on d.location_id = l.location_id;

--6
select d.department_name, e.first_name, e.last_name from departments d
left join employees e on d.department_id = e.department_id;

--7
select first_name, last_name, e.department_id, d.department_name
from employees e
left join departments d on e.department_id = d.department_id;
