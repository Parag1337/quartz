---
title: 🟰 Decimals and Binary – Concept & Conversion
---

# 🔁 Decimal to Binary

---

## **Logic 1: Modulo Division Method**

### 🧠 Steps:

1. Divide the number by `2`
2. Store the **remainder** (`0` or `1`)
3. Update the number as `n = n / 2`
4. Repeat until `n == 0`
5. **Reverse** the collected remainders to get the binary number

### 🧾 Example:

| Division Step | Remainder |
| ------------- | --------- |
| 10 / 2 → 5    | 0         |
| 5 / 2 → 2     | 1         |
| 2 / 2 → 1     | 0         |
| 1 / 2 → 0     | 1         |

**Answer:** Reverse `0101` → `1010`

### C++ Code:

```cpp
#include<iostream>
using namespace std;

int main(){
    int n;
    cin >> n;
    int ans = 0, place = 1;

    while (n != 0) {
        int digit = n % 2;
        ans = (digit * place) + ans;
        n /= 2;
        place *= 10;
    }

    cout << "Binary: " << ans << endl;
}
```

---

## **Logic 2: Bitwise Operator Method**

### 🧠 Steps:

1. Extract last bit using `n & 1` (returns 1 if odd, else 0)
2. Append the bit using decimal placement
3. Right shift the number `n = n >> 1`
4. Repeat until `n == 0`

###  C++ Code:

```cpp
#include<iostream>
using namespace std;

int main(){
    int n;
    cin >> n;
    int ans = 0, place = 1;

    while (n != 0) {
        int bit = n & 1;         // Get last bit
        ans += bit * place;      // Place in correct decimal spot
        place *= 10;             // Increase decimal place
        n >>= 1;                 // Shift right (n / 2)
    }

    cout << "Binary: " << ans << endl;
    return 0;
}
```

---

## 📌 Summary

|Method|Operation Used|Performance|Suitable For|
|---|---|---|---|
|Division Method|`%` and `/`|Simple|Beginners|
|Bitwise Method|`&`, `>>`|Faster|Efficient C++ code|

> [!tip] Use Bitwise method when performance matters – it’s faster and more efficient.

# 🔁 Binary To Decimal 

## ✅ **Logic: Power of 2 Method**

### 🧠 Steps:

1. Start from the **rightmost bit**
2. Multiply each bit by 2i2^i
3. Add all results together

### Example:

Binary: `1011`  
→  
`1×2³ + 0×2² + 1×2¹ + 1×2⁰ = 8 + 0 + 2 + 1 = 11`

---

## C++ Code

```cpp
#include<iostream>
#include<cmath>
using namespace std;

int main() {
    int n;
    cout << "Enter a binary number: ";
    cin >> n;

    int ans = 0, power = 0;

    while (n > 0) {
        int digit = n % 10;              // Get last digit
        ans += digit * pow(2, power);    // Multiply by 2^power
        power++;
        n /= 10;                          // Remove last digit
    }

    cout << "Decimal: " << ans << endl;
    return 0;
}
```

---

## ✅ **Alternative: Input as String (Safe for Large Binaries)**

For very large binary numbers, taking input as `string` is safer:

```cpp
#include<iostream>
#include<cmath>
using namespace std;

int main() {
    string binary;
    cout << "Enter a binary string: ";
    cin >> binary;

    int ans = 0;
    int length = binary.length();

    for (int i = 0; i < length; i++) {
        if (binary[length - i - 1] == '1') {
            ans += pow(2, i);
        }
    }

    cout << "Decimal: " << ans << endl;
}
```

---

## 📝 Summary Table

| Binary  | Decimal Explanation              | Result |
| ------- | -------------------------------- | ------ |
| `101`   | 1×2² + 0×2¹ + 1×2⁰               | `5`    |
| `1111`  | 1×2³ + 1×2² + 1×2¹ + 1×2⁰        | `15`   |
| `10010` | 1×2⁴ + 0×2³ + 0×2² + 1×2¹ + 0×2⁰ | `18`   |

---

> [!tip] For user-entered binary numbers, prefer using `string` to avoid digit-loss or invalid input issues.



# [[🔄 Number Building Logic]]