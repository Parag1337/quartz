---
title: Untitled
date: 2025-11-16
tags: 
---

# 📘 Database – Definition

A **Database** is an organized collection of structured or unstructured data stored electronically so that it can be **easily accessed, managed, updated, and retrieved**.


---

# 🟩 What is MongoDB?

**MongoDB** is an **open-source, NoSQL (non-relational) database**, which stores data in **BSON (Binary JSON) document format**.

### 📌 Key Points:

- It is non-relational database/ 
- Stores **semi-structured & unstructured** data
- **Schema-less**, meaning structure can change anytime
- Faster for handling large, real-time, distributed data.
- Used in modern, scalable applications

MongoDB stores data in flexible documents. Instead of having multiple tables you can simply keep all of your related data together. This makes reading your data very fast.

You can still have multiple groups of data too. In MongoDB, instead of tables these are called collections.

### 📂 MongoDB Data Storage:

```
Database → Collections → Documents → Fields
```

Example document:

```json
{
  "name": "Parag",
  "age": 19,
  "skills": ["Python", "Web Dev"]
}
```

---

# 🆚 SQL vs NoSQL (MySQL vs MongoDB)

| Feature        | MySQL                             | MongoDB                            |
| -------------- | --------------------------------- | ---------------------------------- |
| Type           | SQL / Relational DB               | NoSQL / Document DB                |
| Data Format    | Tables (Rows & Columns)           | JSON-like Documents                |
| Schema         | Fixed, must define columns        | Schema-less (flexible)             |
| Best For       | Structured data, transactions     | Big & evolving data                |
| Query Language | SQL                               | MongoDB Query Language             |
| Joins          | Supported                         | Not preferred, but possible        |
| Scaling        | Vertical (more power to server)   | Horizontal (more servers)          |
| Speed          | Slower for huge unstructured data | Faster for large, distributed data |

---

# 🧠 When to use which?

### ✔ Use **MySQL** when:

- Banking, finance, e-commerce orders
- Data is structured and relationships are important
- Transaction must be accurate (ACID compliance

### ✔ Use **MongoDB** when:

- IoT, real-time analytics, chat apps, social media
- Data format can change frequently
- Need fast reads & writes with high scalability

---

# [[MongoDB Document]]

# [[MongoDB Commands]]

---

# [[Types Of NoSQL]]

## Types of NoSQL Database

NoSQL databases can be classified into ****four main types****, based on their data storage and retrieval methods:

1. Document-based databases
2. Key-value stores
3. Column-oriented databases
4. Graph-based databases

Each type has unique advantages and use cases, making NoSQL a preferred choice for big data applications, real-time analytics, cloud computing and distributed systems.

![Types of NoSQL Database](https://media.geeksforgeeks.org/wp-content/uploads/20220405112418/NoSQLDatabases.jpg)

## 1. Document-Based Database

