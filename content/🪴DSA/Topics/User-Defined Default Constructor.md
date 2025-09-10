---
title: User-Defined Default Constructor
---

```cpp
#include <iostream>
using namespace std;

class Hero {
private:
    int health;
    char level;

public:
    // ✅ Default Constructor
    Hero() {
        cout << "Constructor is called!" << endl;
        health = 100;   // assigning default values
        level = 'A';
    }

    void print() {
        cout << "Health: " << health << ", Level: " << level << endl;
    }
};

int main() {
    cout << "Creating static object:" << endl;
    Hero ramesh;   // static allocation → constructor called
    ramesh.print();

    cout << "\nCreating dynamic object:" << endl;
    Hero *h = new Hero;  // dynamic allocation → constructor called
    h->print();

    delete h;  // free memory
    return 0;
}
```


```
Creating static object:
Constructor is called!
Health: 100, Level: A

Creating dynamic object:
Constructor is called!
Health: 100, Level: A
```