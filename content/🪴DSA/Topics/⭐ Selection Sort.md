---
title: ⭐ Selection Sort
date: 2026-09-03
tags:
---
# ⭐ Selection Sort

Selection Sort is a simple comparison-based sorting algorithm.

At every step, it **selects the minimum element** from the **unsorted part** of the array and places it at the correct position in the **sorted part**.

## ✅ Algorithm (Your code – cleaned & correct)

```cpp
void selectionSort(int arr[], int n){
    for(int i = 0; i < n-1; i++){
        int min = i;   // index of minimum element

        for(int j = i+1; j < n; j++){
            if(arr[j] < arr[min]){
                min = j;  // update minimum index
            }
        }

        // swap the found minimum with the first unsorted element
        int temp = arr[min];
        arr[min] = arr[i];
        arr[i] = temp;
    }
}
```

---

### ⭐ How Selection Sort Works (Simple Explanation)

1. Start from index **i = 0**
    
2. Find the smallest element from `i` to `n-1`
    
3. Swap it with element at index `i`
    
4. Now, the first `i+1` elements are sorted
    
5. Repeat for all positions
    

---

### ⭐ Time Complexity

|Case|Explanation|Time|
|---|---|---|
|**Best Case**|Still compares every pair|**O(n²)**|
|**Average Case**|Typical input|**O(n²)**|
|**Worst Case**|Reverse sorted|**O(n²)**|

✔ Selection Sort **always** runs two nested loops  
→ Therefore time is **O(n²)** in ALL cases.
The formula for this sum is:

The formula for this sum is:

$$
\frac{n(n+1)}{2}
$$

Expand it:

$$
\frac{n^2+n}{2}
$$

For Big-O, we ignore constants and lower-order terms:

$$
O\left(\frac{n^2+n}{2}\right)
$$

becomes:

$$
O(n^2)
$$
### ⭐ Space Complexity

- **O(1)** (in-place sorting)  
    Only swapping of elements; no extra arrays used.
    


###  Stability

Selection Sort is **NOT stable**, because swapping can change the relative order of equal elements.


### ⭐ When to Use Selection Sort?

✔ When memory is very limited (because it’s in-place)  
✔ When number of swaps must be minimized (Selection Sort makes at most **n-1 swaps**)  
✘ Not suitable for large data due to O(n²)

