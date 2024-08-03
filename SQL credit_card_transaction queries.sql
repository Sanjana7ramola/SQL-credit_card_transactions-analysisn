select * from credit_card_transcations
---1.write a query to print top 5 cities with highest spends and their percentage contribution of total credit card spends 

with cte as(
select top 5 city , sum(amount) as eact_city_sum from  credit_card_transcations 
group by city order by sum(amount) desc), cte1 as(
select sum(amount) as total_spent from credit_card_transcations)
select city, eact_city_sum , round((eact_city_sum/total_spent)*100,2) as percentage_t from cte,cte1 
order by eact_city_sum desc

---2.write a query to print highest spend month and amount spent in that month for each card type
WITH cte AS (
    SELECT 
        card_type,
        DATEPART(YEAR, transaction_date) AS yod,
        DATEPART(MONTH, transaction_date) AS mt,
        SUM(amount) OVER (PARTITION BY card_type, DATEPART(YEAR, transaction_date), DATEPART(MONTH, transaction_date)) AS total_spent
    FROM credit_card_transcations),
cte1 AS (
    SELECT *, ROW_NUMBER() OVER ( PARTITION BY card_type ORDER BY total_spent DESC) AS rn
    FROM cte
)
SELECT card_type, yod, mt, total_spent
FROM cte1 
WHERE  rn = 1;

---3. write a query to print the transaction details(all columns from the table) for each card type when
---it reaches a cumulative of 1000000 total spends(We should have 4 rows in the o/p one for each card type)
with cte as (
select *,sum(amount) over(partition by card_type order by transaction_date,transaction_id) as total_spend
from credit_card_transcations
),  cte1 as
(select *, row_number() over(partition by card_type order by total_spend) as rn  
from cte where total_spend >= 1000000)
select * from cte1
where rn=1

---4. write a query to find city which had lowest percentage spend for gold card type

with cte as (
select  city,card_type,sum(amount) as amount
,sum(case when card_type='Gold' then amount end) as gold_amount
from credit_card_transcations
group by city,card_type)
select top 1
city,sum(gold_amount)*1.0/sum(amount) as gold_ratio
from cte
group by city
having sum(gold_amount) is not null
order by gold_ratio;

----5- write a query to print 3 columns:  city, highest_expense_type , lowest_expense_type (example format : Delhi , bills, Fuel)
WITH cte AS (
    SELECT city, exp_type, SUM(amount) AS total_amount
    FROM credit_card_transcations
    GROUP BY city, exp_type
),
cte1 AS (
    SELECT city, exp_type AS highest_exp_type, total_amount AS max_amt,
               ROW_NUMBER() OVER (PARTITION BY city ORDER BY total_amount DESC) AS rn
        FROM cte
),
cte2 AS (
    SELECT city, exp_type AS lowest_exp_type, total_amount AS min_amt,
               ROW_NUMBER() OVER (PARTITION BY city ORDER BY total_amount ASC) AS rn
        FROM cte
)
SELECT cte1.city, cte1.highest_exp_type,  cte2.lowest_exp_type 
FROM cte1
JOIN cte2 ON cte1.city = cte2.city   wHERE cte1.rn = 1  and cte2.rn = 1;

----6- write a query to find percentage contribution of spends by females for each expense type
with cte as(
select exp_type,
sum(amount) as total_amount, sum(case when gender='F' then amount else 0 end) female_amount  from
credit_card_transcations group by exp_type
)
select exp_type ,female_amount,total_amount,
(female_amount /total_amount)*100
as f_percent 
from cte 

---7- which card and expense type combination saw highest month over month growth in Jan-2014 
with cte as(
select 
card_type,exp_type,DATEPART(year,transaction_date) as yod ,DATEPART(month,transaction_date) as mt ,sum(amount) as total_amount
from credit_card_transcations group by card_type,exp_type,DATEPART(year,transaction_date),DATEPART(month,transaction_date)),
cte1 as(
select * , lag(total_amount,1) over(partition by card_type,exp_type order by yod,mt) as prev_month from cte)
select 
top 1 *,(total_amount - prev_month ) as mon_growth from cte1 
where  yod=2014 and mt=1
order by mon_growth desc

----8-- during weekends which city has highest total spend to total no of transcations ratio

select top 1
city ,sum(amount)*1.0/count(1) as ratio
from credit_card_transcations where datepart(weekday,transaction_date) in (1,7)
group by city order by ratio desc

---9-which city took least number of days to reach its 500th transaction after the first transaction in that city
with cte as (
select *
,row_number() over(partition by city order by transaction_date,transaction_id) as rn
from credit_card_transcations)
select top 1 city,datediff(day,min(transaction_date),max(transaction_date)) as datediff1
from cte
where rn=1 or rn=500
group by city
having count(1)=2
order by datediff1 












