-- Use Schema --
use novaup;

-- Queries F --

-- 1 
Explain
-- selecting customer name, plan name and first day date from 2-12-2020 to 1-11-2021
Select name as 'Customer_Name', 
plan_name as 'Plan_Name', first_day as 'Date' -- 'as' will give different names to the columns that will store the information
from customer c, plans p -- name the tables from which the information will be taken
where p.id_plan=c.id_plan -- chose only rows where id_plan matches
and c.`first_day` between '2020-12-02' and '2021-11-01'; -- filter dates 

-- interpretation of explain:
-- 1st line: poorly tuned sql query because we don't have any index. So, we might use WHERE clause.
-- possible solution: create an index for first_day




-- 2
Explain
-- the best customers are those who spend more money in the gym
-- selecting the 3 customers that spent more money in the gym
Select name as 'Customer_Name', SUM(amount) as 'Total_Amount_Spent'
from customer c, payment p where p.id_customer=c.id_customer 
-- group by so the sum(amount) will be equal to the sum of every payment that one customer has done
group by c.id_customer 
order by SUM(amount) DESC LIMIT 3; -- limit three to show only the best three clients

-- interpretation: the query is optimized

-- 3
Explain
-- use concat to create the dates interval from the earliest (min) to the latest (max) 
select concat(min(p.payment_date), ' - ', max(p.payment_date)) as PeriodOfSales, 
concat(sum(p.amount), '€') as TotalSales, 
-- assuming every year has 365 days and every month 30 days
-- compute the average by the number of days in the database by the number of days in the correspondent period of time
-- and then divide the profits by that number and rounding it with 2 decimal cases
concat(round(sum(p.amount)/(datediff(max(p.payment_date), min(p.payment_date))/365), 2), '€')  as YearlyAverage,
concat(round(sum(p.amount)/(datediff(max(p.payment_date), min(p.payment_date))/30), 2), '€') as MonthlyAverage
from payment p;

-- interpretation: poorly tuned because we don't have any index.
-- possible solution: use a group by function or a filter

-- 4
--
Explain
select l.city_name as 'City', 
count(p.id_payment) as 'Total Number Of Sales', 
concat(sum(p.amount), '€') as 'Total Amount Of Sales'
from gym
-- link the location with the respective customer via gym since the gym table has both keys
join location l on gym.id_location=l.id_location 
join customer c on c.id_gym=gym.id_gym 
-- connect payment with the customer that was previously connected to the location
join payment as p on p.id_customer=c.id_customer
group by l.city_name; -- assures the previous selection is done according to the city name


-- interpretation: the query is optimized

-- 5
--
Explain
select city_name as 'City', concat(c.address, ", ", c.zip_code) as 'Location', plan_name as 'Plan', rating as 'Rating'
from gym 
-- link the location with the respective customer via gym since the gym table has both keys
join location l on gym.id_location=l.id_location
join customer c on c.id_gym=gym.id_gym
-- connect each costumer with their rating
join ratings r on r.id_customer=c.id_customer
-- link the plan to the rest of the connections made by linking it with the customer
join plans p on p.id_plan=c.id_plan
-- the city names will appear in alphabetic order and (inside each 'city group') the ratings will appear from highest to lowest
order by `city_name` ASC, `rating` DESC; 

-- the query looks good, but we can improve it by create an index for id_plan in the customer table
