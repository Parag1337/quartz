---
name: Object Copying & Assignment
---


# 📝 Shallow Copy vs Deep Copy in C++

## 🔹 Shallow Copy

- By default, C++ provides its own **copy constructor**.
- This **default copy constructor** performs a **shallow copy**.
- **Shallow Copy** → Just copies values of data members _as they are_.
    - For **primitive types** (`int`, `char`, etc.) → works fine.
    - For **pointers** → only the address is copied, not the actual memory content.

👉 So, two objects end up pointing to the **same memory**.  
Changing one will also affect the other.

---

### Example: Shallow Copy

```cpp
#include <iostream>
#include <cstring>
using namespace std;

class Hero {
private:
    int health;
    char level;

public:
    char *name;

    // Constructor
    Hero() {
        cout << "Simple Constructor called" << endl;
        name = new char[100];   // dynamic allocation
    }

    // Setters
    void setHealth(int h) { health = h; }
    void setLevel(char ch) { level = ch; }
    void setName(const char *n) { strcpy(this->name, n); }

    // Print
    void print() {
        cout << "Name: " << name
             << " | Health: " << health
             << " | Level: " << level << endl;
    }
};

int main() {
    Hero hero1;
    hero1.setHealth(12);
    hero1.setLevel('D');
    hero1.setName("Babbar");

    hero1.print();

    // Default copy constructor (shallow copy)
    Hero hero2(hero1);
    hero2.print();

    cout << "\nAfter modifying hero1's name:\n";
    hero1.name[0] = 'G';   // modifying hero1's name

    hero1.print();   // "Gabbar"
    hero2.print();   // "Gabbar" (unexpected change!)
}
```

### Output (simplified):

```
Simple Constructor called
Name: Babbar | Health: 12 | Level: D
Name: Babbar | Health: 12 | Level: D

After modifying hero1's name:
Name: Gabbar | Health: 12 | Level: D
Name: Gabbar | Health: 12 | Level: D
```

👉 Problem: **Both objects share the same memory** for `name`.

---

## 🔹 Deep Copy

- In **Deep Copy**, we create a **new memory block** for the copied object.
- Copy **actual content** of the pointer, not just the address.
- Prevents accidental changes in one object from affecting the other.

---

### Example: Deep Copy

```cpp
#include <iostream>
#include <cstring>
using namespace std;

class Hero {
private:
    int health;
    char level;

public:
    char *name;

    // Constructor
    Hero() {
        cout << "Simple Constructor called" << endl;
        name = new char[100];
    }

    // Deep Copy Constructor
    Hero(const Hero& other) {
        cout << "Deep Copy Constructor called" << endl;
        
        // allocate new memory
        name = new char[strlen(other.name) + 1];
        strcpy(name, other.name);

        this->health = other.health;
        this->level = other.level;
    }

    // Setters
    void setHealth(int h) { health = h; }
    void setLevel(char ch) { level = ch; }
    void setName(const char *n) { strcpy(this->name, n); }

    // Print
    void print() {
        cout << "Name: " << name
             << " | Health: " << health
             << " | Level: " << level << endl;
    }
};

int main() {
    Hero hero1;
    hero1.setHealth(12);
    hero1.setLevel('D');
    hero1.setName("Babbar");

    hero1.print();

    // Deep copy constructor
    Hero hero2(hero1);
    hero2.print();

    cout << "\nAfter modifying hero1's name:\n";
    hero1.name[0] = 'G';   // modifying hero1's name

    hero1.print();   // "Gabbar"
    hero2.print();   // "Babbar" ✅ (unchanged!)
}
```

### Output (simplified):

```
Simple Constructor called
Name: Babbar | Health: 12 | Level: D
Deep Copy Constructor called
Name: Babbar | Health: 12 | Level: D

After modifying hero1's name:
Name: Gabbar | Health: 12 | Level: D
Name: Babbar | Health: 12 | Level: D
```

---

## 🔑 Key Points

- **Shallow Copy** → copies only addresses for pointers → both objects share the same memory.
    
- **Deep Copy** → allocates new memory and copies the content → objects are independent.
    
- Always implement a **custom copy constructor** when your class has **pointers or dynamic memory**.
    

---

