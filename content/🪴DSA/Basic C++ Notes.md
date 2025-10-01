---
title: Basic C++ Notes
---

# ✅ Basic C++ Program

```cpp
#include <iostream>
using namespace std;

int main() {
	int n;
	cin >> n ;
    cout << "Hello World"<< n << endl;
}
```
#### ✅ `cin >> variable;`

- **Ignores** all **leading whitespace**, including:
    - Spaces (`' '`)
    - Tabs (`'\t'`)
    - Newlines (`'\n'`) — when you press Enter)


---

# 🧠 Data Types & Variables

```cpp
int a = 5;
```

- `int` is the **data type**
- `a` is the **variable**
- On a **32-bit system**, `int` is typically **4 bytes**
```cpp
char ch = 'a';   // 1 byte (8 bits)
bool flag = true; // 1 bit (internally 1 byte used)
float f = 1.2f;  // 4 bytes
double d = 1.23; // 8 bytes
```

#### 🔎 Use `sizeof()` to check size:

```cpp
cout << sizeof(a);  // Output: 4 (on most systems)
```

<img src="https://static.takeuforward.org/content/-UZ-CN-Hb" width="500">
****

---
#  [[📊 C++ Data Type Sizes and Ranges]]

| Data Type            | Size (Bytes)      | Range (Approximate)                                      |
| -------------------- | ----------------- | -------------------------------------------------------- |
| `char`               | 1                 | -128 to 127 (signed), 0 to 255 (unsigned)                |
| `signed char`        | 1                 | -128 to 127                                              |
| `unsigned char`      | 1                 | 0 to 255                                                 |
| `short int`          | 2                 | -32,768 to 32,767                                        |
| `unsigned short int` | 2                 | 0 to 65,535                                              |
| `int`                | 4                 | -2,147,483,648 to 2,147,483,647                          |
| `unsigned int`       | 4                 | 0 to 4,294,967,295                                       |
| `long int`           | 4 or 8            | System dependent                                         |
| `unsigned long int`  | 4 or 8            | System dependent                                         |
| `long long int`      | 8                 | -9,223,372,036,854,775,808 to +9,223,372,036,854,775,807 |
| `unsigned long long` | 8                 | 0 to 18,446,744,073,709,551,615                          |
| `float`              | 4                 | ~ ±3.4e±38                                               |
| `double`             | 8                 | ~   ±1.7e±308                                            |
| `bool`               | 1 (stores 0 or 1) | true/false                                               |
### [[ASCII-Conversion-Chart.pdf]]


### 💾 **Memory Storage Summary**

| Concept            | Example          | Stored As (Binary)                    | Notes                         |
| ------------------ | ---------------- | ------------------------------------- | ----------------------------- |
| Integer (positive) | `int a = 8`      | `00000000 00000000 00000000 00001000` | 32 bits on typical systems    |
| Integer (negative) | `int a = -5`     | `11111111 11111111 11111111 11111011` | Stored as 2’s complement      |
| Character          | `char ch = 'a'`  | `01100001`                            | ASCII of 'a' = 97             |
| Boolean            | `bool b = true`  | `00000001`                            | Stored as 1 (true), 0 (false) |
| Floating Point     | `float f = 3.14` | IEEE 754 format                       | Approx. ±3.4e38               |


---

# 🔄 Typecasting

```cpp
int a = 'a';
cout << a << endl; // Output: 97 (ASCII value of 'a')

char ch = 123456;
cout << ch << endl; 
// Warning: narrowing conversion, 123456 > 255
// Only last 8 bits used → Output may be a garbage/ASCII symbol
```

---
# [[🔧 C++ Operators]]


| Precedence | Operators                                                      | Description                                                                | Associativity                      |
| ---------- | -------------------------------------------------------------- | -------------------------------------------------------------------------- | ---------------------------------- |
| 1          | `::`                                                           | Scope resolution                                                           | Left to Right                      |
| 2          | `++`, `--`, `()`, `[]`, `.` , `->`                             | Postfix increment/decrement, function call, array subscript, member access | Left to Right                      |
| 3          | `++`, `--`, `+`, `-`, `!`, `~`, `*`, `&`, `sizeof`, `typeid`   | Prefix inc/dec, unary ops, \dereference, address-of, size/type             | Right to Left                      |
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

# 🪬 Conditional

```cpp
if (condition1) {
    // Code runs if condition1 is true
}
else if (condition2) {
    // Code runs if condition1 is false AND condition2 is true
}
else {
    // Code runs if none of the above conditions are true
}
```

---
#  [[🔁 Loops Overview]]

| Loop Type  | When to Use                              |
| ---------- | ---------------------------------------- |
| `for`      | When number of iterations is known       |
| `while`    | When condition needs to be checked first |
| `do-while` | When loop should run at least once       |


### [[Loops Basic Questions ]]


---

# [[🎗️ Bitwise Operators]]

| Operator | Name        | Symbol | Description                                  |
| -------- | ----------- | ------ | -------------------------------------------- |
| AND      | Bitwise AND | `&`    | 1 if both bits are 1                         |
| OR       | Bitwise OR  | `\|`   | 1 if Either                                  |
| XOR      | Bitwise XOR | `^`    | 1 if bits are different                      |
| NOT      | Bitwise NOT | `~`    | Inverts all bits (1 → 0, 0 → 1)              |
| LEFT     | Left Shift  | `<<`   | Shifts bits left (multiplies by 2 per shift) |
| RIGHT    | Right Shift | `>>`   | Shifts bits right (divides by 2 per shift)   |


---
# [[🪦 Scope Of Variable]]


| Type      | Lifetime            | Accessible In                  |
| --------- | ------------------- | ------------------------------ |
| Local     | Until block ends    | Inside block/function          |
| Global    | Entire program      | Anywhere after declared        |
| Parameter | Until function ends | Only in that function          |
| Static    | Entire program      | Where declared (retains value) |

---

#  [[🟰 Decimals and Binary – Concept & Conversion]]

###  **Decimal to Binary**

**Logic 1: Modulo Method**

- Divide by 2, store remainder
- Repeat until `n == 0`
- Reverse the remainders


```cpp
ans = (digit * place) + ans;
place *= 10;
```

**Logic 2: Bitwise Method**

- Use `n & 1` to get bit
- Right shift with `n >>= 1`

✅ _Faster and efficient for C++_

---

###  **Binary to Decimal**

**Logic: Power of 2 Method**

- Multiply each binary digit by 2i2^i (right to left)
- Add all result

```cpp
ans += digit * pow(2, power);
```

🧠 Use string input for large binary numbers

---
### [[🔄 Number Building Logic]]

| Expression                               | Builds What?                |
| ---------------------------------------- | --------------------------- |
| `answer = (answer * 10) + digit`         | Normal order (e.g., 123)    |
| `answer = (digit * pow(10, i)) + answer` | Reversed number (e.g., 321) |


> [!tip] Use bitwise method for performance, and strings to safely handle large binary input.

---

# 🪜 Switch Case

```c
switch (expression) {
    case value1:
        // code
        break;
    case value2:
        // code
        break;
    ...
    default:
        // code
}
```


---
# [[🎪 Functions]]


### 🔁 Types of Functions in C++

| Type                        | Syntax Example                | Description                           |
| --------------------------- | ----------------------------- | ------------------------------------- |
| ✅ Return + Parameters       | `int add(int a, int b)`       | Returns a value, takes input          |
| ✅ Return + No Parameters    | `int getValue()`              | Returns a value, takes no input       |
| ❌ No Return + Parameters    | `void printName(string name)` | Doesn’t return value, but takes input |
| ❌ No Return + No Parameters | `void greet()`                | No return, no input                   |

---

### 🧱 Function Syntax Format

```cpp
return_type function_name(parameter_list) {
    // function body
    return value;  // if return_type is not void
}
```

---

### 🧪 Example of All Types

```cpp
int add(int a, int b) { return a + b; }          // ✅ Return + Parameters
int getNumber() { return 42; }                   // ✅ Return + No Parameters
void sayHello(string name) { cout << "Hi " << name; }  // ❌ No Return + Parameters
void greet() { cout << "Hello!"; }               // ❌ No Return + No Parameters
```

---
# [[🧬Arrays]]