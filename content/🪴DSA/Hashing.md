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

Here we use ascii value concept for character hashing 

### Example 1
```
```