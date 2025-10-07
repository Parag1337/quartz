---
title: 📦 Collections
---

## 1. 📋 **List**


- **Syntax:** `[]`
- ✅ **Ordered**
- ✅ **Mutable (changeable)**
- ✅ Allows **duplicates**

```python
fruits = ["apple", "orange", "banana", "coconut"]

print(fruits[0])  # Access first item
for fruit in fruits:
    print(fruit)  # Iterate over list
```
#### 🔧 Common List Operations

| Operation                       | Description            | Example                                 |
| ------------------------------- | ---------------------- | --------------------------------------- |
| `fruits.append("kiwi")`         | Add item to end        | `['apple', 'orange', 'banana', 'kiwi']` |
| `fruits.insert(0, "pineapple")` | Insert at index        | `['pineapple', 'apple', ...]`           |
| `fruits.remove("apple")`        | Remove by value        | `['orange', 'banana']`                  |
| `fruits.pop()`                  | Remove last item       | `['apple', 'orange']`                   |
| `fruits.pop(1)`                 | Remove item at index 1 | `['apple', 'banana']`                   |
| `fruits[0] = "guava"`           | Modify item            | `['guava', 'orange']`                   |
| `fruits.clear()`                | Empty the list         | `[]`                                    |
| `fruits.sort()`                 | Sort ascending         | `['apple', 'banana', 'orange']`         |
| `fruits.reverse()`              | Reverse list order     | `['coconut', 'banana', 'apple']`        |
| `fruits.copy()`                 | Create a shallow copy  | `new_list = fruits.copy()`              |
| `fruits.index("banana")`        | Find index of item     | `2`                                     |
| `fruits.count("orange")`        | Count item occurrences | `1`                                     |
| `"apple" in fruits`             | Membership test        | `True`                                  |

| Function         | Description         | Example                     |
| ---------------- | ------------------- | --------------------------- |
| `len(fruits)`    | Get number of items | `len(["a", "b", "c"]) → 3`  |
| `max([3, 7, 1])` | Largest item        | `7`                         |
| `min([3, 7, 1])` | Smallest item       | `1`                         |
| `sum([1, 2, 3])` | Total sum           | `6`                         |
| `list("hello")`  | Convert to list     | `['h', 'e', 'l', 'l', 'o']` |

#### 📘 Help & Info

```python
print(dir(fruits))   # List all list methods
print(help(list))    # Documentation for list
```
---

## 2. **Tuple**

- **Syntax:** `()`
- ✅ **Ordered**
- ❌ **Immutable** (unchangeable)
- ✅ **Allows duplicates**
- ⚡ **Faster** than lists (good for fixed collections)
    

```python
coordinates = (10.5, 20.3)
print(coordinates[1])  # Access second item → 20.3
```

### 🔁 Convert Tuple ↔️ List (if needed):

```python
t = (1, 2, 3)
temp = list(t)
temp.append(4)
t = tuple(temp)
print(t)  # Output: (1, 2, 3, 4)
```

---
## 3. **Set**

- **Syntax:** `{}` or `set()`
- ❌ **Unordered** (no indexing)
- ✅ **Mutable** (can add/remove items)
- ❌ **No duplicates allowed**
- ⚡ **Efficient** for membership checks and set operations

```python
my_set = {"apple", "banana", "cherry"}
my_set.add("orange")           # Add an item
my_set.remove("banana")        # Remove item (error if not found)
print("apple" in my_set)       # Membership check → True
```


A = {0, 2, 4, 6, 8}

B = {1, 2, 3, 4, 5}

 union

print("Union :", A | B)

 intersection

print("Intersection :", A & B)

 difference

print("Difference :", A - B)

symmetric difference

print("Symmetric difference :", A ^ B)
### 🔧 Common Set Operations

| Operation      | Description                        | Example              |
| -------------- | ---------------------------------- | -------------------- |
| `a.add(x)`     | Add item                           | `a.add(5)`           |
| `a.remove(x)`  | Remove item (error if not present) | `a.remove(2)`        |
| `a.discard(x)` | Remove item (no error if missing)  | `a.discard(100)`     |
| `a.clear()`    | Empty the set                      | `a.clear()`          |
| `len(a)`       | Size of set                        | `len({1, 2, 3}) → 3` |
| `x in a`       | Membership check                   | `2 in a → True`      |

### 🔁 Set Operations

| Operation                   | Description                      | Example                        |
| --------------------------- | -------------------------------- | ------------------------------ |
| `a.union(b)`                | Combine all elements             | `a.union(b)`                   |
| `a.intersection(b)`         | Common elements                  | `a & b` or `a.intersection(b)` |
| `a.difference(b)`           | Items only in `a`                | `a - b`                        |
| `a.symmetric_difference(b)` | Items in `a` or `b` but not both | `a ^ b`                        |

### 🔄 Convert to Set

```python
unique_chars = set("hello")  # → {'e', 'h', 'l', 'o'}
```

---
## 4. **2D Lists (Nested Lists)**

- 📦 A **list inside another list** — like a **matrix** or **table**
- ✅ **Ordered**, ✅ **Mutable**, ✅ **Allows duplicates**

```python
fruits = ["apple", "orange", "banana", "coconut"]
vegetables = ["celery", "carrots", "potatoes"]
meats = ["chicken", "fish", "turkey"]

groceries = [fruits, vegetables, meats]

print(groceries[1])       # ['celery', 'carrots', 'potatoes']
print(groceries[0][3])    # 'coconut'
```
### 🔁 Loop Through 2D List

```python
for category in groceries:
    for item in category:
        print(item)
```
### 📌 Common Use Cases

|Operation|Description|Example|
|---|---|---|
|`groceries[0]`|Access first list (`fruits`)|`["apple", "orange", ...]`|
|`groceries[2][1]`|Second item in third list|`"fish"`|
|`len(groceries)`|Number of inner lists|`3`|
|`len(groceries[0])`|Items in first inner list|`4`|

---
## 5.🗂️ **Dictionary** 

- **Syntax:** `{ key: value }`
- 📋 **Ordered** (from Python 3.7+)
- 🔄 **Changeable** (mutable)
- 🚫 **No duplicate keys** (keys must be unique)

```python
capitals = {
    "USA": "Washington D.C.",
    "India": "New Delhi",
    "China": "Beijing",
    "Russia": "Moscow"
}

print(capitals.get("USA"))  # Washington D.C.
```
#### 🛠️ Updating & Removing Items

```python
capitals.update({"Germany": "Berlin"})    # Add new key-value
capitals.update({"USA": "Detroit"})       # Update existing value
capitals.pop("China")                      # Remove item by key
capitals.popitem()                         # Remove last inserted item
```
#### 🔑 Accessing Keys, Values, and Items

```python
for key in capitals.keys():
    print(key)            # Prints all keys

for value in capitals.values():
    print(value)          # Prints all values

for key, value in capitals.items():
    print(f"{key} : {value}")  # Prints key-value pairs
```

#### 📌 Quick Reference Table

|Operation|Description|Example|
|---|---|---|
|`capitals["India"]`|Access value by key|`"New Delhi"`|
|`capitals.get("USA")`|Safe access (returns None if key missing)|`"Washington D.C."` or None|
|`capitals.update({"UK":"London"})`|Add or update key-value|Adds `"UK": "London"`|
|`capitals.pop("Russia")`|Remove item by key|Removes `"Russia"`|
|`capitals.popitem()`|Remove last inserted item|Removes last added item|
|`capitals.keys()`|Get all keys|`dict_keys([...])`|
|`capitals.values()`|Get all values|`dict_values([...])`|
|`capitals.items()`|Get all key-value pairs|`dict_items([...])`|

---

### 🔍 Help & Info

```python
print(dir(capitals))     # List dictionary methods
print(help(capitals))    # Detailed documentation
```

---