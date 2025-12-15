---
title: Static Members
---
 
# Static Members & Static Functions in C++

---

## 🔹 Static Data Members

- Declared with the `static` keyword inside a class.
- Belong to the **class itself**, not to individual objects.
- Only **one copy** exists in memory, no matter how many objects you create.
- Must be **defined & initialized outside** the class using the **scope resolution operator `::`**.


👉 Syntax:

```cpp
datatype ClassName::fieldName = value;
```

### ✅ Example

```cpp
#include <iostream>
using namespace std;

class Hero {
public:
    static int timeToComplete;  // static data member
};

// Definition (outside the class)
int Hero::timeToComplete = 5;

int main() {
    // Access using class name (recommended)
    cout << Hero::timeToComplete << endl;

    Hero a;
    cout << a.timeToComplete << endl;  // Works, but not recommended

    return 0;
}
```

### 🖥️ Output

```
5
5
```

---

## Properties of Static Data Members

- Shared across **all objects** of the class.
- Memory allocated **once only** (in data segment, not inside objects).
- Can be accessed using:
    - **Class name** → `ClassName::member` ✅ (recommended).
    - **Object** → `obj.member` ⚠️ (works but not preferred).

---

## 🔹 Static Member Functions

- Declared with the `static` keyword inside a class.
- Belong to the **class**, not to any specific object.
- Can be called **without creating an object**.
- Do **not** have access to the `this` pointer.
- Can **only access static members** (variables or functions).

### ✅ Example

```cpp
#include <iostream>
using namespace std;

class Hero {
public:
    static int timeToComplete;

    // Static function
    static int random() {
        return timeToComplete;  // ✅ can access only static data
    }
};

// Definition
int Hero::timeToComplete = 10;

int main() {
    // Call without object
    cout << Hero::random() << endl;

    Hero obj;
    cout << obj.random() << endl;  // Works, but not recommended

    return 0;
}
```

### 🖥️ Output

```
10
10
```

---

## 🔑 Properties of Static Functions

- Do not require an object → can be called using `ClassName::function()`.
- No `this` pointer available inside static functions.
- Can access **only static members** of the class.

---

## ⚡ Quick Revision

- **Static Data Members** = One copy shared across all objects.
    
- **Static Functions** = Belong to class, no `this` pointer, can only use static data.
    
- Both can be accessed using **class name + scope resolution operator**.
    

---