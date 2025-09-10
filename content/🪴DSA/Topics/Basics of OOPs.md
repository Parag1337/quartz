---
name: Basics of OOPs
---


- OOP (Object-Oriented Programming) is a programming paradigm where everything revolves around _objects_.
- An object is an **instance of a class**.
- A **class** acts as a _blueprint/template_ that defines the properties (data members) and behaviors (member functions) of an object.
    

### Example:

```cpp
#include <iostream>
using namespace std;

class Hero {
    // data members (properties)
    char name;  
    int health; 
};

int main() {
    Hero H1;  // object created from the class
    // cout << H1.health;  // ❌ error because health is private by default
    return 0;
}
```

---

## Key Points about Classes and Objects

- A **class is a template** that describes how objects of that type will look/behave.

- The **size of an object** = sum of the sizes of its data members.

    - Example: If a class has `int health` (4 bytes) and `char level` (1 byte), then an object will take (at least) 5 bytes (plus padding if applied by the compiler).

- An **empty class** still takes up **1 byte** in memory (for unique identification/tracking).

- Classes can also be **defined in separate files** and then included using:
    ```cpp
    #include "Hero.cpp"
    ```
- **Accessing data members:**
    - Use the `.` operator → `objectName.dataMember`
    - Example: `H1.health`

---
