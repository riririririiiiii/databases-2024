create database lab9;

--1
create or replace function inc(val integer) returns integer AS
    $$
    begin
        return val + 10;
    end;
    $$
language plpgsql;

--select inc(20);

--2
create or replace function compare_numbers(a integer, b integer, out result text) as
    $$
    begin
        if a > b then
            result := 'Greater';
            elsif a = b then
            result := 'Equal';
            else result:= 'Lesser';
        end if;

    end;
    $$
language plpgsql;

--select compare_numbers(10,7);

--3
create or replace function number_series(n integer)
returns table(series integer) as
    $$
    begin
            return query
            select generate_series(1, n);
    end;
    $$
language plpgsql;

--select number_series(10);

--4
create or replace function find_employee(employee_name varchar)
returns table(first_name text, last_name text, salary numeric) as
    $$
    begin
        return query
            select first_name, last_name, salary
            from employees
            where employees.first_name = employee_name;
    end;
    $$
language plpgsql;

create table employees(
    first_name text,
    last_name text,
    salary numeric
);

--5
create or replace function list_products(given_product_category text)
returns table(product_id integer, product_name text, category text, price numeric, amount numeric) as
    $$
    begin
        return query
        select product_id, product_name, category, price, amount
        from products
        where category = given_product_category;
    end;
    $$
language plpgsql;

--6
create or replace function calculate_bonus(employee_name text)
returns numeric as
    $$
    declare
        bonus numeric;
    begin
        select salary * 0.10 into bonus from employees
        where employees.first_name = employee_name;
        return bonus;
    end;
    $$
language plpgsql;

create or replace function update_salary(employee_name text)
returns void as
    $$
    declare
    bonus numeric;
        begin
            bonus := calculate_bonus(employee_name);
            update employees
            set salary = salary + bonus
            where employees.first_name = employee_name;
    end;
    $$
language plpgsql;

--7
create or replace function complex_calculation(number numeric, string text)
returns text as
    $$
    declare
        number_result numeric;
        string_result text;
    begin
    -- Subblock 1
    <<numeric_block>>
    begin
        number_result := number * 0.5;
    end numeric_block;

    -- Subblock 2
    <<string_block>>
    begin
        string_result := 'Uppercase: ' || upper(string);
    end string_block;

    -- Combine
    return 'Number: ' || number_result || ', ' || string_result;
    end;
$$
language plpgsql;
