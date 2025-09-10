---
name: Constructor and this keyword
---


```cpp
#include <iostream>
using namespace std;

class Hero {
private:
    int health;
    char level;

public:
    // Default constructor
    Hero() {
        cout << "Default Constructor called" << endl;
    }

    // Parameterized constructor (1 parameter)
    Hero(int health) {
        cout << "Parameterized Constructor (1 param) is called" << endl;
        cout << "this pointer: " << this << endl;
        this->health = health;  // disambiguation using 'this'
    }

    // Parameterized constructor (2 parameters)
    Hero(int health, char level) {
        cout << "Parameterized Constructor (2 params) is called" << endl;
        this->health = health;
        this->level = level;
    }

    // Utility functions
    void print() {
        cout << "Health: " << health << ", Level: " << level << endl;
    }
};

int main() {
    // Static object with 1 parameter
    Hero ramesh(10);
    cout << "Address of ramesh: " << &ramesh << endl;
    ramesh.print();

    // Static object with 2 parameters
    Hero suresh(50, 'A');
    suresh.print();

    // Dynamic object with 1 parameter
    Hero *h = new Hero(20);
    h->print();

    delete h; // free heap memory
    return 0;
}
```

---

## 🔹 Sample Output

```
Parameterized Constructor (1 param) is called
this pointer: 0x7ffeef23d
Address of ramesh: 0x7ffeef23d
Health: 10, Level: 

Parameterized Constructor (2 params) is called
Health: 50, Level: A

Parameterized Constructor (1 param) is called
this pointer: 0x55a1fbb3e
Health: 20, Level: 
```

---
