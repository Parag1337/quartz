---
title: Encapsulation & Access Control
---

# Access Modifiers

Access modifiers control the **visibility** of class members.

1. **Public**
    - Accessible inside and outside the class.
    - Anyone can modify or view these members.
2. **Private** (default for classes)
    - Accessible **only inside the class**.
    - Cannot be accessed/modified directly outside the class        
3. **Protected**
    - Accessible inside the class and by **derived classes** (used in inheritance).
    - Not directly accessible outside the class.        

```cpp
#include <iostream>
using namespace std;

class Hero {
public:      // accessible anywhere
    int health;
    char level;

private:     // accessible only inside the class
    int score;
};

int main() {
    Hero ramesh;
    ramesh.health = 70;     // ✅ allowed
    ramesh.level = 'A';     // ✅ allowed
    // ramesh.score = 5;    // ❌ error (private member)

    cout << "Health: " << ramesh.health << endl;
    cout << "Level: " << ramesh.level << endl;
    return 0;
}
```

---

# Getter and Setter in C++

## 🔹 Why Getter and Setter?

- In **OOP (Object-Oriented Programming)**, we keep data **private** to follow the principle of **encapsulation** (data hiding).
- Since private members **cannot be accessed directly** from outside the class, we use **functions** to **get** (read) and **set** (update) their values.
- These functions are known as **Getters** and **Setters**.

---

## 🔹 Getter

- Used to **access/read private data members**.
- Returns the value of a private variable.
- Usually a `const` function (does not modify object data).

**Example:**

```cpp
int getHealth() {
    return health;
}
```

---

## 🔹 Setter

- Used to **modify/update private data members**.
- Can include **validation or conditions** to prevent wrong values.

**Example:**

```cpp
void setHealth(int h) {
    if (h > 0) {
        health = h;
    } else {
        cout << "❌ Invalid health! Setting default (50)." << endl;
        health = 50;
    }
}
```

---

## 🔹 Example Program

```cpp
#include <iostream>
using namespace std;

class Hero {
private:
    int health;   // private
    char level;   // private

public:
    // Getter
    int getHealth() { return health; }
    char getLevel() { return level; }

    // Setter (with validation)
    void setHealth(int h) {
        if (h > 0) health = h;
        else {
            cout << "❌ Invalid health! Setting default (50)." << endl;
            health = 50;
        }
    }

    void setLevel(char ch) {
        if (ch >= 'A' && ch <= 'Z') level = ch;
        else {
            cout << "❌ Invalid level! Setting default ('C')." << endl;
            level = 'C';
        }
    }
    // Function to print details
    void print() {
        cout << "Health: " << health << ", Level: " << level << endl;
    }
};

int main() {
    Hero ramesh;

    // ✅ Using setters
    ramesh.setHealth(70);
    ramesh.setLevel('A');

    // ✅ Access via getters
    cout << "Health: " << ramesh.getHealth() << endl;
    cout << "Level: " << ramesh.getLevel() << endl;

    ramesh.print();

    // ❌ Invalid values
    ramesh.setHealth(-20);
    ramesh.setLevel('9');

    ramesh.print();

    return 0;
}
```

```
Health: 70
Level: A
Health: 70, Level: A

❌ Invalid health! Setting default (50).
❌ Invalid level! Setting default ('C').
Health: 50, Level: C
```

---

# BTS Of Object

So in earlier example if we calculate the size of ramesh

```
cout << "size of ramesh" << sizeof(ramesh) << endl;
```

it should be 5 but it is 8 due to
**padding**, and **Greedy alignment**

---
#