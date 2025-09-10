---
title: 🪦 Scope Of Variable
---

### 🔹 **1. Local Scope**

- Declared **inside a function or block**
- Accessible **only within** that block

```cpp
void func() {
    int x = 5; // local to func()
}
```

---

### 🔹 **2. Global Scope**

- Declared **outside all functions**
- Accessible **everywhere in the file**

```cpp
int x = 10;

int main() {
    cout << x; // works
}
```

---

### 🔹 **3. Function Parameter Scope**

- Parameters act as **local variables**

```cpp
void sum(int a, int b) {
    // a and b are local here
}
```

---

### 🔹 **4. Block Scope**

- Declared in `{}` (like `if`, `for`)
- Exists **only inside that block**

```cpp
if (true) {
    int y = 3;
}
// y is not accessible here
```

---

### 🔹 **5. Static Scope**

- Declared with `static` inside a function
- Retains value between calls

```cpp
void test() {
    static int x = 0;
    x++;
}
```

---

✅ **Summary Table:**

|Type|Lifetime|Accessible In|
|---|---|---|
|Local|Until block ends|Inside block/function|
|Global|Entire program|Anywhere after declared|
|Parameter|Until function ends|Only in that function|
|Static|Entire program|Where declared (retains value)|