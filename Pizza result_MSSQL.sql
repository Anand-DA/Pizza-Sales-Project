
USE pizza_sales;
-- 1. TOTAL REVENUE

Select round(sum(quantity * price),2) as Total_Revenue from order_details o join pizzas p on o.pizza_id = p.pizza_id;

-- 2. Average Order Value

select round(sum(quantity * price)/count(distinct order_id),2) as avg_order_value from order_details o join pizzas p on o.pizza_id = p.pizza_id;

-- 3. Total pizza sold

select sum(quantity) total_sold from order_details;

-- 4. Total Order

select count(distinct order_id) total_order from order_details;

-- 5. Average price per order - pizza sold/number of pizza

select sum(quantity)/count(distinct order_id) as avg_price_per_order from order_details o join pizzas p on o.pizza_id = p.pizza_id; 


-- Questions to Answer

-- 1. Daily trends for total order

select format(date, 'dddd') as dayofweek, count(distinct order_id) total_orders
from orders group by format(date, 'dddd') order by dayofweek;

-- 2. Hourly trend total order

select datepart(hour, time) as [hour], count(distinct order_id) total_hourly_orders from orders
group by datepart(hour, time) order by [hour];

-- 3. Percentage of sales by pizza category - a = calculate total revenue by category and a/total revenue

select category, sum(quantity * price) revenue,
sum(quantity * price)*100/(
select sum(quantity * price) from pizzas p2 join order_details od2 on 
p2.pizza_id = od2.pizza_id) as Percentage_sales
from pizzas p join pizza_types pt on p.pizza_type_id = pt.pizza_type_id
join order_details od on od.pizza_id = p.pizza_id 
group by category;

-- 4. Percentage of sales by pizza size

select size, round(sum(quantity * price),2) revenue,
round(sum(quantity * price)*100/(
select sum(quantity * price) from pizzas p2 join order_details od2 on 
p2.pizza_id = od2.pizza_id),2) as Percentage_sales
from pizzas p join pizza_types pt on p.pizza_type_id = pt.pizza_type_id
join order_details od on od.pizza_id = p.pizza_id 
group by size;

-- 5. Total pizza sold by category

select category, sum(quantity) as total_qty from order_details od 
join pizzas p on od.pizza_id = p.pizza_id
join pizza_types pt on p.pizza_type_id = pt.pizza_type_id
group by category order by total_qty desc;

-- 6. Top 5 Best Sellers by Total Pizzas Sold

select top 5 name, sum(quantity) total_sold
from pizzas p join pizza_types pt on p.pizza_type_id = pt.pizza_type_id
join order_details od on od.pizza_id = p.pizza_id 
group by name
order by total_sold desc;

-- 7. Bottom 5 Worst Sellers by Total Pizzas Sold

select top 5 name, sum(quantity) total_sold
from pizzas p join pizza_types pt on p.pizza_type_id = pt.pizza_type_id
join order_details od on od.pizza_id = p.pizza_id 
group by name
order by total_sold;




































