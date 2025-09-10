---
title: SQL Constraints
---

## 🔹 UNIQUE Constraint

Ensures that a column’s values are **unique** (no duplicates allowed).

```mysql
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(25) UNIQUE,
    price DECIMAL(6,2)
);
```

Or add later:

```mysql
ALTER TABLE products
ADD CONSTRAINT uq_product_name UNIQUE(product_name);
```

 Each column can have at most one UNIQUE constraint, but a table can have multiple different unique columns.

---

## 🔹 NOT NULL Constraint

Ensures a column cannot contain NUL.

```mysql
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(25) NOT NULL,
    price DECIMAL(6,2) NOT NULL
);
```

Or modify later:

```mysql
ALTER TABLE products
MODIFY price DECIMAL(6,2) NOT NULL;
```

 Prevents missing/empty values in critical fields.

---

## 🔹 CHECK Constraint

Ensures values meet a **condition**.

```mysql
CREATE TABLE employees (
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hourly_pay DECIMAL(5,2),
    hire_date DATE,
    CONSTRAINT chk_hourly_pay CHECK (hourly_pay >= 10.00)
);
```

Or add later:

```mysql
ALTER TABLE employees
ADD CONSTRAINT chk_hourly_pay CHECK(hourly_pay >= 10.00);
```

Drop a check constraint:

```mysql
ALTER TABLE employees
DROP CHECK chk_hourly_pay;
```

 Good for salary ranges, age limits, stock > 0, etc.

---

## 🔹 DEFAULT Constraint

Provides a default value when none is specified.

```mysql
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(25),
    price DECIMAL(6,2) DEFAULT 0
);
```

 Example: If `price` is not given → it will default to `0`.

Or Add later :
```MYSQL
ALTER TABLE products
ALTER price SET DEFAULT
```


An Example : 
```mysql
CREATE TABLE transaction (
	id INT,
	amount DECIMAL(5,2),
	transaction_date DATETIME DEFAULT NOW()
);

INSERT INTO transaction (id,amount)
VALUES  (1,4.99),
		(2,5.22);
```

---

## 🔹Primary Key

A Unique identifier in the table

```mysql
CREATE TABLE transactions(
	id INT PRIMARY KEY,
	amount DECIMAL(5,2),
);
```

Or add later
```mysql
ALTER TABLE transactions
ADD CONSTRAINT 
PRIMARY KEY(id)
```

- **It is Should be only one in one table**
- **No Duplication & NULL allowed in primary key**
---
## 🔹AUTO_INCREMENT

```MYSQL
CREATE TABLE transaction (
	tranaction_id INT PRIMARY KEY AUTO_INCREMENT,
	amount DECIMAL(5,2)
)
```

Or add later
```

```

Example 
```mysql
INSERT INTO transactions (amount)
VALUES(4.99);
SELECT * FROM transaction;

-- Now here we dont needed to insert trans_id it is set automatically and will increaser automatically 
```

We can also set auto_increment 
```mysql
ALTER TABLE transaction
AUTO_INCREMENT = 100;

-- now it it will start from 100 and increment by 1
```

---
## 🔹FOREIGN KEY



A **Foreign Key (FK)** is a column (or set of columns) in one table that refers to the **Primary Key** in another table.

- It creates a **relationship** between two tables.
- Ensures that the value in the foreign key column **must exist in the referenced (parent) table**.

###  Example

#### 1. Create a **Parent Table** (Departments)

```sql
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);
```

#### 2. Create a **Child Table** (Employees) with FK

```sql
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
```

📌 Here:

- `departments.dept_id` → Primary Key (Parent).
- `employees.dept_id` → Foreign Key (Child).

This means:  
 An employee can only be assigned to a **department that exists** in the `departments` table.

---

###  How It Works

1. Insert valid data:

```sql
INSERT INTO departments VALUES (1, 'HR'), (2, 'IT');
INSERT INTO employees VALUES (101, 'Alice', 1), (102, 'Bob', 2);
```

✅ Works fine because dept_id `1` and `2` exist in departments.

2. Try inserting invalid data:

```sql
INSERT INTO employees VALUES (103, 'Charlie', 5);
```

 Error → Cannot add because `dept_id = 5` doesn’t exist in parent table.

---

### Foreign Key Actions (ON DELETE / ON UPDATE)

When the parent row changes or is deleted, what should happen to the child rows?

- **ON DELETE CASCADE** → If department is deleted, all employees in it are deleted too.
- **ON DELETE SET NULL** → If department is deleted, employee’s dept_id becomes NULL.
- **ON DELETE RESTRICT** (default) → Prevent deleting department if employees exist.
- **ON UPDATE CASCADE** → If dept_id changes, it updates automatically in employees.

📌 Example:

```sql
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
```

- You can define FK **when creating table** or later using `ALTER TABLE`.

```sql
ALTER TABLE employees
ADD CONSTRAINT fk_dept
FOREIGN KEY (dept_id) REFERENCES departments(dept_id);
```

---

## ON DELETE Constraint 

- ON DELETE SET NULL = When a FK is deleted, replace FK with NULL
- ON DELETE CASCADE = When a FK is deleted , delete row 

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
```mysql
CREATE TABLE transactions (
	transaction_id INT PRIMARY KEY,
	amount DECIMAL(5, 2),
	customer_id INT,
	order_date DATE,
	FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
	ON DELETE SET NULL  -- Now if we delete it will set the value tp null
);
```

Or we can also add during foregin key creation 
```mysql
ALTER TABLE transactions
	ADD CONSTRAINT fk_customer_id
	FOREIGN KEY(customer_id) REFERENCES customers (customer_id)
	ON DELETE SET NULL;
```