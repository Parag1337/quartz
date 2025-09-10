---
title : Number Building Logic
---

### ✅ 1. `answer = (10^n * digit) + answer`

#### → This builds the number in **reverse** order.

Let's break it with `digits = [1, 2, 3]` and `n = 0 initially` (we increment `n` as we go):

| Step | Digit | `answer = (10^n * digit) + answer` | Result |
| ---- | ----- | ---------------------------------- | ------ |
| 1    | 1     | `1 * 10^0 + 0` = `1`               | 1      |
| 2    | 2     | `2 * 10^1 + 1` = `20 + 1`          | 21     |
| 3    | 3     | `3 * 10^2 + 21` = `300 + 21`       | 321    |

👉 So the final answer is `321` – the **reverse** of 123.

---

### ✅ 2. `answer = (answer * 10) + digit`

#### → This builds the number in **normal** order (like from left to right)

|Step|Digit|`answer = answer * 10 + digit`|Result|
|---|---|---|---|
|1|1|`0 * 10 + 1` = `1`|1|
|2|2|`1 * 10 + 2` = `12`|12|
|3|3|`12 * 10 + 3` = `123`|123|

👉 So the final answer is `123` – same as the original sequence.

---

### 🧠 Summary

| Logic                              | Used For            | Result (from 1,2,3) |
| ---------------------------------- | ------------------- | ------------------- |
| `answer = (10^n * digit) + answer` | Reversing digits    | `321`               |
| `answer = (answer * 10) + digit`   | Building the number | `123`               |

Let me know if you want a **code example** for each!