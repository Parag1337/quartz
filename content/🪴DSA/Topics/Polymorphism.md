---
title: Polymorphism
date: 2025-09-30
tags: 
---
A Single thing exisiting in Multiple forms is called as Polymorphism

There are two types of Polymorphism
1. Compile Time Polymorphism
2. Run Time Polymorphism


## Compile Time Polymorphism 
### 1. Function Overloading with different number of arguments

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

### Function Overloading with different number of arguments
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

### 3. Operator Overloading
![[Pasted image 20250930233702.png|600]]
```cpp
#include<iostream>
using namespace std;


```

