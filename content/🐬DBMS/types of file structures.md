---
title: types of file structures
date: 2025-11-23
tags: 
---
# ⭐ **What is File Organization?**

File Organization = **How records are arranged (organized) inside a file and stored in disk blocks**.

✔ It decides **how to insert, search, update, delete records**  
✔ It affects **speed** and **efficiency** of DBMS operations  
✔ It decides **where** and **how** records go inside blocks on secondary storage

📌 **It is a logical relationship among records AND how these are mapped to physical disk blocks.**

---

# ⭐ **Why File Organization Matters?**

Because:

- Some applications need fast searching
- Some need fast insertion
- Some need sorted data
- Some need less disk usage

So DBMS uses different file organizations.


## 1️⃣ **Pile File (Sequential Store)**

This is the simplest method.

### ✔ HOW IT WORKS:

- Records are stored **one after another**.
- Just append the new record at the end.
- No sorting.
- No ordering.
### ✔ Example:

Insert students in the order they arrive:

`(5, A) → (2, B) → (10, C) → (1, D)`

Stored exactly in this sequence.

### 🔸 Advantages:

- Fast insertion
    
- Very simple
    

### 🔸 Disadvantages:

- Searching becomes slow (linear search)
    
- Not good for large data
    
![[Pasted image 20251123001321.png|200]]

---

## 2️⃣ **Sorted File Method**

Here records are stored in **sorted order**, usually on **primary key**.

### ✔ HOW IT WORKS:

- Insert new record at the end
    
- Then **sort the entire file**
    
- Place the new record in the correct position
    

Example:  
Insert: (5), (2), (10), (1)

Sorted storage:

`(1), (2), (5), (10)`

### ✔ When updating a record:

- Modify record
    
- Sort again
    
- Put updated record in correct position
    

### 🔸 Advantages:

- Very fast searching (binary search)
    
- Good for range queries (e.g., marks 60–80)
    

### 🔸 Disadvantages:

- Insertion is slow (because sorting needed)
    
- Deleting is also slow
    


---

## 3️⃣ **Heap File Organization**

Also called **unordered file**, used widely in databases.

### ✔ HOW IT WORKS:

- Database storage = many **data blocks** (pages)
    
- New record is placed in **any free block**
    
- No sorting needed
    
- No record order maintained
    

### ✔ Example:

Block structure:

`Block 1: A, D, E   Block 2: B   Block 3: C, F`  

If Block 1 is full → place new record in Block 2 or Block 3  
There is **no fixed order**.

### 🔸 Advantages:

- Very fast insertion
- Efficient storage usage

### 🔸 Disadvantages:

- Searching is slow (must scan all blocks)
- Not suitable for sorted data requirement
![[Pasted image 20251123001348.png|300]]

Sure Parag — let me explain all **three file structures** again in the **easiest way possible**, using simple language, diagrams, and examples, so you understand everything clearly:

✅ **Hash File Organization**  
✅ **B+ Tree File Organization**  
✅ **Indexed Sequential Access Method (ISAM)**

---
## ⭐ 1. **Hash File Organization (Fastest for exact searches)**

Hashing uses a **Hash Function** on a key (like RollNo) to decide _exactly which disk block_ will store the record.
## ✔️ How it works

You choose a **hash key**, usually the primary key.  
Example: RollNo = 25

Apply a **hash function**, e.g.:

```
Hash( key ) = key % 10
```

So:

```
25 % 10 = 5 → store record in Block 5
```

## ✔️ For Retrieval

To search RollNo = 25:

1. Compute hash → 25 % 10 = 5
    
2. Go directly to Block 5
    
3. Retrieve the record
    

📌 No scanning, no searching → **direct access**.

## ✔️ For Insertion

Insert RollNo = 37:

```
37 % 10 = 7 → store in Block 7
```

Insertion is **also direct**.

## ✔️ For Update/Delete

Same process:

1. Compute hash
2. Go to block
3. Update or delete the recor
---
## ⭐ 2. **B+ Tree File Organization (Best for searching + range queries)**

B+ Tree uses a **balanced tree structure** with multiple levels.

It is an advanced form of **indexing**.

## ✔️ Basic Structure

- **Root node** → top of the tree
- **Internal nodes** → guide the search (like road signs)
- **Leaf nodes** → store **all actual records**
    
📌 Only **leaf nodes** contain real data  
📌 Internal nodes contain only keys + pointers

---

## ✔️ Example from your notes

### Root node:

```
[25]
```

Left side → smaller values  
Right side → larger values

### Internal nodes:

Left child = 15  
Right child = 30

These **do not store records**, only pointers.

### Leaf node:

Contains the **actual records**:

```
10, 12, 17, 20, 24, 27, 29
```

---

## ✔️ Why B+ Tree is powerful?

- Always sorted
- Searching is fast (logarithmic time)
- Range queries fast (e.g., marks 10–30)

---

## ✔️ How searching works

To search 24:

1. Start at root: 25
    
2. 24 < 25 → go left
    
3. Go to child node: 15
    
4. 24 > 15 → go to right pointer
    
5. Reach leaf node
    
6. Read sorted records → find 24
    

---


## ⭐ 3. **Indexed Sequential Access Method (ISAM)**

ISAM is like a combination of:

1. **Sequential file** (sorted records)
2. **Index** (for fast searching)

---

## ✔️ How it works

- Records are stored **sequentially** on disk (sorted by primary key)
    
- For each record, an **index entry** is created
    
- Index contains:
    
    ```
    Key → Address of record block
    ```
    

Example:

```
Primary key: 20 → Address: Block 7
```

---

## ✔️ Searching using ISAM

To search a particular record:

1. Look at index
    
2. Get the block address
    
3. Retrieve the record
    

⭐ Faster than sequential search  
⭐ Slower than B+ Tree for huge data (because ISAM index is static)

## ✔️ Structure in simple terms

- **Data File** (sequential, sorted)
- **Primary Index File** (key + pointer)
- **Overflow pages** if file becomes full




