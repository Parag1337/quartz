---
title: Memory Allocation
---

# Static vs Dynamic Allocation in C++

## Static Allocation

- Memory is allocated **at compile-time** (on the **stack**).
- Object is destroyed automatically when it goes **out of scope**.
- Simple and efficient, but **lifetime is limited** to the scope.

**Example:**

```cpp
int main() {
    // ✅ Static allocation
    Hero a;  
    a.setHealth(80);
    a.setLevel('B');

    cout << "Static Object:" << endl;
    cout << "Health: " << a.getHealth() << endl;
    cout << "Level: " << a.getLevel() << endl;

    return 0;
}
```

---

## 🔹 Dynamic Allocation

- Memory is allocated **at run-time** (on the **heap**) using `new`.
- Lifetime is controlled manually → must use `delete` to free memory.
- Useful when we don’t know the size/number of objects at compile-time.

**Example:**

```cpp
int main() {
    // ✅ Dynamic allocation
    Hero *b = new Hero;   // creates object on heap

    (*b).setHealth(70);     // using arrow operator
    b->setLevel('A');

    cout << "\nDynamic Object:" << endl;
    cout << "Health: " << (*b).getHealth() << endl;
    cout << "Level: " << b->getLevel() << endl;

    delete b;  // free memory
    return 0;
}
```

---

## 🔹 Important Notes

1. **Static Allocation**
```cpp
    Hero a;   // object created on stack
    ```
    - Automatically destroyed when scope ends.
2. **Dynamic Allocation**
    ```cpp
    Hero *b = new Hero;  // object created on heap
    delete b;            // must be deleted manually
    ```
    - Access using:
        - `(*b).setHealth(70);`
        - `b->setHealth(70);` ✅ (preferred)

---

## ![[Combined Example (Static + Dynamic Together)]]

---