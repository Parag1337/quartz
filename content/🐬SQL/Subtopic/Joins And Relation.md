---
name: Joins And Relation
---


## ✅ Example: Foreign Key

```mysql
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);
```

```mysql
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
```

---

# Joins
## 1. **INNER JOIN**

Returns **only the matching rows** between two tables.

```mysql
SELECT * 
FROM transactions  
INNER JOIN customers
ON transactions.customer_id = customers.customer_id;
```

👉 You can also select specific columns:

```mysql
SELECT transaction_id, amount, first_name, last_name
FROM transactions
INNER JOIN customers
ON transactions.customer_id = customers.customer_id;
```


![[Pasted image 20250825195839.png|200]]![[Pasted image 20250825195832.png|500]]  


---

## 2. **LEFT JOIN**

Returns **all rows from the left table** (`transactions`) and the **matching rows from the right table** (`customers`).  
If no match exists → NULL is shown.

```mysql
SELECT * FROM transactions
LEFT JOIN customers
ON transactions.customer_id = customers.customer_id;
```

📸  
![[Pasted image 20250825200309.png|200]]  
![[Pasted image 20250825200328.png|250]]

💡 Use this when you want to keep **all transactions**, even if some don’t have customer info.

---

## 3. **RIGHT JOIN**

Returns **all rows from the right table** (`customers`) and the **matching rows from the left table** (`transactions`).  
If no match exists → NULL is shown.

```mysql
SELECT * 
FROM transactions
RIGHT JOIN customers
ON transactions.customer_id = customers.customer_id;
```

📸  
![[Pasted image 20250825200532.png|200]]  
![[Pasted image 20250825200545.png|250]]

💡 Use this when you want to keep **all customers**, even if some don’t have transactions.

---
# Union 

UNION combines the result of two or more SELECT statement 
```MYSQL
SELECT * FROM employees;
UNION 
SLECT * FROM customers;
```

```MYSQL
SELECT * FROM employees;
UNION ALL -- now duplicates will be also shown
SLECT * FROM customers;
```

---

Great question 👍 Self-joins are an important SQL concept. Let’s break it down in simple words and add examples for your notes.

---

# 🔹 Self Join in SQL

###  What is a Self Join?

- A **self join** is a regular join but the **table is joined with itself**. 
- Useful when we need to **compare rows within the same table**.
- We use **table aliases** to differentiate the two copies.

---

### Example Table: `employees`

|emp_id|name|manager_id|
|---|---|---|
|1|John|NULL|
|2|Alice|1|
|3|Bob|1|
|4|Carol|2|
|5|David|2|

Here:

- `emp_id` → employee’s unique ID
    
- `manager_id` → references the employee ID of the manager
    

---

### Example: Find each employee’s manager

```mysql
SELECT e.name AS Employee,
       m.name AS Manager
FROM employees e
JOIN employees m
  ON e.manager_id = m.emp_id;
```

**Result:**

|Employee|Manager|
|---|---|
|Alice|John|
|Bob|John|
|Carol|Alice|
|David|Alice|

---

### Example: Employees working under the same manager

```mysql
SELECT e1.name AS Employee1,
       e2.name AS Employee2,
       e1.manager_id
FROM employees e1
JOIN employees e2
  ON e1.manager_id = e2.manager_id
 AND e1.emp_id < e2.emp_id;
```

This pairs employees reporting to the same boss.

---

