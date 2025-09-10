---
title: Sorting, Filtering & Grouping
---

## OrderBy Clause

```MYSQL
SELECT * FROM emplyees
ORDER BY first_name;
```

```MYSQL
SELECT * FROM emplyees
ORDER BY first_name DESC;
```

```
SELECT * FROM tranactions
ORDER BY amount,customer_id;
```

## Limit Clause

Limit how many no of customers to show 

```mysql
SELECT * FROM customer
LIMIT 1;
```

We can also add offset
```mysql
SELECT * FROM customers
LIMIT 1,1;  -- limit 1 record after 1
```
We can also use both togther
```mysql
SELECT * FROM customer
ORDER BY last_name LIMIT 1;
```

Perfect 👍 let’s build your **GROUP BY** notes with clear explanation + examples using your `employees` table.

---

# GROUP BY in SQL

- Definition:  
    The `GROUP BY` clause groups rows that have the same values in a specified column.
    
- Usag4:
    
    - Often used with aggregate functions (`SUM()`, `MAX()`, `MIN()`, `AVG()`, `COUNT()`).
        
    - Helps summarize data by categories.
        

---

| Employee_id | first_name | last_name | hourly_pay | job             | hiredate   | supervisor_id |
| ----------- | ---------- | --------- | ---------- | --------------- | ---------- | ------------- |
| 101         | Alice      | Johnson   | 25.50      | Software Dev    | 2021-06-15 | 104           |
| 102         | Bob        | Smith     | 22.00      | QA Engineer     | 2022-01-10 | 104           |
| 103         | Carol      | Davis     | 18.75      | Tech Support    | 2023-03-05 | 101           |
| 104         | David      | Wilson    | 30.00      | Project Manager | 2020-11-20 | NULL          |
| 105         | Eva        | Brown     | 19.50      | Intern          | 2023-07-01 | 103           |


### Example 1: Count Employees by Job

```mysql
SELECT job, COUNT(*) AS total_employees
FROM employees
GROUP BY job;
```

 Groups employees by their job title and counts how many are in each role.

---

### Example 2: Average Pay by Job

```mysql
SELECT job, AVG(hourly_pay) AS avg_pay
FROM employees
GROUP BY job;
```

 Shows the average hourly pay for each job type.

---

### Example 3: Highest Paid Employee Per Supervisor

```mysql
SELECT supervisor_id, MAX(hourly_pay) AS highest_pay
FROM employees
GROUP BY supervisor_id;
```

For each supervisor, finds the highest pay among their subordinates.

---

### Example 4: GROUP BY with HAVING

```mysql
SELECT job, COUNT(*) AS total_employees
FROM employees
GROUP BY job
HAVING COUNT(*) > 1;
```

 Similar to `WHERE`, but **HAVING** filters groups instead of rows (here it only shows jobs with more than 1 employee).

---

Nice 👍 let’s go step by step with **ROLLUP** and then apply it to your `employees` table example.

---

# ROLLUP

- `GROUP BY` groups rows and calculates aggregates (like SUM, AVG, COUNT).
- `WITH ROLLUP` adds an **extra row** with the **grand total (super-aggregate)**.
- This is useful when you want both per-group totals **and** overall totals in one query.

### Example with your `transactions` table

| transaction_id | amount | customer_id | order_date |
| -------------- | ------ | ----------- | ---------- |
| TXN1001        | 250.75 | 1           | 2025-08-01 |
| TXN1002        | 99.99  | 3           | 2025-08-03 |
| TXN1003        | 480.50 | 1           | 2025-08-05 |
| TXN1004        | 35.00  | 2           | 2025-08-06 |
| TXN1005        | 120.00 | 2           | 2025-08-07 |
| TXN1006        | 799.00 | 6           | 2025-08-10 |
| TXN1007        | 15.25  | 2           | 2025-08-11 |
| TXN1008        | 300.00 | 4           | 2025-08-13 |

```sql
SELECT order_date, SUM(amount) AS total_amount
FROM transactions
GROUP BY order_date WITH ROLLUP;
```

 This gives:

| order_date | total_amount |
| ---------- | ------------ |
| 2025-08-01 | 250.75       |
| 2025-08-03 | 99.99        |
| 2025-08-05 | 480.50       |
| 2025-08-06 | 35.00        |
| 2025-08-07 | 120.00       |
| 2025-08-10 | 799.00       |
| 2025-08-11 | 15.25        |
| 2025-08-13 | 300.00       |
| **NULL**   | **2,091.49** |

---

## Example with `employees`

Suppose we want to see how much **hourly pay per employee** adds up, plus the **total for everyone**:

```sql
SELECT first_name, last_name, SUM(hourly_pay) AS total_pay
FROM employees
GROUP BY first_name, last_name WITH ROLLUP;
```

👉 Output will look like:

|first_name|last_name|total_pay|
|---|---|---|
|Alice|Johnson|25.50|
|Bob|Smith|22.00|
|Charlie|Brown|18.75|
|David|Wilson|30.00|
|Eve|Davis|20.50|
|**NULL**|**NULL**|**116.75**|

---

⚡ Pro tip: You can use `COALESCE()` to replace the `NULL` with `"TOTAL"` for readability:

```sql
SELECT 
    COALESCE(first_name, 'TOTAL') AS first_name,
    COALESCE(last_name, '') AS last_name,
    SUM(hourly_pay) AS total_pay
FROM employees
GROUP BY first_name, last_name WITH ROLLUP;
```

---