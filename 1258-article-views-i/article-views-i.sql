# Write your MySQL query statement below
select Distinct author_id AS id
from views
where author_id=viewer_id
order by id ASC;

