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
