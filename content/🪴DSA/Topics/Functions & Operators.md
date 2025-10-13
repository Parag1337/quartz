---
title: Functions & Operators
---

#  SQL Functions

Functions in SQL are **built-in methods** that perform operations on data.  
They are broadly divided into two categories:

1. **Aggregate Functions** → Work on a group of rows (return a single result).
2. **Scalar/String Functions** → Work on each row individually.

---

## ✅ 1. Aggregate Functions

### 🔹 COUNT()

Returns the **number of rows**.

```mysql
SELECT COUNT(*) AS total_rows
FROM transactions;

SELECT COUNT(customer_id) AS customers_with_id
FROM transactions;
```

- `COUNT(*)` → counts all rows.
- `COUNT(column)` → counts only non-NULL values in that column.

---

### 🔹 MAX()

Returns the **maximum value** in a column.

```mysql
SELECT MAX(amount) AS highest_amount
FROM transactions;
```

---

### 🔹 MIN()

Returns the **minimum value** in a column.

```mysql
SELECT MIN(amount) AS lowest_amount
FROM transactions;
```

---

### 🔹 SUM()

Returns the **total (sum)** of a numeric column.

```mysql
SELECT SUM(amount) AS total_amount
FROM transactions;
```

---

### 🔹 AVG()

Returns the **average value**.

```mysql
SELECT AVG(amount) AS average_amount
FROM transactions;
```

---

## ✅ 2. String & Scalar Functions

### 🔹 CONCAT()

Combines multiple columns or strings into one.

```mysql
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM customers;
```

---

### 🔹 UPPER() / LOWER()

Converts text to **uppercase** or **lowercase**.

```mysql
SELECT UPPER(first_name), LOWER(last_name)
FROM customers;
```

---

### 🔹 LENGTH()

Returns the **length of a string**.

```mysql
SELECT first_name, LENGTH(first_name) AS name_length
FROM customers;
```

---

### 🔹 ROUND()

Rounds numbers to the nearest integer or given decimal places.

```mysql
SELECT ROUND(amount, 2) AS rounded_amount
FROM transactions;
```

---

## Quick Summary

- **Aggregate Functions:** COUNT, MAX, MIN, SUM, AVG.
- **String/Scalar Functions:** CONCAT, UPPER, LOWER, LENGTH, ROUND, etc.
- Aggregate functions are often used with **GROUP BY** for reports.


---

# 🔹 SQL Operators

Operators in SQL are used in the `WHERE` clause to **filter records** based on conditions.

---

## ✅ Adding a New Column (Example Setup)

```mysql
ALTER TABLE employees
ADD COLUMN job VARCHAR(25) AFTER hourly_pay;

SELECT * FROM employees;
```

📸  
![[Pasted image 20250825202419.png|250]]

---

### 1. AND Operator

- Returns rows where **both conditions are true**.
    

```mysql
SELECT * FROM employees
WHERE hire_date < "2023-01-05" AND job = "cook";
```

✅ Both conditions must match.

---

### 2. OR Operator

- Returns rows where **any one condition is true**.
    

```mysql
SELECT * FROM employees
WHERE job = "cook" OR job = "chief";
```

✅ Either job = cook OR job = chief.

---

### 3. NOT Operator

- Excludes rows that match the condition.
    

```mysql
SELECT * FROM employees
WHERE NOT job = "manager";
```

✅ Returns all employees **except managers**.

---

### 4. BETWEEN Operator

- Selects values **within a given range** (inclusive).
    

```mysql
SELECT * FROM employees
WHERE hire_date BETWEEN "2023-01-04" AND "2023-01-07";
```

✅ Returns employees hired **from Jan 4 to Jan 7 (including both dates)**.

---

### 5. IN Operator

- Matches against a **list of possible values**.
    

```mysql
SELECT * FROM employees
WHERE job IN ("cook", "janitor", "chief");
```

✅ Equivalent to multiple OR conditions:

```mysql
job = "cook" OR job = "janitor" OR job = "chief"
```

---


# SQL Wildcards 


### 1. `%` (Percent) → Matches zero, one, or many characters

```mysql
SELECT * FROM employees
WHERE first_name LIKE "s%";
```

Matches any name starting with `s` (e.g., `Sam, Steve, Sophia`).

```mysql
SELECT * FROM employees
WHERE hire_date LIKE "2023%";
```

Matches any date that starts with `2023` `(i.e., all employees hired in 2023).`

---

### 2. `_` (Underscore) → Matches exactly one character

```mysql
SELECT * FROM employees
WHERE job LIKE "_ook";
```

Matches words with **any one letter before "ook"** (e.g., _Cook, Book, Look_).

```mysql
SELECT * FROM employees
WHERE hire_date LIKE "____-01-__";
```

Matches **all dates in January** (4 underscores for year, then `-01-`, then 2 underscores for day).  
Example: `2023-01-05`, `2022-01-15`.

---