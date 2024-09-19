-- task 1
create database lab2;

--task 2
create table countries(
    country_id serial primary key,
    country_name varchar(100),
    region_id integer,
    population integer
);

--task3
insert into countries(country_name, region_id, population)
values ('Korea',2 , 51706780 );

--task4
insert into countries(country_id, country_name)
values (default, 'Canada');

--task5
insert into countries(country_name, region_id, population)
values ('France', NULL, 64906276);

--task6
insert into countries(country_name, region_id, population)
VALUES ('Sweden', 4, 10481937),
       ('Monaco', 7, 36927),
       ('Alaska', 1, 733583);

--task7
alter table countries
     alter column country_name set default 'Kazakhstan';

--task8
insert into countries(country_name, region_id, population)
VALUES (default, 3, 19000000);

--task9
insert into countries DEFAULT VALUES;

--task10
create table countries_new(LIKE countries INCLUDING ALL );

--task11
insert into countries_new(country_name, region_id, population)
select country_name, region_id, population
from countries;

--task12
update countries
set region_id = 1
where region_id is null;

--task13
update countries
set population = population * 1.1
returning country_name, population as "New Population";

--task 14
delete
from countries
where population < 100000;

--task 15
delete
from countries_new as cn
using countries as c
where cn.country_id = c.country_id
returning *;

--task 16
delete
from countries
returning *;


select *
from countries_new;

select*
from countries;
