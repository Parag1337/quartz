---
title: MongoDB Commands
date: 2025-11-18
tags: 
---

 Here is an improved and clearer version of your notes with better structure, formatting, and explanation:

---

## 📂 Working with Databases and Collections in MongoDB (using `mongosh`)

### Step 1: View all Databases

```bash
show dbs
```

This displays all existing databases **that contain data**.


### Step 2: Create / Switch to a Database

```bash
use blog
```

- If a database **already exists**, it **switches** to it.
    
- If it **does not exist**, MongoDB **registers it**, but it will only **actually appear** in `show dbs` once it contains **at least one collection with data**.
    
---
## 📁 Creating Collections in MongoDB

MongoDB allows two ways to create a collection.

### Method 1: Explicit Creation

Use the `createCollection()` method:

```js
db.createCollection("posts")
```

This **creates an empty collection** named **`posts`**.


### Method 2: Implicit Creation (Recommended / Common)

A collection can be created automatically **when you insert data into it**.

Example:

```js
object = { title: "Hello", likes: 5 };
db.posts.insertOne(object);
```

- If the `posts` collection **does not exist**, MongoDB will **create it automatically**
    
- Then it will **insert** the document into it.
    

#### 🔑 Important Notes

- MongoDB **does not require** you to pre-create collections like SQL tables.
- A collection **is not fully created** and **will not appear** in listings **until it stores at least one document**.
- This behavior makes MongoDB **schema-less and flexible**.


---
# Insert Document


There are 2 methods to insert documents into a MongoDB database.

### `insertOne()`

To insert a single document, use the `insertOne()` method.

This method inserts a single object into the database.

**Note:** When typing in the shell, after opening an object with curly braces "{" you can press enter to start a new line in the editor without executing the command. The command will execute when you press enter after closing the braces.

### Example

```jsx
db.posts.insertOne({
  title: "Post Title 1",
  body: "Body of post.",
  category: "News",
  likes: 1,
  tags: ["news", "events"],
  date: Date()
})
```

**Note:** If you try to insert documents into a collection that does not exist, MongoDB will create the collection automatically.

### `insertMany()`

To insert multiple documents at once, use the `insertMany()` method.

This method inserts an array of objects into the database.

### Example

```jsx
db.posts.insertMany([  
  {
    title: "Post Title 2",
    body: "Body of post.",
    category: "Event",
    likes: 2,
    tags: ["news", "events"],
    date: Date()
  },
  {
    title: "Post Title 3",
    body: "Body of post.",
    category: "Technology",
    likes: 3,
    tags: ["news", "events"],
    date: Date()
  },
  {
    title: "Post Title 4",
    body: "Body of post.",
    category: "Event",
    likes: 4,
    tags: ["news", "events"],
    date: Date()
  }
])
```


---

# 📌 Find Operations in MongoDB

MongoDB provides two main methods to retrieve (read) data from a collection:

- `find()`
- `findOne()`


## 🔍 1. `find()` Method

Used to **return multiple documents** that match a query.

- If no query is provided, **all documents** will be returned.
    

### ✔️ Example – Return All Documents

```js
db.posts.find()
```

### ✔️ Example – Return Matching Documents

```js
db.posts.find({ category: "News" })
```

Returns **all documents** where `category` equals `"News"`.

---
## 🔎 **2. `findOne()` Method**

Used to **return only the first matching document**.

- If no query is provided, the **first document** in the collection is returned.
    
- Even if multiple documents match, **only one document is returned**.
    

### ✔️ Example

```js
db.posts.findOne()
```

### ✔️ Example with Query

```js
db.posts.findOne({ category: "News" })
```

---

## 🎯 Projection (Selecting Specific Fields)

Both `find()` and `findOne()` accept a **second argument** called **projection**.

Projection determines **which fields to include or exclude** in the result.

- Use `1` → include field
- Use `0` → exclude field
- `_id` is always returned unless explicitly excluded
    
- You **cannot mix** `1` and `0` in the same projection object  
    (EXCEPT for `_id`)
    
### ✔️ Include Only Specific Fields

```js
db.posts.find({}, { title: 1, date: 1 })
```

Output includes: `_id`, `title`, `date`

### ✔️ Exclude `_id` Field

```js
db.posts.find({}, { _id: 0, title: 1, date: 1 })
```

### ✔️ Exclude a Field (All Others Returned)

```js
db.posts.find({}, { category: 0 })
```

### ❌ Invalid Projection (Mixing 1 and 0)

```js
db.posts.find({}, { title: 1, date: 0 })   // ❌ Not allowed
```

---

Here is an improved, well-structured, and clearer version of your notes with better formatting, explanation, and examples:

---

# 🛠 Updating Documents in MongoDB (using `mongosh`)

MongoDB provides two methods for updating documents:

- **`updateOne()`** — updates **only the first** matching document
- **`updateMany()`** — updates **all documents** that match the query

Both methods require **two main arguments**:

1. **Query / Filter** → selects which document(s) to update
2. **Update Object** → defines what changes to apply
    

Optionally, they can take a **third argument** (e.g., `{ upsert: true }`).

---

## 🔹 `updateOne()`

Updates the **first matching document**.

### 📌 Step 1: Check the existing document

```js
db.posts.find({ title: "Post Title 1" })
```

### 📌 Step 2: Update a field using `$set`

```js
db.posts.updateOne(
  { title: "Post Title 1" },
  { $set: { likes: 2 } }
)
```

### 📌 Step 3: Verify the update

```js
db.posts.find({ title: "Post Title 1" })
```

---

## 🆕 Upsert (Update or Insert)

If a document matching the query **does not exist**, you can insert it automatically using **`upsert: true`**.

### ✔️ Example: Update if found; insert if not

```js
db.posts.updateOne(
  { title: "Post Title 5" },
  {
    $set: {
      title: "Post Title 5",
      body: "Body of post.",
      category: "Event",
      likes: 5,
      tags: ["news", "events"],
      date: Date()
    }
  },
  { upsert: true }
)
```

---

## 🔹 `updateMany()`

Updates **all** documents that match the query.

Example: **Increase `likes` by 1** for every post.

```js
db.posts.updateMany(
  {},
  { $inc: { likes: 1 } }
)
```

Now verify the result:

```js
db.posts.find()
```

---

## 🧰 Common MongoDB Update Operators

| Operator | Description                   |
| -------- | ----------------------------- |
| `$set`   | Change specific field values  |
| `$inc`   | Increase or decrease a number |
| `$unset` | Remove a field                |
| `$push`  | Add item to array             |
| `$pull`  | Remove item from array        |

---

## 📝 Quick Summary

|Method|Updates|Inserts if not found?|
|---|---|---|
|`updateOne()`|First matching doc|Only if upsert is true|
|`updateMany()`|All matching docs|Only if upsert is true|

---

# Delete Documents

We can delete documents by using the methods `deleteOne()` or `deleteMany()`.

These methods accept a query object. The matching documents will be deleted.


## `deleteOne()`

The `deleteOne()` method will delete the first document that matches the query provided.

### Example

```jsx
db.posts.deleteOne({ title: "Post Title 5" })
```

---

## `deleteMany()`

The `deleteMany()` method will delete all documents that match the query provided.

### Example

```jsx
db.posts.deleteMany({ category: "Technology" })
```


---

# MongoDB Query Operators

There are many query operators that can be used to compare and reference document fields.

## Comparison

The following operators can be used in queries to compare values:

- `$eq`: Values are equal
- `$ne`: Values are not equal
- `$gt`: Value is greater than another value
- `$gte`: Value is greater than or equal to another value
- `$lt`: Value is less than another value
- `$lte`: Value is less than or equal to another value
- `$in`: Value is matched within an array
```js
// likes = 5
db.posts.find({ likes: { $eq: 5 } });

// likes NOT equal to 5
db.posts.find({ likes: { $ne: 5 } });

// likes greater than 3
db.posts.find({ likes: { $gt: 3 } });

// likes >= 3
db.posts.find({ likes: { $gte: 3 } });

// likes less than 4
db.posts.find({ likes: { $lt: 4 } });

// likes <= 4
db.posts.find({ likes: { $lte: 4 } });

// category is either "Event" or "Technology"
db.posts.find({ category: { $in: ["Event", "Technology"] } });

```

## Logical

The following operators can logically compare multiple queries.

- `$and`: Returns documents where both queries match
- `$or`: Returns documents where either query matches
- `$nor`: Returns documents where both queries fail to match
- `$not`: Returns documents where the query does not match.

```js
// likes > 3 AND category = "Event"
db.posts.find({
  $and: [
    { likes: { $gt: 3 } },
    { category: "Event" }
  ]
});

// likes > 3 OR category = "Event"
db.posts.find({
  $or: [
    { likes: { $gt: 3 } },
    { category: "Event" }
  ]
});

// NOT category = "Event"
db.posts.find({ category: { $not: { $eq: "Event" } } });

// likes NOT less than 3 (means likes >= 3)
db.posts.find({ likes: { $not: { $lt: 3 } } });

// neither likes > 4 nor category = "Event"
db.posts.find({
  $nor: [
    { likes: { $gt: 4 } },
    { category: "Event" }
  ]
});

```

### Evaluation

The following operators assist in evaluating documents.

- `$regex`: Allows the use of regular expressions when evaluating field values
- `$text`: Performs a text search
- `$where`: Uses a JavaScript expression to match documents



---

# 🔧 MongoDB **Update Operators**

Update operators are used within update commands like  
`updateOne()`, `updateMany()`, and `findOneAndUpdate()`.

---

## 📌 **1️⃣ Field Update Operators**

| Operator       | Purpose                                 | Example                                 |
| -------------- | --------------------------------------- | --------------------------------------- |
| `$currentDate` | Sets field to current date or timestamp | `{ $currentDate: { updatedAt: true } }` |
| `$inc`         | Increases or decreases a numeric value  | `{ $inc: { likes: 1 } }`                |
| `$rename`      | Renames a field                         | `{ $rename: { body: "content" } }`      |
| `$set`         | Updates/creates a field                 | `{ $set: { category: "Event" } }`       |
| `$unset`       | Removes a field completely              | `{ $unset: { tags: "" } }`              |

### Examples

```js
// Increase likes by 2
db.posts.updateOne({ title: "Post Title 1" }, { $inc: { likes: 2 } });

// Rename "body" to "content"
db.posts.updateOne({ title: "Post Title 1" }, { $rename: { body: "content" } });

// Add or update a field
db.posts.updateOne({ title: "Post Title 1" }, { $set: { status: "Published" } });

// Remove a field
db.posts.updateOne({ title: "Post Title 1" }, { $unset: { status: "" } });

// Add current date
db.posts.updateOne({ title: "Post Title 1" }, { $currentDate: { updatedAt: true } });
```

---

## 📌 2️⃣ Array Update Operators

|Operator|Purpose|Example meaning|
|---|---|---|
|`$addToSet`|Adds value only if not already present|Avoids duplicates|
|`$pop`|Removes first (`-1`) or last (`1`) element|Limit size|
|`$pull`|Removes matching elements|Filter array|
|`$push`|Adds value to array|Normal append|

### Examples

```js
// Add a new tag (duplicates allowed)
db.posts.updateOne({ title: "Post Title 1" }, { $push: { tags: "mongodb" } });

// Add unique tag (no duplicates)
db.posts.updateOne({ title: "Post Title 1" }, { $addToSet: { tags: "mongodb" } });

// Remove all elements equal to "news"
db.posts.updateOne({ title: "Post Title 1" }, { $pull: { tags: "news" } });

// Remove last element from array
db.posts.updateOne({ title: "Post Title 1" }, { $pop: { tags: 1 } });

// Remove first element from array
db.posts.updateOne({ title: "Post Title 1" }, { $pop: { tags: -1 } });
```

---

## 💡 Quick Tips

✔ `$set` is the **most common** update operator  
✔ `$inc` can be used to increment or decrement  
✔ `$unset` doesn't delete documents, only **fields**  
✔ `$addToSet` avoids duplicates (like `INSERT IGNORE`)  
✔ `$push` allows adding objects & nested arrays

---

