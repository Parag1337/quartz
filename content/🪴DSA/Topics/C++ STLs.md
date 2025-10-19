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


| **Member / Method**                                     | **Description**                                      | **Example**                                                  |
| ------------------------------------------------------- | ---------------------------------------------------- | ------------------------------------------------------------ |
| `first`                                                 | Stores the first value of the pair                   | `pair<int, string> p = {1, "apple"}; cout << p.first; // 1`  |
| `second`                                                | Stores the second value of the pair                  | `cout << p.second; // apple`                                 |
| `make_pair(a, b)`                                       | Creates a pair object with values `(a, b)`           | `auto p = make_pair(10, 20.5);`                              |
| `tie(x, y)`                                             | Unpacks values from a pair into variables            | `int x, y; pair<int,int> p={1,2}; tie(x,y)=p; // x=1, y=2`   |
| `swap(p2)`                                              | Swaps contents with another pair                     | `pair<int,int> p1={1,2}, p2={3,4}; p1.swap(p2);`             |
| Relational operators (`==`, `!=`, `<`, `>`, `<=`, `>=`) | Compare pairs lexicographically (first, then second) | `pair<int,int> p1={1,2}, p2={1,3}; cout << (p1<p2); // true` |


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
### **Insertion**

```cpp
v.push_back(1);          // {1}
v.emplace_back(2);       // {1, 2} (faster, constructs in place)

// With pairs
vector<pair<int, int>> vec;
vec.push_back({1, 2});
vec.emplace_back(1, 2);  // cleaner than push_back
```
### **Accessing Elements**

```cpp
cout << v[0] << " " << v.at(0);  // Direct access
cout << v.back();                // Last element
```
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

### 📌 **Table: Common Operations on `vector<pair<int,int>>`**

|**Operation**|**Description**|**Example**|
|---|---|---|
|`push_back({a, b})`|Adds a pair at the end|`vector<pair<int,int>> vp; vp.push_back({1,2});`|
|`emplace_back(a, b)`|Adds a pair (faster than `push_back`)|`vp.emplace_back(3,4);`|
|`vp[i].first`|Access first element of i-th pair|`cout << vp[0].first; // 1`|
|`vp[i].second`|Access second element of i-th pair|`cout << vp[0].second; // 2`|
|`for (auto p : vp)`|Range loop over pairs|`for (auto p : vp) cout << p.first << " " << p.second;`|
|Iterator with `->first` / `->second`|Access pair values using iterators|`for (auto it = vp.begin(); it != vp.end(); it++) cout << it->first;`|
|`insert(vp.begin(), {a, b})`|Insert pair at a position|`vp.insert(vp.begin(), {10,20});`|
|`erase(vp.begin() + i)`|Remove i-th pair|`vp.erase(vp.begin()+1);`|
|`erase(vp.begin(), vp.begin()+k)`|Remove first k pairs|`vp.erase(vp.begin(), vp.begin()+2);`|
|`swap(vp1, vp2)`|Swap two vectors of pairs|`vp1.swap(vp2);`|
|`clear()`|Remove all pairs|`vp.clear();`|
|`size()`|Number of pairs stored|`cout << vp.size();`|
|`empty()`|Check if vector is empty|`if(vp.empty()) cout<<"Empty";`|
|Sorting (by first/second)|Uses `sort` with custom comparator|`sort(vp.begin(), vp.end());` (default: sorts by `.first`, then `.second`)|

---

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
![[LIFO-Operations-in-stack 1.jpg| 600]]

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

```cpp
set<int> st;
```

```cpp
st.insert(1);    // {1}
st.emplace(2);   // {1, 2}
st.insert(2);    // {1, 2} (duplicate ignored)
st.insert(4);    // {1, 2, 4}
st.insert(3);    // {1, 2, 3, 4}
st.insert(5);    // {1, 2, 3, 4, 5}
```

```cpp
auto it = st.find(3);  // Iterator which will point to 3

auto it = st.find(3);  // {1, 2, 3, 4, 5} It doesnt exists do point to the after end

st.erase(5);  // 5 Will be deleted in logn time

cout << st.count(1)   // it exists 1 or else 0

st.erase(1,3)  // deleted everythin between

auto it = st.lower_bound(2);
auto it = st.upper_bound(3);
```
### Key Functions Recap

- `insert(x)` → adds element `x` if not present
- `emplace(x)` → same as insert but constructs in place (faster sometimes)
- `find(x)` → returns iterator to `x` if exists, else `end()`
- `erase(x)` → deletes `x`
- `erase(it1, it2)` → deletes elements in `[it1, it2)`
- `count(x)` → returns 0 or 1 (since unique)
- `lower_bound(x)` → first element `>= x`
- `upper_bound(x)` → first element `> x`


## 9. Multiset

A **multiset** in C++ is an **ordered associative container** similar to `set`, but the key difference is:

- It stores **elements in sorted order** (like `set`).
- It **allows duplicate values** (unlike `set`).
- Internally implemented as a **balanced binary search tree (typically Red-Black Tree)**.
- Operations (`insert`, `erase`, `find`, `count`, etc.) take **O(log n)** time.

```cpp
multipset<int> ms;
```

```cpp
ms.insert(1);  //{1}
ms.insert(1);  //{1,1}
ms.insert(1);  //{1,1,1}

ms.erase(1); // all 1's are erased

int cnt = ms.count(1);
// Only a single one erased
ms.erase(ms.find(1));

ms.erase(ms.find(1), ms.find(1) + 2)
```

## 10. Unordered Set

A **`unordered_set`** is an **associative container** that stores **unique elements** (like `set`) but with **no particular order**. It is implemented using **hash tables**.

- **Unique elements only** – duplicates are **not allowed**.
- **Unordered** – elements are **not sorted**; order depends on the hash function.
- **Average O(1) time** for insert, erase, and find (worst-case O(n) in rare cases).
- Useful when you **don’t need sorted data** but want **fast lookup**.

All the operations of set works but only and only `Upper and Lower Bound` doesn't not work
`O(n)`

## 11. Map


A **`map`** is an **associative container** that stores **key-value pairs**
- Each **key is unique**.
- The **keys are stored in sorted order** by default (ascending).
- Provides **fast search, insertion, and deletion** in **O(log n)** time using a **balanced binary search tree (usually Red-Black tree)**

### Key Features

1. **Unique keys** – no duplicate keys allowed.
2. **Sorted by key** – iteration is in **ascending order of keys** by default.
3. **Key-value pairs** – access value using the key.
4. **Operations**: `insert()`, `emplace()`, `find()`, `erase()`, `count()`, `size()`, `empty()`, `swap()`.

```cpp
map <int,int> mpp;
map int,pair<int,int>,int> mpp2;

mpp[1] = 2;  // On key 1 store 2    {1,2}
mpp.emplace({3,1});  // On key 3 store  {3,1}
mpp.insert({2,4});   // {2,4}

map2[{2,3}] = 10;  // Key is {2,3} and value stored is 10

for(auto it : mpp){
	cout << it.first << " " << it.secound << endl;
}

cout << mpp[1]  // output 2

auto it = mpp.find(3) 
cout << *(it).secound;


auto it = mpp.find(5)  // if doesnt exsits point after last element

auto it = mpp.lower_bound(2);
auto it = mpp.upper_bound(3);
```

## 12. Multimaps

Everything s same as map, only it can store multiple Keys
Only `mpp[key]` cannot be used here.


## 13. Unordered Maps

Same difference as unordered set difference
`O(n`)

Got it! Let me organize and **explain these C++ algorithms clearly** with corrected code and explanations.

---

## 1. Sorting Arrays

### **Basic Sorting**

```cpp
#include <algorithm>
#include <iostream>
using namespace std;

int main() {
    int a[] = {1, 5, 3, 2};
    int n = 4;

    // Sort in ascending order
    sort(a, a + n); // {1, 2, 3, 5}

    // Sort in descending order
    sort(a, a + n, greater<int>()); // {5, 3, 2, 1}

    // Print sorted array
    for(int i=0;i<n;i++) cout << a[i] << " ";
    cout << endl;
}
```

### **Custom Sorting with Pairs**

- Sort **by second element ascending**, if equal then **first element descending**:
    

```cpp
#include <algorithm>
#include <iostream>
using namespace std;

bool comp(pair<int,int> p1, pair<int,int> p2) {
    if(p1.second < p2.second) return true;
    if(p1.second > p2.second) return false;
    // If second elements are equal, sort by first descending
    return p1.first > p2.first;
}

int main() {
    pair<int,int> a[] = {{1,2}, {2,1}, {4,1}};
    int n = 3;

    sort(a, a + n, comp);

    for(int i=0; i<n; i++) {
        cout << "(" << a[i].first << "," << a[i].second << ") ";
    }
    cout << endl; // Output: (4,1) (2,1) (1,2)
}
```

---

## 2. Counting Set Bits

- `__builtin_popcount(x)` → counts **number of 1s** in **binary representation** of an integer.
    

```cpp
#include <iostream>
using namespace std;

int main() {
    int num = 7; // binary 111
    int cnt = __builtin_popcount(num);
    cout << "Set bits in 7: " << cnt << endl; // 3

    long long num2 = 454564656456;
    int cnt2 = __builtin_popcountll(num2); // use popcountll for long long
    cout << "Set bits: " << cnt2 << endl;
}
```

---

## 3. Next Permutation

- Generate **all lexicographical permutations** of a string or array:
    

```cpp
#include <iostream>
#include <algorithm>
using namespace std;

int main() {
    string s = "123";

    do {
        cout << s << endl;
    } while(next_permutation(s.begin(), s.end()));
}
```

- Output:

```
123
132
213
231
312
321
```

---

## 4. Maximum Element in Array

```cpp
#include <algorithm>
#include <iostream>
using namespace std;

int main() {
    int a[] = {5, 2, 9, 1};
    int n = 4;

    int maxo = *max_element(a, a + n); // returns largest element
    cout << "Maximum: " << maxo << endl; // 9
}
```

---

✅ Summary of Useful STL Functions

| Function                       | Use                              |
| ------------------------------ | -------------------------------- |
| `sort(a, a+n)`                 | Sort ascending                   |
| `sort(a, a+n, greater<int>())` | Sort descending                  |
| `__builtin_popcount(x)`        | Count set bits in `int`          |
| `__builtin_popcountll(x)`      | Count set bits in `long long`    |
| `next_permutation(begin, end)` | Next lexicographical permutation |
| `max_element(begin, end)`      | Find max element                 |
| `min_element(begin, end)`      | Find min element                 |

---
