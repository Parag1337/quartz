---
title: Encapsulaton
date: 2025-09-23
tags: 
---

# **Encapsulation**

### Definition

Encapsulation is the **wrapping up of data members (variables) and member functions (methods)** into a single unit called a **class**.  
It ensures that the internal details of a class are **hidden** from the outside world, and access is controlled through **public methods** (getters & setters).

---

### Fully Encapsulated Class

- A **fully encapsulated class** is one where **all data members are marked as `private`**.
- This way, no one can directly access or modify the variables from outside the class.
- Access is only possible via **public getter/setter methods**.

---

### Why Encapsulation?

1. **Information Hiding** → Prevents direct access to sensitive data.
2. **Control** → We can control how data is modified (read-only / write-only).
3. **Flexibility** → Implementation can be changed without affecting external code.
4. **Security** → Protects data integrity.

---

### Example: Encapsulation in C++

```cpp
#include <iostream>
using namespace std;

class Student {
private: 
    string name;
    int age;
    int height;

public:
    // Getter for age
    int getAge() {
        return this->age;
    }

    // Setter for age
    void setAge(int a) {
        if (a > 0)   // ✅ validation possible
            this->age = a;
    }

    // Getter for name
    string getName() {
        return this->name;
    }

    // Setter for name
    void setName(string n) {
        this->name = n;
    }
};

int main() {
    Student first;

    // Set data using setters
    first.setName("Parag");
    first.setAge(19);

    // Access data using getters
    cout << "Name: " << first.getName() << endl;
    cout << "Age: " << first.getAge() << endl;

    return 0;
}
```

---

### Output

```
Name: Parag
Age: 19
```

---

✅ With encapsulation:

- We **cannot directly do** `first.age = 19;` (since `age` is private).
- We **must use** `first.setAge(19);` which gives us **control + security**.
