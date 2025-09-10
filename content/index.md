---
title: "index page"
---

# Stored Procedures 

###  What is a Stored Procedure?

- A stored procedure is a precompiled SQL program that you can save and reuse.
- Useful when you have queries you run **frequently** or want to **encapsulate logic**.

---

### Basic Stored Procedure

```mysql
DELIMITER $$

CREATE PROCEDURE get_customers()
BEGIN
    SELECT * FROM customers;
END $$

DELIMITER ;
```

- **DELIMITER** changes the statement terminator so MySQL knows where the procedure ends.
- **CALL** executes the procedure:

```mysql
CALL get_customers();
```

- **DROP** deletes the procedure:

```mysql
DROP PROCEDURE get_customers();
```

---

### ✅ Stored Procedure with Input Parameters

```mysql
DELIMITER $$

CREATE PROCEDURE find_customer(IN id INT)
BEGIN
    SELECT * FROM customers
    WHERE customer_id = id;
END $$

DELIMITER ;
```

- **IN** → Input parameter passed to the procedure.
- Execute with:
    

```mysql
CALL find_customer(2);
```

---

### ✅ Stored Procedure with Multiple Parameters

```mysql
DELIMITER $$

CREATE PROCEDURE find_customers(IN f_name VARCHAR(50), IN l_name VARCHAR(50))
BEGIN
    SELECT * FROM customers
    WHERE first_name = f_name AND last_name = l_name;
END $$

DELIMITER ;
```
Can pass **multiple input values**.
    
- Execute with:

```mysql
CALL find_customers('Alice', 'Johnson');
```

---

### 🔑 Key Points

- Use **DELIMITER** to avoid confusion with semicolons inside procedures.
- Parameters can be:
    - `IN` → input to procedure    
    - `OUT` → returns a value    
    - `INOUT` → both input and output

- Stored procedures improve **reusability**, **security**, and **performance**.
---


Absolutely! Let’s extend your **Stored Procedure** notes with an **OUT parameter example** — very useful for returning values from a procedure.  

---

## Stored Procedure with OUT Parameter  

### 🔹 What is an OUT Parameter?
- `OUT` parameters **return a value** from the procedure to the caller.  
- Useful when you want the procedure to **compute something** and give it back without using `SELECT` in the client.  

---

### ✅ Example: Return Total Customers
```mysql
DELIMITER $$

CREATE PROCEDURE get_total_customers(OUT total INT)
BEGIN
    SELECT COUNT(*) INTO total
    FROM customers;
END $$

DELIMITER ;
```

- `INTO total` → stores the result of `COUNT(*)` into the **OUT parameter**.  

---

### ✅ Calling the Procedure
```mysql
-- Declare a variable to store the output
SET @cust_count = 0;

-- Call the procedure with OUT parameter
CALL get_total_customers(@cust_count);

-- Check the returned value
SELECT @cust_count;
```

**Result:**  
| @cust_count |
|-------------|
| 10          |  👈 Total number of customers  

---

### ✅ Another Example: OUT + IN
Return the **full name** of a customer given their `customer_id`:

```mysql
DELIMITER $$

CREATE PROCEDURE get_customer_name(IN id INT, OUT full_name VARCHAR(100))
BEGIN
    SELECT CONCAT(first_name, ' ', last_name) INTO full_name
    FROM customers
    WHERE customer_id = id;
END $$

DELIMITER ;
```

#### Calling it:
```mysql
SET @name = '';

CALL get_customer_name(2, @name);

SELECT @name;
```

**Result:**  

| @name       |
|-------------|
| Alice Smith |

---

Perfect start! Let’s refine and improve your **Trigger** notes so they are clear, complete, and ready for exams/projects.

---

# Triggers in MySQL

### 🔹 What is a Trigger?

- A **trigger** is a **special kind of stored procedure** that automatically executes **when a specific event occurs** on a table.
- Events can be:
    - `INSERT` → when a new row is added    
    - `UPDATE` → when an existing row is modified
    - `DELETE` → when a row is deleted        
- Common uses:
    - Automatically update columnz
    - Enforce complex constraints        
    - Maintain audit logs
    - Validate or transform data

---

###  Example Table: `employees`

|employee_id|first_name|last_name|hourly_pay|salary|job|hire_date|
|---|---|---|---|---|---|---|
|101|Alice|Johnson|25.50|53040|Dev|2021-06-15|
|102|Bob|Smith|22.00|45760|QA|2022-01-10|

---

###  Trigger: Automatically Update Salary on `UPDATE`

```mysql
CREATE TRIGGER before_hourly_pay_update
BEFORE UPDATE ON employees
FOR EACH ROW
SET NEW.salary = (NEW.hourly_pay * 2080);
```

- `BEFORE UPDATE` → Trigger fires **before the update happens**.
- `NEW.salary` → Refers to the **new value** being updated.
- Example: If `hourly_pay` changes from 25.50 → 30.00, `salary` automatically updates: `30*2080 = 62400`.

---

###  Trigger: Automatically Set Salary on `INSERT`

```mysql
CREATE TRIGGER before_hourly_pay_insert
BEFORE INSERT ON employees
FOR EACH ROW
SET NEW.salary = (NEW.hourly_pay * 2080);
```

- `BEFORE INSERT` → Trigger fires before a new row is inserted.
    
- Ensures that `salary` is **always consistent** with `hourly_pay`.
    

---

### 🔑 Key Points

- Triggers are **automatic**; you don’t call them manually.
- Use `NEW.column_name` to refer to the **new row values**.
- Use `OLD.column_name` to refer to the **existing values** (useful in `UPDATE` and `DELETE`).
- Can create triggers for `BEFORE` or `AFTER` the event.

---

### 🔹 Example: Audit Table Trigger

Automatically log changes in salary:

```mysql
CREATE TRIGGER after_salary_update
AFTER UPDATE ON employees
FOR EACH ROW
INSERT INTO salary_audit(employee_id, old_salary, new_salary, updated_at)
VALUES(OLD.employee_id, OLD.salary, NEW.salary, NOW());
```

- Keeps a **history of salary changes** for auditing.

Another example

| expense_id | expense_name | expense_total |
| ---------- | ------------ | ------------- |
|            |              |               |

```mysql
CREATE TRIGGER after_salary_delete
AFTER DELETE ON employess
FOR EACH ROW
	UPDATE expense
	SET expense_total = expense_total - OLD.salary
	WHERE expense_name = "salaries"
```

---

## ⏱ Difference Between BEFORE and AFTER Triggers

|Feature|BEFORE Trigger|AFTER Trigger|
|---|---|---|
|**Execution Time**|Runs **before** the actual operation (INSERT, UPDATE, DELETE) is performed|Runs **after** the operation has completed|
|**Purpose**|- Modify values before saving- Validate data- Prevent invalid changes|- Audit/log changes- Notify systems- Perform actions based on committed data|
|**Access to Data**|Can use `NEW.column_name` to **change the values** that will be inserted/updated|Can use `NEW.column_name` to **read values**, but changing them has no effect on the table|
|**Use Case Example**|Automatically calculate `salary` based on `hourly_pay` before inserting/updating|Insert a row in **audit table** after salary is updated|
|**Effect on Original Row**|Can **modify the row** before it is written|Cannot modify the original row (only read it)|

---

### ✅ Example: BEFORE vs AFTER

**BEFORE INSERT** – Automatically calculate salary:

```mysql
CREATE TRIGGER before_insert_salary
BEFORE INSERT ON employees
FOR EACH ROW
SET NEW.salary = NEW.hourly_pay * 2080;
```

- If a row is inserted with `hourly_pay = 25`, `salary` becomes `25*2080 = 52000` **before the row is saved**.
    

**AFTER UPDATE** – Audit salary changes:

```mysql
CREATE TRIGGER after_salary_update
AFTER UPDATE ON employees
FOR EACH ROW
INSERT INTO salary_audit(employee_id, old_salary, new_salary, updated_at)
VALUES(OLD.employee_id, OLD.salary, NEW.salary, NOW());
```

- After an update, it **logs the old and new salary** in another table.
    

---

💡 **Tip to Remember:**

- **BEFORE → prepare/modify** (happens first)
- **AFTER → record/react** (happens later)

---
