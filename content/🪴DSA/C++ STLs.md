---
title: C++ STLs
date: 2025-10-01
tags: 
---
Got it 👍 I’ll polish your notes for **STL Pairs & Vectors** into clean, well-structured Obsidian-style notes with headings, tables, code blocks, and explanations.

---

# C++ STL (Standard Template Library)

STL is divided into **4 main components**:

1. **Algorithms** – Predefined functions (sorting, searching, etc.)
2. **Containers** – Data structures (vector, set, map, etc.)
3. **Functions** – Utility functions (comparators, operators, etc.)
4. **Iterators** – Objects to point to elements inside containers

---

## 1. Pair

- A `pair` is a simple container to store **two values together**.
- Useful when you want to combine two different data items.

```cpp
pair<int, int> p = {1, 2};
cout << p.first << " " << p.second;  // 1 2
```

👉 Nested Pair:

```cpp
pair<int, pair<int, int>> p = {1, {3, 4}};
cout << p.first << " " << p.second.first << " " << p.second.second;
// Output: 1 3 4
```

👉 Array of Pairs:

```cpp
pair<int, int> arr[] = {{1,2}, {2,5}, {5,1}};
cout << arr[1].second;  // 5
```

---

## 2. Vectors

- A **dynamic array** (resizable).
- Unlike arrays, vectors can **grow/shrink at runtime**.

### **Declaration**

```cpp
vector<int> v;             // Empty vector
vector<int> v1(5, 100);    // {100, 100, 100, 100, 100}
vector<int> v2(5);         // {0, 0, 0, 0, 0} (default initialized)
vector<int> v3(v1);        // Copy of v1
```

---

### **Insertion**

```cpp
v.push_back(1);          // {1}
v.emplace_back(2);       // {1, 2} (faster, constructs in place)

// With pairs
vector<pair<int, int>> vec;
vec.push_back({1, 2});
vec.emplace_back(1, 2);  // cleaner than push_back
```

---
### **Accessing Elements**

```cpp
cout << v[0] << " " << v.at(0);  // Direct access
cout << v.back();                // Last element
```

---
### **Iterators**

Iterators behave like pointers to elements inside the container.

```cpp
vector<int>::iterator it = v.begin();   // points to first element
it++;
cout << *(it);  

vector<int>::iterator it = v.end();     // points to one position after last element
vector<int>::iterator it = v.rbegin();  // reverse begin (last element)
vector<int>::iterator it = v.rend();    // reverse end (before first element)
```

👉 Traversing with iterators:

```cpp
for (vector<int>::iterator it = v.begin(); it != v.end(); it++)
    cout << *(it) << " ";
```

👉 Using `auto` (modern way):

```cpp
for (auto it = v.begin(); it != v.end(); it++)
    cout << *(it) << " ";
```

👉 Range-based loop:

```cpp
for (auto it : v)
    cout << it << " ";
```

---

### **Modifiers**

```cpp
// Erase
v.erase(v.begin() + 1);                      // Remove 2nd element
v.erase(v.begin() + 2, v.begin() + 4);       // Remove range [2,4)

// Insert
v.insert(v.begin(), 300);                    // Insert at start
v.insert(v.begin() + 1, 2, 10);              // Insert 10 two times at index 1

vector<int> copy(2, 50);                     // {50, 50}
v.insert(v.begin(), copy.begin(), copy.end()); // Insert another vector
```

---

### **Other Functions**

```cpp
cout << v.size();     // Number of elements
cout << v.empty();    // Check if empty (1 = true, 0 = false)

v1.swap(v2);          // Swap contents
v.clear();            // Erase all elements
```

---

## 3. List

Same as vector but push front is also provided in this

To push in vector is very costlier than list 

```cpp
list<int>ls;
```
```cpp
ls.push_bacK(2);   //{2}
ls.emplace_back(4);  // {2,4}

ls.push_front(5);   // {5,2,4}
ls.emplace_front(5);
```
## 4. Deque

```cpp
deque<int> dq;

dq.push_back(1); //{1}
dq.emplace_back(2);  // {1,2}
dq.push_front(3);  // {3,4,1,2}

dq.pop_back();   // {3,4,1}
dq.pop_front();  //{4,1}
```

## 5. Stack

It is **LIFO** (`Last In fast Out`)
![[LIFO-Operations-in-stack.jpg | 600]]

```cpp
stack<int> st;

st.push(1); // {1}
st.push(2); // {2,1}
st.push(3); // {3,2,1}
st.push(3); // {3,3,2,1}
st.emplace(5); // {5,3,3,2,1}

cout << st.top();  // Prints 5 

st.pop(); // {3,3,2,1}

cout << st.size();
cout << st.empty(); 

stack<int>st1,st2;
s1.swap(st2);
```

## 6. Queue

It is `FIFO` Based

![[FIFO-diagram-for-data-processing-Each-process-gets-the-appropriate-order-that-would.png | 600]]

```cpp
    queue<int> q;
```
```cpp
    q.push(1); // {1}
    q.push(2); // {1, 2}
    q.emplace(4); // {1, 2, 4}
    q.back() += 5; // last element becomes 9
    cout << q.back() << endl; // prints 9
    cout << q.front() << endl; // prints 1
    q.pop(); // {2, 9}
    cout << q.front() << endl; // prints 2
```

## 7. Priority Queue
```cpp
    // ---------------- MAX HEAP (default) ----------------
    priority_queue<int> pq;
    pq.push(5);  // {5}
    pq.push(2);  // {5, 2}
    pq.push(8);  // {8, 5, 2}
    pq.emplace(10);  // {10, 8, 5, 2}

    cout << pq.top() << endl;  // prints 10 (largest element)
    pq.pop();  // {8, 5, 2}
    cout << pq.top() << endl;  // prints 8
```
```cpp
    // ---------------- MIN HEAP ----------------
    priority_queue<int, vector<int>, greater<int>> pqMin;
    pqMin.push(5);  // {5}
    pqMin.push(2);  // {2, 5}
    pqMin.push(8);  // {2, 5, 8}
    pqMin.emplace(10);  // {2, 5, 8, 10}

    cout << pqMin.top() << endl;  // prints 2 (smallest element)
```

## 8. Set

Everything is **Sorted Manner** and **unique**
```
```