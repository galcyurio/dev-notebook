## Issue summary
I queried but error occurred.

## Environment (integrated library, OS, etc)
mysqld  Ver 5.7.17 for Win64 on x86_64 (MySQL Community Server (GPL))

## Expected behavior
Just give me result set.

## Actual behavior
Error occurred.
````sql
Expression #1 of SELECT list is not in GROUP BY clause and contains nonaggregated column 'support_desk.mod_users_groups.group_id' which is not functionally dependent on columns in GROUP BY clause; this is incompatible with sql_mode=only_full_group_by
````

## Issue detail (Reproduction steps, use case)
It was my company job.  
So I cannot write details.  
But below issue shows similar my case.


## Trouble shooting
I solved this problem with help of [Related issue](https://stackoverflow.com/questions/34115174/error-related-to-only-full-group-by-when-executing-a-query-in-mysql/38551525#38551525)

The answer recommend simply add `column_id` to `group by clause`.  
However, in my case, I didn't need that `column_id`.   
So I removed from select clause.