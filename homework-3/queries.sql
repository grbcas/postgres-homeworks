-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)

select c.company_name, concat(e.last_name, ' ', e.first_name) from customers c
inner join employees e on e.city = 'London'
inner join shippers s on s.company_name = 'United Package'
where c.city = 'London';

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.

select p.product_name, p.units_in_stock, s.contact_name, s.phone
from products p inner join suppliers s using(supplier_id)
inner join categories c using(category_id)
where p.discontinued = 0 and c.category_name in ('Dairy Products', 'Condiments')
order by p.units_in_stock;

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
select c.company_name from customers c
where customer_id in
(
select c.customer_id from customers c
except
select customer_id from orders);

select c.company_name from customers c
left join orders o using(customer_id)
where o.customer_id is NULL;

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
select product_name from products
where product_id in (select distinct product_id from order_details where quantity = 10);