---
title: Object Lifecycle Construction and Destruction
---

# Default Constructor in C++

## What is a Constructor?

- A **constructor** is a **special member function** of a class.
- It is **automatically invoked** whenever an object is created.
- It has **no return type** (not even `void`).
- Its name is always the **same as the class name**.
- Used to **initialize data members** of the object.

---

## Default Constructor

- If we do not define any constructor, **C++ automatically provides a default constructor**.
- A **default constructor** takes **no arguments**.
- We can also **create our own default constructor** to perform custom initialization.
---
##  ![[User-Defined Default Constructor]]

---

# Parameterized Constructor and `this` Keyword

## 🔹 Parameterized Constructor

- A **constructor that takes arguments** to initialize an object with specific values.
- Unlike the default constructor, it allows us to pass data at the time of object creation.
- If we declare owr own constructor with argument the default constructor with no argument will lose its functionality 

**Syntax:**

```cpp
ClassName(type arg1, type arg2, ...) {
    // initialization
}
```

---

## 🔹 `this` Keyword

- `this` is a special **pointer** available inside all non-static member functions of a class.    
- It stores the **address of the current object**.
- Used when **local variable names are same as data members**.

Example:

```cpp
this->health = health;
```

Here,

- Left side → `this->health` = class member
- Right side → `health` = constructor parameter

---
## ![[Constructor and this keyword]]
## Key Points

- Parameterized constructors allow **initialization during object creation**.
- `this` helps **resolve naming conflicts** and refers to the **current object’s address**.
- When you print `this` and `&object`, they both show the **same address**.

---

# Copy Constructor in C++

## What is it?

- A **copy constructor** creates a new object as a **copy of an existing object**.
- Compiler provides a **default copy constructor** if you don’t write your own.
Example:

```cpp
Hero ritesh(suresh);   // Copy constructor is called here
```

This means:

```cpp
ritesh.health = suresh.health;
ritesh.level  = suresh.level;
```

---

## Correct Way to Define Copy Constructor

Signature:

```cpp
Hero(const Hero &temp) {
    // Copy properties
}
```

👉 Must be **pass by reference** (`const Hero &`)  
❌ If you pass by value (`Hero temp`), it will again call the copy constructor → **infinite recursion**.  
❌ If you use a pointer (`Hero* temp`), that’s not the standard copy constructor; it will only copy if you explicitly pass a pointer.

---
## [[Copy Constructor Code]]

---
## Key Points

- **Default copy constructor** → does **shallow copy** (field by field).
- **User-defined copy constructor** → can implement **deep copy** (important when class contains pointers, dynamic memory).
- Always define as
```cpp
Hero(const Hero &temp) { ... }
 ```

---

# Destructor in C++

### 📌 Definition

- A **destructor** is a special member function of a class that is **automatically invoked** when an object goes out of scope or is deleted.
    
- Its main purpose is to **release resources** (memory, files, connections, etc.) acquired by the object.
    

---

### 🔑 Key Points

- Compiler provides a **default destructor** if you don’t define one.
- You can also **define your own destructor** for custom cleanup.
- Destructor **name = class name** with a `~` (tilde) prefix.
- It has:
    - **No return type** (not even `void`).
    - **No parameters** → cannot be overloaded.        
- Called:
    - **Automatically** for statically allocated objects (stack).
    - **Manually** for dynamically allocated objects (heap) → using `delete`        

---

### ✅ Example

```cpp
#include <iostream>
using namespace std;

class Hero {
private:
    int health;
    char level;

public:
    // Constructor
    Hero() {
        cout << "Constructor called" << endl;
    }

    // Destructor
    ~Hero() {
        cout << "Destructor called" << endl;
    }
};

int main() {
    // Static allocation (stack memory)
    Hero a;  // Constructor called
             // Destructor called automatically when 'a' goes out of scope

    // Dynamic allocation (heap memory)
    Hero *b = new Hero();  // Constructor called
    delete b;              // Destructor called only when delete is used

    return 0;
}
```

---

### 🖥️ Output

```
Constructor called
Constructor called
Destructor called      // for 'a' (static object, auto called at end of scope)
Destructor called      // for 'b' (dynamic object, after delete)
```

---

### ⚡ Important Notes

- If you don’t call `delete` for dynamically allocated objects → **memory leak** (destructor not called).
- Destructor is useful for:
    - Releasing **heap memory** (`delete` / `delete[]`).
    - Closing **files**        
    - Releasing **network/database connections**.

---