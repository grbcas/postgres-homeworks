drop table if exists public.employees;
drop table if exists public.customers;
drop table if exists public.orders;


create table public.employees
(
    employee_id smallint PRIMARY KEY,
    first_name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL,
	title varchar(30),
	birth_day date NOT NULL,
		check ( birth_day < (current_date - interval '18' year ) ),
	notes text
);

create table public.customers
(
	customer_id varchar(5) PRIMARY key,
	company_name varchar(50) NOT null,
	contact_name varchar(100)
);

create table public.orders
(
	order_id int PRIMARY key,
	customer_id varchar(10) REFERENCES customers(customer_id),
	employee_id smallint REFERENCES employees(employee_id),
	order_date date NOT NULL,
	ship_city varchar(50) NOT NULL
);

select * from public.customers;
select * from public.employees;
select * from public.orders;