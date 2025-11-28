---
title: Hashing
date: 2025-11-28
tags: 
---


Hashing is a technique that **converts a value (key)** into a **small index** using a mathematical function called a **hash function**.

👉 In simple words:  
**Hashing = Fast searching using an index created from the value itself.**

### Example:

Instead of searching for a number in an array by checking every element (O(n)),  
you create a hash array where:

- index = value
- value at index = frequency or presence

👉 Search becomes **O(1)** (constant time).

---

# Number Hashing

#### **Input:**

- Size of array `n`
- `n` numbers
- Number of queries `q
- Each query asks: _“How many times does a number appear?”_

#### **Steps:**

1. Read `n`.
2. Declare an array `arr[n]`.
3. Input all `n` elements into `arr`.
4. Create a hash array `hash[13]` initialized with zeros.
5. For each element in `arr`, increase `hash[arr[i]]` by 1.
6. Read number of queries `q`.
7. For each query:
    - Input a number
    - Output `hash[number]` which stores its frequency.
![[Pasted image 20251128201630.png|300]]
```cpp
#include<iostream>
using namespace std;

int main(){
    int n;
    cout << "Enter the size of array: ";
    cin >> n;

    int arr[n];
    for(int i = 0; i < n; i++){
        cin >> arr[i];
    }

    int hash[13] = {0}; // Hash array

    for(int i = 0; i < n; i++){
        hash[arr[i]]++;  // Store frequency
    }

    cout << "Enter the number of queries: ";
    int q;
    cin >> q;

    while(q--){
        int number;
        cin >> number;
        cout << hash[number] << endl;
    }

    return 0;
}
```

---

## 🔍 [[Maximum Size of Array in C++]]

---
# Character Hashing

Character hashing means **counting the frequency of characters** using their **ASCII values**.

👉 Every character (`a`, `b`, `A`, `1`, `#`) has a unique ASCII number.  
👉 We use that ASCII number as the **index** in our hash array.

## 📌 Why use ASCII for hashing?

Because:

- Each character can be mapped to an integer easily
- Indexing becomes **O(1)**
- Searching becomes **O(1)**
- Easy frequency counting

Example:  
`'a'` → ASCII = 97  
`'b'` → ASCII = 98

---

# 📌 **Two Types of Character Hashing**

## 1️⃣ Lowercase-only hashing (a–z)

Useful when string contains only **a to z**.

We use:

`hash[26]`

We convert char → index using:

`st[i] - 'a'`

---

# 📌 Example 1 (Lowercase Character Hashing)

```cpp
#include<iostream>
using namespace std;

int main(){

    cout << "Enter the string: ";

    string st;
    cin >> st;

    int hash[26] = {0};

    for(int i = 0; i < st.size(); i++){
        hash[st[i] - 'a']++;  // counting frequency
    }

    int q;
    cin >> q;

    while(q--){
        char c;
        cin >> c;
        cout << hash[c - 'a'] << endl;
    }
}

```
### ✔ Works only for:

- `'a'` to `'z'`
    
- Lowercase characters
    

---

## **2️⃣ Hashing for ALL Characters (important)**

To handle all ASCII characters:

✔ lower  
✔ upper  
✔ digits  
✔ special characters  
✔ whitespace

We must use:

`int hash[256]`

Why 256?  
Because ASCII has **256 possible values**:

- 0–127 → Standard ASCII
- 128–255 → Extended ASCII

Then use:
`hash[ st[i] ]++`
No subtraction needed.


---
Here are your **same notes**, but **cleaned, corrected, structured, and improved**, without changing your code style.  
I only fixed spelling mistakes, corrected technical lines, and made it easier to revise.

---

# Using STL’s for Hashing 

When we do hashing using arrays like:

```cpp
int hash[10000000];
```

→ We can store frequency only up to **10⁷ size** safely in local/global arrays.

But sometimes:
- Input range is too large
- Numbers are not continuous (e.g., 1, 1000, 99, 5000000)
- Memory is not enough

In those cases, we use **STL-based hash maps**.

STL provides:

- `map`
- `unordered_map`
- `multimap` (not required here)

These help in hashing large or unknown ranges.

## ⭐ Example: Using map (ordered map)

```cpp
#include<iostream>
#include<map>
using namespace std;

int main(){
    int n;
    cout << "Enter the size of array: ";
    cin >> n;

    int arr[n];
    for(int i = 0; i < n; i++){
        cin >> arr[i];
        // mpp[arr[i]]++;  // can do like this too 
    }

    map<int,int> mpp;   // ordered map

    for(int i = 0; i < n; i++){
        mpp[arr[i]]++;  // frequency counting
    }

    cout << "Enter the number of queries: ";
    int q;
    cin >> q;

    while(q--){
        int number;
        cin >> number;
        cout << mpp[number] << endl;
    }

    return 0;
}
```

## ⭐ Iterating a map

```cpp
for(auto it : mpp){
    cout << it.first <<  " -> " << it.second << endl;
}
```

_(Corrected “secound” → “second”)_

Since `map` is ordered internally (Red-Black Tree), the output will always be sorted by keys.

## ⭐ Character Frequency Using map

```cpp
#include<iostream>
#include<map>
using namespace std;

int main(){

    cout << "Enter the string: ";
    string st;
    cin >> st;

    map<char,int> mpp;

    for(int i = 0; i < st.size(); i++){
        mpp[st[i]]++;   // char counting
    }

    int q;
    cin >> q;

    while(q--){
        char c;
        cin >> c;
        cout << mpp[c] << endl;
    }
}
```

## ⭐ Time Complexity

## ✔ `map`

- Internally uses **Red-Black Tree**
- Every operation (insert/find/delete) = **O(log n)**
- Always sorted
- Worst = best = average = **O(log n)**
## ⭐ Using unordered_map

`unordered_map` is a **real hash-table**.

- Average case lookup → **O(1)**
- Best case → **O(1)**
- Worst case → **O(n)** _(rare)_
- Does **NOT** maintain order

Syntax:

```cpp
unordered_map<int,int> mpp;
```

## ⭐ map vs unordered_map (Very Important)

|Feature|map|unordered_map|
|---|---|---|
|Implementation|Red-Black Tree|Hash Table|
|Order|Sorted keys|No order|
|Average Time|O(log n)|O(1)|
|Worst Time|O(log n)|O(n)|
|Memory Usage|Less|More|
|When to use|TLE cases, ordered needed|Best for hashing/frequency|

## ⭐ Final Recommendation

- **Use `unordered_map` most of the time**  
    → Fast lookups, ideal for hashing problems
    
- **Use `map` only when:**
    
    - You need sorted output
    - TLE occurs due to hashing collisions
    - Problems require ordering (like printing in sorted order)

- In Ordered Map anything like `Node`, `Pair` can be the key
- But in ordered Map only int, float,double can be the key


Learn in Future
- [ ] Divison Method
- [ ] Folding Method
- [ ] Mid Square Method
