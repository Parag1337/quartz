---
name: 🎪 Functions
---



## 🔧 What is a Function?

A **function** is a block of code that performs a specific task.

---
 
## ✅ Why Use Functions?

- 🚀 Avoid code repetition
- 📦 Organize code into reusable parts
- 💡 Improve readability

---

## 🧱 Function Syntax

```cpp
return_type function_name(parameters) {
    // code
    return value;  // if return_type is not void
}
```

---

## 🧪 Example 

```cpp
#include<iostream>
using namespace std;

// Function definition
int add(int a, int b) {
    return a + b;
}

int main() {
    int result = add(5, 3);  // Function call
    cout << "Sum is: " << result << endl;
    return 0;
}
```

---
## 🔁 Parameter vs Argument

| Term          | Meaning                                      | Example                            |
| ------------- | -------------------------------------------- | ---------------------------------- |
| **Parameter** | Variable in function **definition**          | `int add(int a, int b)` → `a`, `b` |
| **Argument**  | Actual value passed during **function call** | `add(5, 3)` → `5`, `3`             |
> 📌 Think:  
>**Definition = Parameter**  
>**Calling = Argumen**t

---
## 🔁 Types of Functions

| Type                   | Example                        |
| ---------------------- | ------------------------------ |
| With return & params   | `int add(int a, int b)`        |
| With return, no params | `int getNumber()`              |
| No return, with params | `void printHello(string name)` |
| No return, no params   | `void greet()`                 |

---

## 🎯 `void` Function Example

```cpp
void greet() {
    cout << "Hello!" << endl;
}

int main() {
    greet();  // Just runs the function, no return
}
```

---

## 📌 Notes

- Function must be **declared before use**, or you must write a **function prototype**.
- `main()` is the starting point of your program.
- Parameters are optional —  you can pass values or not.
 
---













