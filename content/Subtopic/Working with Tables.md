---
title: "tables"
date: 2000-01-01
tags: [foo, bar]
---

## 🏗️ 1. Create a Table

```sql
-- Create a table named 'employees'
CREATE TABLE employees (
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hourly_pay DECIMAL(5,2),
    hire_date DATE
);
```

---

## ➕ 2. Insert Data into Table

```sql
-- Insert a single row
INSERT INTO employees
VALUES (1, "Eugene", "Krabs", 25.50, "2023-01-02");
	
-- Insert multiple rows at once
INSERT INTO employees
VALUES
    (2, "Squidward", "Tentacles", 15.00, "2023-01-03"),
    (3, "Spongebob", "Squarepants", 12.50, "2023-01-04"),
    (4, "Patrick", "Star", 12.50, "2023-01-05"),
    (5, "Sandy", "Cheeks", 17.25, "2023-01-06");

-- Insert specific columns only (optional columns)
INSERT INTO employees (employee_id, first_name, last_name)
VALUES (6, "Sheldon", "Plankton");
```

🧠 **Notes:**

- Always match the **order of values** with the **columns**.
- If you specify columns manually, you can skip some columns like `hourly_pay` and `hire_date`.

---

## 🔍 3. View Data

```sql
-- View all data
SELECT * FROM employees;

-- View specific columns
SELECT first_name, last_name FROM employees;

-- View a specific employee by ID
SELECT * FROM employees
WHERE employee_id = 1;

-- View employees with hourly pay >= 15
SELECT * FROM employees
WHERE hourly_pay >= 15;

-- View employees with NULL hire_date
SELECT * FROM employees
WHERE hire_date IS NULL;

-- View employees with NOT NULL hire_date
SELECT * FROM employees
WHERE hire_date IS NOT NULL;
```

🧠 **Notes:**

- `*` means select **all columns**.
- `WHERE` is used for **filtering** specific rows.

---

## ✏️ 4. Update Data

```sql
-- Update hourly_pay of a specific employee
UPDATE employees
SET hourly_pay = 10.25
WHERE employee_id = 6;

-- Check if the update worked
SELECT * FROM employees;
```

🧠 **Notes:**

- Always use a **WHERE clause** in `UPDATE`, otherwise **all rows** will be updated!


---

## 🗑️ 5. Delete Data

```sql
-- Delete a specific employee
DELETE FROM employees
WHERE employee_id = 6;

-- Check if the deletion worked
SELECT * FROM employees;
```

🧠 **Notes:**

- **CAUTION:** Without `WHERE`, `DELETE` will remove **all records**.
---

## 🔧 6. Alter Table (Modify Structure)

```sql
-- Add a new column 'phone_number'
ALTER TABLE employees
ADD phone_number VARCHAR(15);

-- Rename the column 'phone_number' to 'email'
ALTER TABLE employees
RENAME COLUMN phone_number TO email;

-- Modify 'email' column size and move after 'last_name'
ALTER TABLE employees
MODIFY COLUMN email VARCHAR(100)
AFTER last_name;

-- Move a column to be FIRST in the table (optional)
-- Example: Move 'email' to the first column

ALTER TABLE employees
MODIFY COLUMN email VARCHAR(100) FIRST;

-- Drop (delete) the 'email' column
ALTER TABLE employees
DROP COLUMN email;
```

---

## 🏷️ 7. Rename and Drop Table

```sql
-- Rename table 'employees' to 'workers'
RENAME TABLE employees TO workers;

-- Drop (delete) the 'employees' table
DROP TABLE employees;
```
