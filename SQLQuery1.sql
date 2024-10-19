with purchases as (
  select user_id, created_at, product_id,
  rank() over(partition by user_id order by created_at) AS user_day
  from inapp_campaign
)
select count(distinct user_id)
from purchases next_days
where user_day > 1
and product_id not in (
  select product_id
  from purchases first_day
  where first_day.user_day = 1
  and first_day.user_id = next_days.user_id
)
