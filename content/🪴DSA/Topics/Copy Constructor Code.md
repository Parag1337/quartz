---
title: Copy Constructor Code
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

    // Parameterized constructor
    Hero(int health, char level) {
        this->health = health;
        this->level = level;
    }

    // Copy constructor (pass by reference)
    Hero(const Hero &temp) {
        cout << "Copy Constructor called" << endl;
        this->health = temp.health;
        this->level = temp.level;
    }

    void setHealth(int h) { health = h; }
    void setLevel(char ch) { level = ch; }
    int getHealth() { return health; }
    char getLevel() { return level; }

    void print() {
        cout << "Health: " << health << ", Level: " << level << endl;
    }
};

int main() {
    Hero suresh(70, 'C');   // Parameterized constructor
    suresh.print();

    Hero ritesh(suresh);    // Copy constructor
    ritesh.print();

    return 0;
}
```

---


```
Health: 70, Level: C
Copy Constructor called
Health: 70, Level: C
```

---