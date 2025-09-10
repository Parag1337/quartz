---
title: 📊 C++ Data Type Sizes and Ranges
---

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

---

## 💾 How Data  Is Stored in Memory

### Example:

```cpp
int a = 8;
```

- `8` is stored in **binary**: `00000000 00000000 00000000 00001000` (32 bits)
- Leading bits are `0` for padding

### 🔁 For Negative Numbers:

```cpp
int n = -5;
```

Steps:

1. Ignore the sign: `5`
2. Convert to binary: `0000 0101`
3. Take **2's complement** to store: `1111 1011`
4. When retrieving: take **2's complement** again to get `5`, apply `-` sign.

---

### 🔤 For Characters:

```cpp
char ch = 'a';
```

- `'a'` → ASCII: `97`
- Stored in memory as `01100001`