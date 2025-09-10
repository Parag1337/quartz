---
name: Combined Example (Static + Dynamic Together)
---

## [[Combined Example (Static + Dynamic Together)]]

```cpp
#include <iostream>
using namespace std;

class Hero {
private:
    int health;
    char level;

public:
    void setHealth(int h) { health = h; }
    void setLevel(char ch) { level = ch; }
    int getHealth() { return health; }
    char getLevel() { return level; }
};

int main() {
    // Static allocation
    Hero a;
    a.setHealth(90);
    a.setLevel('C');

    cout << "Static Object:" << endl;
    cout << "Health: " << a.getHealth() << endl;
    cout << "Level: " << a.getLevel() << endl;

    // Dynamic allocation
    Hero *b = new Hero;
    b->setHealth(75);
    b->setLevel('A');

    cout << "\nDynamic Object:" << endl;
    cout << "Health: " << b->getHealth() << endl;
    cout << "Level: " << b->getLevel() << endl;

    delete b;  // free memory
    return 0;
}
```

---

## 🔹 Output

```
Static Object:
Health: 90
Level: C

Dynamic Object:
Health: 75
Level: A
```

---
