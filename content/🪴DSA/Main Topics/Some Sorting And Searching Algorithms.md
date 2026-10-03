---
title: Some Sorting And Searching Algorithms
date: 2025-09-23
tags: 
---
	

# Binary Search

- Elements Should be in Monotonic Function ie Increasing Or Decreasing 


```c

using namespace std;

int BinarySearch(int arr[], int size, int key) {
    int start = 0;
    int end = size - 1;  
    int mid = 0;

    while (start <= end) {
        mid = (start + end) / 2;

        if (arr[mid] == key) {
            return mid;  
        }
        if (key > arr[mid]) {
            start = mid + 1;  
        }
        else {
            end = mid - 1;    
        }
    }
    return -1;   // not found
}

int main() {
    int arr[5] = {1, 6, 9, 10, 12};
    int ans = BinarySearch(arr, 5, 12);
    cout << "Index of key: " << ans << endl;
    return 0;
}

```

In `Mid`
Suppose we have `start = 2^31 - 1` and `end = 2^31 - 1` so int will be outof range of Mid
So we can put insead
`Mid = Start + ((end - start)/2)`
![[Pasted image 20250924230742.png|400]]

Suppose we have linear array of size 1000
Linear time complexity O(n) will be 1000
But in case of binary search it will be 10 ie Log(n)

## [[Questions On Binary Search]]

---
# ![[⭐ Selection Sort]]



---


# ![[⭐Bubble Sort]]



---
# Insertion Sort (Notes)

Insertion Sort builds the **sorted part of the array** one element at a time.

At each step:

- Pick the current element
- Compare it backwards with previous elements
- Shift elements if needed
- Insert the element at the correct position  
    Just like **inserting a card into a sorted hand**.

## ⭐ Correct Code (Clean Form)

`void inseration_sort(int arr[], int n){     for(int i = 1; i < n; i++){         int j = i;         while(j > 0 && arr[j-1] > arr[j]){             int temp = arr[j-1];             arr[j-1] = arr[j];             arr[j] = temp;             j--;         }     } }`

✔ Works exactly like your intended logic  
✔ No extra array required  
✔ Stable sorting algorithm

## ⭐ How the Algorithm Works

1. First element (index 0) is always considered sorted
    
2. For each element `i` from 1 to n-1:
    
    - Compare it with elements before it
        
    - Keep swapping backward until it reaches the correct position
        
3. After each pass, array from `0 → i` is sorted
    

# Time Complexity

|Case|Explanation|Time|
|---|---|---|
|**Best**|Already sorted array → only 1 comparison each time|**O(n)**|
|**Average**|Random order|**O(n²)**|
|**Worst**|Reverse sorted|**O(n²)**|

✔ Best case is faster than Bubble & Selection  
✔ Worst and average same as O(n²)

## ⭐ Space Complexity

- **O(1)** (in-place sorting)  
    No extra memory used, only temp variable.
    


## Stability

Insertion Sort is **stable**  
(Does not change the order of equal elements)


## ⭐ When to Use Insertion Sort

✔ Small size arrays  
✔ Nearly sorted arrays  
✔ Situations where stability is required

---
# Merge Sort 

Based on the principle of divide and coquer
```cpp
void Mergesort(int arr[], int st, int end){
    if(st < end){
        int mid = (st + end) / 2;

        Mergesort(arr, st, mid);      // left half
        Mergesort(arr, mid + 1, end); // right half

        merge(arr, st, mid, end);     // merge two halves
    }
}

void merge(int arr[], int st, int mid, int end){
    int n1 = mid - st + 1;      // size of left half
    int n2 = end - mid;         // size of right half

    int left[n1];
    int right[n2];

    // copy into left[]
    for(int i = 0; i < n1; i++){
        left[i] = arr[st + i];
    }

    // copy into right[]
    for(int i = 0; i < n2; i++){
        right[i] = arr[mid + 1 + i];
    }

    // merge two sorted arrays
    int i = 0;   // left index
    int j = 0;   // right index
    int k = st;  // main array index

    while(i < n1 && j < n2){
        if(left[i] <= right[j]){
            arr[k] = left[i];
            i++;
        }
        else{
            arr[k] = right[j];
            j++;
        }
        k++;
    }

    // copy remaining elements of left[]
    while(i < n1){
        arr[k] = left[i];
        i++;
        k++;
    }

    // copy remaining elements of right[]
    while(j < n2){
        arr[k] = right[j];
        j++;
        k++;
    }
}

```