# Postgres Group By POC

> Issue how to get values from column on postgres select that are NOT part of the group by statement

> Scenario where you have duplicated rows (by two column user_id and account_number) on some table, and you want to know the dates that the rows were inserted, but you can't include the dates on the clause that says if is duplicated.
![data](https://github.com/gabrielSpassos/docker-studies/blob/master/postgres-groupby-poc/resources/duplicated-values.png)

* Works, but not show the created_at
```sql
select user_id, account_number, count(1) as cnt from account
group by user_id, account_number
having count(1) > 1;
```
![group-by-query.png](https://github.com/gabrielSpassos/docker-studies/blob/master/postgres-groupby-poc/resources/group-by-query.png)

* Errors since the created_at is not part of the group by
```sql
select user_id, account_number, created_at, count(1) as cnt from account
group by user_id, account_number
having count(1) > 1;
```
> Error: SQL Error [42803]: ERROR: column "account.created_at" must appear in the GROUP BY clause or be used in an aggregate function

* Not work because created_at is different
```sql
select user_id, account_number, created_at, count(1) as cnt from account
group by user_id, account_number, created_at
having count(1) > 1;
```
![group-by-query-with-date](https://github.com/gabrielSpassos/docker-studies/blob/master/postgres-groupby-poc/resources/group-by-query-with-date.png)

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
![final-result](https://github.com/gabrielSpassos/docker-studies/blob/master/postgres-groupby-poc/resources/final-result.png)
