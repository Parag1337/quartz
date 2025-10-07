---
title: Polymorphism
date: 2025-09-30
tags: 
---

# Polymorphism in C++

> **Definition:**  
> _Polymorphism_ means **“a single entity existing in multiple forms.”**  
> In C++, it allows the same function or operator to behave differently based on context.

---

## Types of Polymorphism

1. Compile-Time Polymorphism (Static Binding / Early Binding)
    
2. Run-Time Polymorphism (Dynamic Binding / Late Binding)
    

---

## 🧩 1. Compile-Time Polymorphism

This type of polymorphism is resolved **during compilation**.

It can be achieved in two main ways:
- **Function Overloading**
- **Operator Overloading**

---

### A. Function Overloading

> Function Overloading means **multiple functions with the same name but different parameters** (either in number or data type).

---

#### **1️⃣ Function Overloading with Different Number of Arguments**

```cpp
#include <iostream>
#include <string>
using namespace std;

class A {
public:
    void SayHello(string name) {
        cout << "Hello " << name << endl;
    }

    void SayHello(string name, string surname) {
        cout << "Hello " << name << " " << surname << endl;
    }
};

int main() {
    A obj;
    obj.SayHello("Parag");
    obj.SayHello("Parag", "Panzade");
    return 0;
}
```

🟢 **Explanation:**

- Both functions are named `SayHello`, but the number of parameters differs.
- Compiler decides which version to call at compile time.

---

#### **2️⃣ Function Overloading with Different Data Types**

```cpp
#include <iostream>
#include <string>
using namespace std;

class A {
public:
    void SayHello(string name) {
        cout << "Hello " << name << endl;
    }

    void SayHello(int num) {
        cout << "Hello " << num << endl;
    }
};

int main() {
    A obj;
    obj.SayHello("Parag");
    obj.SayHello(5);
    return 0;
}
```

🟢 **Explanation:**

- Here, both functions have one parameter but of **different data types** (`string` and `int`).
    

---

### B. Operator Overloading

> Operator Overloading allows redefining how operators (`+`, `-`, `()`, etc.) work for **user-defined types (classes).**

---
![[Pasted image 20250930233702.png|600]]
#### Example: Overloading `+` and `()` Operators

```cpp
#include <iostream>
using namespace std;

class B {
public:
    int a;

    // Overload '+' operator
    void operator+(B &obj) {
        int value1 = this->a;
        int value2 = obj.a;
        cout << "Output: " << value2 - value1 << endl; // '+' behaves as subtraction here
    }

    // Overload '()' operator
    void operator()() {
        cout << "I am bracket with value: " << this->a << endl;
    }
};

int main() {
    B obj1, obj2;
    obj1.a = 4;
    obj2.a = 7;

    obj1 + obj2;   // Calls overloaded '+'
    obj1();        // Calls overloaded '()'

    return 0;
}
```

🟢 **Explanation:**

- `operator+` makes `+` perform subtraction instead of addition.
- `operator()` allows the object to be used like a function call.

### Example code
```cpp
#include <iostream>
using namespace std;

class Complex {
private:
    int real;
    int imag;

public:
    // Default Constructor
    Complex() : real(0), imag(0) {}

    // Parameterized Constructor
    Complex(int r, int i) : real(r), imag(i) {}

    // Overload '+' operator to add two Complex objects
    Complex operator + (const Complex &obj) {
        Complex result;
        result.real = this->real + obj.real;
        result.imag = this->imag + obj.imag;
        return result;
    }

    // Display function
    void display() {
        cout << real << " + " << imag << "i" << endl;
    }
};

int main() {
    Complex c1(3, 4);
    Complex c2(5, 6);

    Complex c3 = c1 + c2;   // Calls overloaded '+' operator

    cout << "Result: ";
    c3.display();

    return 0;
}

```
    
---

### 💡 Key Points (Compile-Time Polymorphism)

| Concept              | Achieved By                                                | Resolved At  | Example       |
| -------------------- | ---------------------------------------------------------- | ------------ | ------------- |
| Function Overloading | Multiple functions with same name but different parameters | Compile Time | `SayHello()`  |
| Operator Overloading | Redefining operators for class objects                     | Compile Time | `operator+()` |

---

## ⚙️ 2. Run-Time Polymorphism

> Run-time polymorphism occurs when a **base class pointer or reference** is used to call a **derived class function** dynamically at run time.

- Also Know as Dynamic Polymorphism
It is achieved using:

- **Inheritance**
- **Virtual Functions**

---

## A. Method Overriding


```cpp
class Animal {
public:
    virtual void sound() {
        cout << "Animal makes a sound\n";
    }
};

class Dog : public Animal {
public:
    void sound() override {  // Correct override
        cout << "Dog barks\n";
    }
};
```


