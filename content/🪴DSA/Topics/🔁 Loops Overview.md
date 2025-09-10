---
name: 🔁 Loops Overview
---


# 🔁 C++ Loops – Syntax & Examples

---

## ✅ 1. `for` Loop

### 🔹 **Syntax**:
```cpp
for (initialization; condition; update) {
    // body
}
```

### 🔹 **Example**:
```cpp
for (int i = 1; i <= 5; i++) {
    cout << i << " ";
}
// Output: 1 2 3 4 5
```

---

## ✅ 2. `while` Loop

### 🔹 **Syntax**:
```cpp
initialization;
while (condition) {
    // body
    update;
}
```

### 🔹 **Example**:
```cpp
int i = 1;
while (i <= 5) {
    cout << i << " ";
    i++;
}
// Output: 1 2 3 4 5
```

---

## ✅ 3. `do-while` Loop

### 🔹 **Syntax**:
```cpp
initialization;
do {
    // body
    update;
} while (condition);
```

📌 _Runs at least once even if the condition is false initially._

### 🔹 **Example**:
```cpp
int i = 1;
do {
    cout << i << " ";
    i++;
} while (i <= 5);
// Output: 1 2 3 4 5
```

---

## ✅ 4. Range-based `for` Loop (C++11+)

### 🔹 **Syntax**:
```cpp
for (datatype var : collection) {
    // body
}
```

### 🔹 **Example**:
```cpp
#include <vector>
using namespace std;

vector<int> arr = {1, 2, 3};
for (int x : arr) {
    cout << x << " ";
}
// Output: 1 2 3
```

---

