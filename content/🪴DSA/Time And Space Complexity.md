---
title: Time And Space Complexity
---

# 🔢 Time and Space Complexity

Time and space complexity are **measures of efficiency** of an algorithm:

---

## ⏱ Time Complexity

- Describes **how fast an algorithm runs** relative to the input size `n`.
- It shows how the **number of operations grows** as the input size increases.
- We **don’t measure actual seconds** — instead, we measure **growth in operations**.

**Example:**  
If an algorithm takes time proportional to `n²`, we write:  
➡️ `Time Complexity = O(n²)` (Quadratic Time)

- If `n = 10` → about 100 steps
- If `n = 100` → about 10,000 steps

---

## 🧠 Space Complexity

- Describes **how much extra memory** an algorithm uses (excluding input).
- Includes
    - Temporary variables
    - Data structures (arrays, stacks, hash maps, etc.)
    - Function call stacks

**Example:**  
If an extra array of size `n` is used:  
➡️ `Space Complexity = O(n)`

---

# 📊 Big-O Notation

Big-O notation describes the **upper bound (worst-case growth)** of an algorithm.  
It tells us the **asymptotic behavior** (as `n → ∞`).

---

### ✅ Common Big-O Notations

(As we go down the table, algorithms get slower for large inputs.)

|Notation|Name|Example Meaning|
|---|---|---|
|O(1)|Constant|Same time regardless of input size|
|O(log n)|Logarithmic|Cuts problem each step (e.g., binary search)|
|O(n)|Linear|Directly grows with input size|
|O(n log n)|Linearithmic|Efficient sorting (merge sort, quicksort avg.)|
|O(n²)|Quadratic|Nested loops on input (e.g., bubble sort)|
|O(2ⁿ)|Exponential|Doubles with each input increment|
|O(n!)|Factorial|Extremely slow, permutations, brute force|

---

# 📘 Example with Code

```cpp
// Find sum of array
int sum(int arr[], int n) {
    int total = 0;
    for (int i = 0; i < n; i++) {
        total += arr[i];
    }
    return total;
}
```

- **Time Complexity:** O(n) → loop runs `n` times
    
- **Space Complexity:** O(1) → only one variable `total`
    

---

![[Pasted image 20250828222331.png|400]]  
![[Pasted image 20250828222439.png|400]]  
![[Pasted image 20250828222459.png|400]]  
![[Pasted image 20250828222552.png|400]]

Same rule is applied for space and time complexity both 

---

# 🔎 Understanding Big-O

### 1. What Big-O Really Means

- Big-O is **not about exact runtime in seconds**.
    
- It describes **growth rate of runtime** as input gets large.
    

Example:

- f(n) = 1000n
    
- g(n) = n/4
    

Both are **O(n)** (linear).

- For small inputs → f(n) may take longer.
    
- For large inputs → both grow at the same **linear rate**.
    

---

### 2. Why Ignore Constants & Lower Terms?

- Constants (1000, 1/4, +5) affect speed but **not growth trend**.
    
- Lower-order terms (`n² + log n`) → `n²` dominates as `n` grows.
    

Big-O keeps only the **dominant term**.

---

# 📌 Important Notes for Competitive Programming

### Time Limit Exceeded (TLE)

- Online judges give **constraints** like:
    - `1 ≤ n ≤ 10^6`
    - `1 ≤ n ≤ 1000`
- You must choose an algorithm that fits in the time limit (~10^8 ops/second).

👉 **Rule of Thumb:**

- `n ≤ 1000` → O(n²) is safe
    
- `n ≤ 10^5` → O(n log n) needed
    
- `n ≤ 10^6` or higher → O(n) or O(log n) required
    
![[Pasted image 20250828225552.png|400]]

---

### Big-O, Big-Ω, Big-Θ

- **O(n):** Upper bound (worst-case)
- **Ω(n):** Lower bound (best-case)
- **Θ(n):** Tight bound (when best = worst = average)

Example:

- Linear Search:
    - Best case: Ω(1) (found at start)
    - Worst case: O(n) (found at end or not at all)
    - Average: Θ(n)

---

✅ **In summary:**

- Time Complexity → how runtime grows
- Space Complexity → how memory grows
- Big-O → worst-case upper bound
- Constraints → tell you which complexity is required to avoid TLE

---

⚡Would you like me to also create that **cheat-sheet table (Constraints vs Allowed Complexities)** so you can instantly know which algorithm to pick in contests?