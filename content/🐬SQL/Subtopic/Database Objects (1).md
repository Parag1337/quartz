---
name: Database Objects (1)
---

Got it 👍 Let’s enrich the **Views** and **Indexes** notes with **real-world examples + SQL examples** so they’re crystal clear and exam-ready.

---

# 📘 Views in SQL

### 🔹 Definition

- A **view** is a **virtual table** created from a query.
- It doesn’t store data → always shows **live data** from underlying tables.
- Used for **simplicity, security, and abstraction**.

---

### ✅ Example: Creating and Using a View

Suppose we have a table:

```mysql
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10,2),
    department VARCHAR(50)
);
```

Now we create a view to show only **employee names and department** (hiding salary for security):

```mysql
CREATE VIEW emp_view AS
SELECT first_name, last_name, department
FROM employees;
```

👉 Using the view:

```mysql
SELECT * FROM emp_view;
```

👉 Dropping the view:

```mysql
DROP VIEW emp_view;
```

---

### Real-World Analogy (View)

A **view** is like a **window in a house** 🏠.

- The house = **real table** (data stored).
- The window = **view** (lets you see part of the house but not everything).
- If someone changes things inside the house, you’ll see it through the window (changes reflect in the view).
---

# 📘 Index in SQL

### 🔹 Definition

- An **index** is a **data structure (B-Tree in MySQL)** used to **find rows faster**.
- It works like a **book index**: instead of reading every page, you jump directly to the page number.
- Makes `SELECT` queries faster, but slows down `INSERT/UPDATE/DELETE`.

---

### ✅ Example: Creating and Using Index


- Without index, this query scans **entire table**:

```mysql
SELECT * FROM customers
WHERE last_name = 'Puff';
```

- Create an index on `last_name`:

```mysql
CREATE INDEX last_name_idx
ON customers(last_name);
```

Now, MySQL can **directly jump** to entries with `"Puff"` instead of scanning everything.

- View indexes:

```mysql
SHOW INDEX FROM customers;
```

 - Drop the index:

```mysql
ALTER TABLE customers DROP INDEX last_name_idx;
```

---

### ✅ Multi-Column Index Example

```mysql
CREATE INDEX city_name_idx
ON customers(city, last_name);
```

- Query using both columns:
```mysql
SELECT * FROM customers
WHERE city = 'Pune' AND last_name = 'Sharma';
```

👉 This will use the multi-column index efficiently.

---

###  Real-World Analogy (Index)

- **Book Index** : Instead of reading the whole book, you jump to the page using the index.
- Similarly, MySQL uses an index to jump directly to the required row.

---

	Nice start 👍 Subqueries are really powerful in SQL — let’s polish your notes and add another useful example.

---

# Subqueries in SQL

- Definition:  
    A **subquery** is a query nested inside another SQL query.  
    It can be used in `SELECT`, `FROM`, `WHERE`, or `HAVING` clauses.
- Types of Subqueries:
    1. **Single-row subquery** → returns only one value.
    2. **Multi-row subquery** → returns multiple rows.
    3. **Correlated subquery** → depends on the outer query for execution.        

---

| Employee_id | first_name | last_name | hourly_pay | job             | hiredate   | supervisor_id |
|-------------|------------|-----------|------------|-----------------|------------|---------------|
| 101         | Alice      | Johnson   | 25.50      | Software Dev    | 2021-06-15 | 104           |
| 102         | Bob        | Smith     | 22.00      | QA Engineer     | 2022-01-10 | 104           |
| 103         | Carol      | Davis     | 18.75      | Tech Support    | 2023-03-05 | 101           |
| 104         | David      | Wilson    | 30.00      | Project Manager | 2020-11-20 | NULL          |
| 105         | Eva        | Brown     | 19.50      | Intern          | 2023-07-01 | 103           |


### Example 1: Average Pay Comparison ✅

Compare employees’ hourly pay with the average pay.

```mysql
SELECT first_name, last_name, hourly_pay,
       (SELECT AVG(hourly_pay) FROM employees) AS avg_pay
FROM employees;

-- Employees who earn more than the average
SELECT first_name, last_name, hourly_pay
FROM employees
WHERE hourly_pay > (SELECT AVG(hourly_pay) FROM employees);
```

---

### Example 2: Find Employees with the Highest Salary

We want to get the details of employees who earn the **maximum hourly pay**.

```mysql
SELECT first_name, last_name, hourly_pay
FROM employees
WHERE hourly_pay = (SELECT MAX(hourly_pay) FROM employees);
```

👉 This avoids manually checking who earns the most.

---

### Example 3: Correlated Subquery (Supervisor’s Pay)

Find employees who earn **more than their supervisor**.

```mysql
SELECT e.first_name, e.last_name, e.hourly_pay, e.supervisor_id
FROM employees e
WHERE e.hourly_pay > (
    SELECT s.hourly_pay
    FROM employees s
    WHERE s.employee_id = e.supervisor_id
);
```

👉 Here the subquery depends on each row of the outer query (`e.supervisor_id`), making it **correlated**.

---

📌 Key Takeaways:

- Subqueries allow you to reuse queries inside others.
- They can appear in different clauses (`SELECT`, `FROM`, `WHERE`).
- Useful for comparisons, filtering, and deriving new insights.

---
