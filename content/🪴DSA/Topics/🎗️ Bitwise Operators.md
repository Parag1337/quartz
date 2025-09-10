---
name: 🎗️ Bitwise Operators
---

# 🔧 List of Bitwise Operators in C/C++

| Operator | Name        | Symbol | Description                                  |
| -------- | ----------- | ------ | -------------------------------------------- |
| AND      | Bitwise AND | `&`    | 1 if both bits are 1                         |
| OR       | Bitwise OR  | `\|`   | 1 if Either                                  |
| XOR      | Bitwise XOR | `^`    | 1 if bits are different                      |
| NOT      | Bitwise NOT | `~`    | Inverts all bits (1 → 0, 0 → 1)              |
| LEFT     | Left Shift  | `<<`   | Shifts bits left (multiplies by 2 per shift) |
| RIGHT    | Right Shift | `>>`   | Shifts bits right (divides by 2 per shift)   |

---

# 📘 Binary Example (Assume `a = 5`, `b = 3`)

```
a = 5  → 0101
b = 3  → 0011
```

| Expression | Result | Binary Explanation           |
| ---------- | ------ | ---------------------------- |
| `a & b`    | `1`    | 0101 & 0011 = 0001           |
| `a \| b`   | `7`    | 0101 \| 0011 = 0111          |
| `a ^ b`    | `6`    | 0101 ^ 0011 = 0110           |
| `~a`       | `-6`   | ~0101 = 1010 (2's comp = -6) |
| `a << 1`   | `10`   | 0101 → 1010                  |
| `a >> 1`   | `2`    | 0101 → 0010                  |

---
![[Truth Table For Bitwise]]

---


# 💡 Notes:

- **Left Shift `<<`** → multiplies by 2n
- **Right Shift `>>`** → divides by 2n (integer division)
- **`~x` (NOT)** flips all bits and gives the **2's complement negative value**

# 🔍 Use Cases:

1. **Set a bit:** `x | (1 << n)`
2. **Clear a bit:** `x & ~(1 << n)`
3. **Toggle a bit:** `x ^ (1 << n)`
4. **Check if a bit is set:** `(x & (1 << n)) != 0`
5. **Swapping values without temp:**
    ```cpp
    a = a ^ b;
    b = a ^ b;
    a = a ^ b;
    ```

## 🧠 Tip for Remembering:

- `&` = both
- `|` = either
- `^` = either but not both
- `~` = inverse
- `<<` = go left (multiply)
- `>>` = go right (divide)

---
