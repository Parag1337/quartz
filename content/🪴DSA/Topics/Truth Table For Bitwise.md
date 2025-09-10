---
name: Truth Table For Bitwise
---



## 🔸 Bitwise AND (`&`)

|A|B|A & B|
|---|---|---|
|0|0|0|
|0|1|0|
|1|0|0|
|1|1|1|

🟢 Only returns `1` when **both bits are 1**.

---

## 🔸 Bitwise OR (`|`)

|A|B|A \| B|
|---|---|---|
|0|0|0|
|0|1|1|
|1|0|1|
|1|1|1|

🟢 Returns `1` if **at least one** bit is 1.

---

## 🔸 Bitwise XOR (`^`)

|A|B|A ^ B|
|---|---|---|
|0|0|0|
|0|1|1|
|1|0|1|
|1|1|0|

🟢 Returns `1` if **bits are different**.

---

## 🔸 Bitwise NOT (`~`) (Unary)

|A (8-bit)|~A (inverted bits)|Decimal Value|
|---|---|---|
|00000000|11111111|-1|
|00000001|11111110|-2|
|00000101 (5)|11111010|-6|

🟥 Inverts all bits. In C++, it returns the **2's complement** (which becomes negative).

---

## 🔸 Summary Table

|Operator|Meaning|Returns 1 When...|
|---|---|---|
|`&`|AND|Both bits are 1|
|`|`|OR|
|`^`|XOR|Bits are different|
|`~`|NOT (unary)|All bits inverted|
|`<<`|Left shift|Bits shifted left, fills with 0s|
|`>>`|Right shift|Bits shifted right, may fill with 0s or 1s depending on signedness|

---
