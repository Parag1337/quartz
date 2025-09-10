---
title: SQL Transactions & Date Time
---

##  Autocommit, Commit & Rollback

- By default, most SQL databases run in Autocommit = ON mode (every statement is saved immediately).
- You can disable autocommit to manually control transactions:

```sql
SET autocommit = OFF;   -- disables automatic saving
```

Now you must explicitly use:

- **COMMIT;** → saves (persists) all changes since the last commit.
- **ROLLBACK;** → undoes all changes since the last commit.
- **AUTOCOMMIT;** → can be turned ON/OFF to control transaction mode.

💡 Example:

```sql
START TRANSACTION;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;

ROLLBACK;  -- cancels both updates if something goes wrong
COMMIT;    -- saves permanently if everything is correct
```

---

# Date 
```sql
CREATE TABLE test(
    my_date DATE,
    my_time TIME,
    my_datetime DATETIME
);

INSERT INTO test
VALUES (CURRENT_DATE(), CURRENT_TIME(), NOW());
```

- **DATE** → stores only date (`YYYY-MM-DD`).
- **TIME** → stores only time (`HH:MM:SS`).
- **DATETIME** → stores both date and time (`YYYY-MM-DD HH:MM:SS`).
- `CURRENT_DATE()` → current date.
- `CURRENT_TIME()` → current time.
- `NOW()` → current date + time.

💡 Useful for banking transactions, logs, timestamps.