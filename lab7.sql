create database lab7;

--1
create table countries (
    name varchar(100)
);
/*
DO
$$
    DECLARE
        i INTEGER := 0;
    BEGIN
        WHILE i < 1000000
            LOOP
                INSERT INTO countries (name)
                VALUES (md5(random()::text));
                i := i + 1;
            END LOOP;
    END
$$;
*/
--explain analyze
select *
from countries
where name = 'UK';

create index country_name_index on countries(name);

--2
create table employees(
    name varchar(100),
    surname varchar(100),
    salary integer,
    department_id integer references departments(department_id)
);

select * from employees where name = 'string' and surname = 'string';

create index employee_name_index on employees(name, surname);

--3
select * from employees where salary < value1 and salary > value2;

create unique index employee_salary_index on employees (salary);

--4
select * from employees where substring(name from 1 for 4) = 'abcd';

create index employees_name_substring_index on employees(substring(name from 1 for 4));

--5
create table departments
(
    budget integer,
    department_id serial primary key
);

select * from employees e
    join departments d on d.department_id = e.department_id
         where d.budget > value2 and e.salary < value2;


create index employees_salary_index on employees(department_id, salary);
create index department_budget_index on departments(department_id, budget);
