# Write your MySQL query statement below
select user_id, MAX(time_stamp) AS last_stamp
from logins 
where time_stamp like '2020%'
group by user_id;