---
title : Arrays
---
## ✅ **What is an Array?**

An **array** is a collection of elements of the **same data type**, stored in **contiguous memory locations**, and accessed using an **index**.  
📌 **Index starts from 0** in C++.

---

## 🧱 **Array Syntax**

```cpp
data_type array_name[size];
```

Example:

```cpp
int numbers[5] = {10, 20, 30, 40, 50};
```

---

## 📌 **Key Features**

- Stores **multiple values** in a single variable.
- Elements are stored in **contiguous memory**.
- Accessed by **index** (`array[0]`, `array[1]`...).
- Size must be **fixed at compile time** (for static arrays).

---

## 🧮 **Accessing Array Elements**

```cpp
cout << numbers[0];  // Output: 10
numbers[2] = 100;    // Update value at index 2
```

---

## 🔁 **Types of Arrays**

| Type              | Description                               |
| ----------------- | ----------------------------------------- |
| **1D Array**      | Single row of elements (e.g., `int a[5]`) |
| **2D Array**      | Table (matrix) with rows and columns      |
| **Multi-D Array** | More than 2 dimensions                    |


---
## 🥓 **Size of the Array**

The size the array can be calculated by 

```cpp
int arr[15];
int size = sizeof(fith)/sizeof(int);
cout << size;
```

---

### ✅ **1D Array Example**

```cpp
int arr[5] = {1, 2, 3, 4, 5};
for(int i=0; i<5; i++) {
    cout << arr[i] << " ";
}
```

---

### ✅ **2D Array Example**

```cpp
int matrix[2][3] = {{1,2,3}, {4,5,6}};
cout << matrix[1][2];  // Output: 6
```

---

## 📌 **Advantages**

- Easy to store and access multiple values.
- Efficient for indexing and looping.

## ❌ **Disadvantages**

- Fixed size (cannot grow/shrink dynamically).
- Only stores same data type.


---
## [[Question on arrays]]

---

## 🧠 **Important Points**

- **Array index starts from 0**.
- **Size should be known at compile time** (for static arrays).
- Elements are stored in **continuous memory**.
- We can also use build in function for finding maximum and minimum value using `max(array,size)`, `min(array,size)`
- `Swap(arr[i],arr[i+1])` This will swap the value. 
---

- [ ]  **Array operations (traversal, insertion, deletion)**  
- [ ] **Difference between array and pointer**  
- [ ] **Dynamic arrays using `new` in C++**  
- [ ] **Memory representation diagram**