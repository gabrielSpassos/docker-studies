# Postgres Group By POC

> Issue how to get values from column on postgres select that are NOT part of the group by statement

> Error: SQL Error [42803]: ERROR: column "account.created_at" must appear in the GROUP BY clause or be used in an aggregate function

* Works, but not show the created_at
```sql
select user_id, account_number, count(1) as cnt from account
group by user_id, account_number
having count(1) > 1;
```

* Not work because created_at is different
```sql
select user_id, account_number, created_at, count(1) as cnt from account
group by user_id, account_number, created_at
having count(1) > 1;
```

* Works and shows the created_at
```sql
select 
  user_id, 
  account_number, 
  min(created_at) as min_created_at, 
  max(created_at) as max_created_at, 
  count(1) as cnt
from account
group by user_id, account_number
having count(1) > 1;
```
