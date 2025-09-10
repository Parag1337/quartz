---
title: 🔧 C++ Operators
---

### ✅ Types of Operators in C++

| Category                | Operators                                                       |
| ----------------------- | --------------------------------------------------------------- |
| **Arithmetic**          | `+`, `-`, `*`, `/`, `%`                                         |
| **Relational**          | `==`, `!=`, `>`, `<`, `>=`, `<=`                                |
| **Logical**             | `&&`,                                                           |
| **Assignment**          | `=`, `+=`, `-=`, `*=`, `/=`, `%=`, etc.                         |
| **Increment/Decrement** | `++`, `--`                                                      |
| **Bitwise**             | `&`, `                                                          |
| **Ternary/Conditional** | `? :`                                                           |
| **Comma**               | `,`                                                             |
| **Pointer/Reference**   | `*`, `&`                                                        |
| **Scope/Member Access** | `::`, `.`, `->`                                                 |
| **Type Casting**        | `static_cast`, `dynamic_cast`, `reinterpret_cast`, `const_cast` |
|                         |                                                                 |

---

### ⚙️ Operator Precedence (Who Executes First?)

**Higher precedence = evaluated first**  
For example:

```cpp
int a = 2 + 3 * 4;  // = 2 + (3 * 4) = 14
```

---

| Precedence | Operators                                                      | Description                                                                | Associativity                      |
| ---------- | -------------------------------------------------------------- | -------------------------------------------------------------------------- | ---------------------------------- |
| 1          | `::`                                                           | Scope resolution                                                           | Left to Right                      |
| 2          | `++`, `--`, `()`, `[]`, `.` , `->`                             | Postfix increment/decrement, function call, array subscript, member access | Left to Right                      |
| 3          | `++`, `--`, `+`, `-`, `!`, `~`, `*`, `&`, `sizeof`, `typeid`   | Prefix inc/dec, unary ops, dereference, address-of, size/type              | Right to Left                      |
| 4          | `*`, `/`, `%`                                                  | Multiplication, division, modulo                                           | Left to Right                      |
| 5          | `+`, `-`                                                       | Addition, subtraction                                                      | Left to Right                      |
| 6          | `<<`, `>>`                                                     | Bitwise shift left and right                                               | Left to Right                      |
| 7          | `<`, `<=`, `>`, `>=`                                           | Relational operators                                                       | Left to Right                      |
| 8          | `==`, `!=`                                                     | Equality operators                                                         | Left to Right                      |
| 9          | `&`                                                            | Bitwise AND                                                                | Left to Right                      |
| 10         | `^`                                                            | Bitwise XOR                                                                | Left to Right                      |
| 11         | `\|`                                                           | Bitwise OR                                                                 | Bitwise OR                         |
| 12         | `&&`                                                           | Logical AND                                                                | Left to Right                      |
| 13         | `\|\|`                                                         | Logical OR                                                                 | `                                  |
| 14         | `?:`                                                           | Ternary conditional                                                        | Right to Left                      |
| 15         | `=`, `+=`, `-=`, `*=`, `/=`, `%=`, `<<=`, `>>=`, `&=`, `^=`, ` | =`                                                                         | Assignment and compound assignment |
| 16         | `,`                                                            | Comma (sequence)                                                           | Left to Right                      |

---

### 🔄 Associativity (Left ↔ Right)

It defines the direction of evaluation when **operators have the same precedence**.

Example:
```cpp
int a = 10, b = 5, c = 2;
int result = a - b - c; // (a - b) - c = 10 - 5 - 2 = 3 (Left to Right)
```

But:

```cpp
int x = 10;
x *= 2 + 3; // = x = x * (2 + 3) = 10 * 5 = 50 (Right to Left)
```

---

### 🧠 Value Evaluation Tips

- Parentheses `()` always come first and help override precedence.
- Always **group complex expressions** to avoid mistakes
- Beware of side effects with `++`, `--`, and assignment operators.