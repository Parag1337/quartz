---
title: Inheritance
date: 2025-09-30
tags:
---

# **Inheritance & Access Specifiers in C++**

### What is Inheritance?

Inheritance allows one class (**derived/child**) to **reuse properties & methods** of another class (**base/parent**).  
This supports **code reusability** and helps implement **OOP hierarchy**.

---

### Example Code

```cpp
#include <iostream>
using namespace std;

// Base Class
class Human {
public:
    int height;
    int weight;
    int age;

    int getAge() { return this->age; }
    void setWeight(int w) { this->weight = w; }
};

// Derived Class (inherits publicly)
class Male : public Human {
public:
    string color;

    void sleep() { cout << "Male is sleeping" << endl; }
};

int main() {
    Male object1;

    // Accessing inherited properties (from Human class)
    object1.age = 20;
    object1.setWeight(65);

    // Accessing derived class property
    object1.color = "Brown";

    // Printing values
    cout << "Age: " << object1.age << endl;
    cout << "Weight: " << object1.weight << endl;
    cout << "Color: " << object1.color << endl;

    object1.sleep();  // Derived class function

    return 0;
}
```

---

### Access Control in Inheritance

1. **Public Inheritance**
    - Public members of base → **Public** in derived.
    - Protected members of base → **Protected** in derived        
    - Private members of base → ❌ Not accessible.
2. **Protected Inheritance**
    - Public & Protected members of base → **Protected** in derived.
    - Private members of base → ❌ Not accessible.        
3. **Private Inheritance**
    - Public & Protected members of base → **Private** in derived.
    - Private members of base → ❌ Not accessible.

---

### Access Table

| Base Class Member | Public Inheritance | Protected Inheritance | Private Inheritance |
| ----------------- | ------------------ | --------------------- | ------------------- |
| **Public**        | Public             | Protected             | Private             |
| **Protected**     | Protected          | Protected             | Private             |
| **Private**       | ❌ Not Accessible   | ❌ Not Accessible      | ❌ Not Accessible    |

---

### 📌 Key Points

- **Private members** of base class are **never directly accessible** in derived classes.
- They can only be accessed through **public/protected methods (getters/setters)** of the base class.
- `this` pointer ensures modifications are applied to the object calling the method.

---
Here’s an improved version of your notes with more clarity, better structure, and additional explanations. I’ve kept your images in place (as you mentioned).

---

# Types of Inheritance in C++

Inheritance in C++ allows one class (child/derived class) to acquire the properties and behaviors of another class (parent/base class).  
It helps in **code reusability, scalability, and building hierarchical relationships** between classes.

### **Types of Inheritance:**

1. Single Inheritance
2. Multi-level Inheritance
3. Multiple Inheritance
4. Hierarchical Inheritance
5. Hybrid Inheritance
    
---

## 1. Single Inheritance

➡ In **single inheritance**, a child class inherits from only one parent class.

![[Pasted image 20250930221158.png|400]]

```cpp
#include<iostream>
using namespace std;
class Animal {
	public:
	int age;
	int weight;
	
	public:
	void speak() {
		cout << "speaking" << endl;
	}
};

class Dog : public Animal {   // Dog inherits from Animal
};

int main() {
	Dog d;
	d.age = 10;
	cout << d.age;
}
```

✅ _Here, `Dog` inherits properties (`age`, `weight`) and methods (`speak()`) from `Animal`._

---

## 2. Multi-Level Inheritance

➡ In **multi-level inheritance**, a class is derived from another derived class, forming a chain of inheritance.

![[Pasted image 20250930221635.png|400]]

```cpp
#include<iostream>
using namespace std;
class Animal {
	public:
	int age;
	int weight;
	
	public:
	void speak() {
		cout << "speaking" << endl;
	}
};

class Dog : public Animal {   // Dog inherits from Animal
};

class GermanShepherd : public Dog {   // GermanShepherd inherits from Dog
};

int main() {
	GermanShepherd Bruno;
	Bruno.age = 10;
	cout << Bruno.age;
}
```

✅ _Inheritance chain: `GermanShepherd → Dog → Animal`._

---

## 3. Multiple Inheritance

➡ In **multiple inheritance**, a class can inherit from more than one base class.

![[Pasted image 20250930222118.png|400]]

```cpp
#include<iostream>
using namespace std;

class Animal {
	public:
	void bark() {
		cout << "barking" << endl;
	}
};

class Human {
	public:
	void speak() {
		cout << "speaking" << endl;
	}
};

// Multiple Inheritance
class Hybrid : public Animal, public Human { 
};

int main() {
	Hybrid H;
	H.speak();  // from Human
	H.bark();   // from Animal
}
```

✅ _`Hybrid` class inherits from both `Animal` and `Human`._

⚠️ **Note:** Multiple inheritance can lead to **ambiguity** when both base classes have a function with the same name.

---

## 4. Hierarchical Inheritance

➡ In **hierarchical inheritance**, one base class is inherited by multiple derived classes.

![[Pasted image 20250930223111.png|400]]

```cpp
#include <iostream>
using namespace std;

// Hierarchical Inheritance
class A {
public:
    void func1() {
        cout << "Inside Function 1" << endl;
    }
};

class B : public A {
public:
    void func2() {
        cout << "Inside Function 2" << endl;
    }
};

class C : public A {
public:
    void func3() {
        cout << "Inside Function 3" << endl;
    }
};

int main() {
    A object1;
    object1.func1();

    B object2;
    object2.func1(); // inherited from A
    object2.func2(); // from B

    C object3;
    object3.func1(); // inherited from A
    object3.func3(); // from C

    return 0;
}
```

✅ _Class `A` acts as a parent for both `B` and `C`._

---

## 5. Hybrid Inheritance

➡ In **hybrid inheritance**, more than one type of inheritance is combined.  
For example: combining **hierarchical + multiple inheritance**.

![[Pasted image 20250930223640.png|400]]

✅ _This is commonly used in real-world systems but can also create ambiguity if not handled properly._

---

## Inheritance Ambiguity

- Ambiguity arises when a derived class inherits from multiple classes that have functions with the **same name**.
    
- C++ resolves this issue using the **scope resolution operator (::)**.
    

**Example:**

```cpp
#include<iostream>
using namespace std;

class A {
public:
	void func() { cout << "Function of A" << endl; }
};

class B {
public:
	void func() { cout << "Function of B" << endl; }
};

class C : public A, public B {
};

int main() {
	C obj;
	// obj.func();   // ❌ Error: Ambiguity
	obj.A::func();   // ✅ Calls function from A
	obj.B::func();   // ✅ Calls function from B
}
```

---

