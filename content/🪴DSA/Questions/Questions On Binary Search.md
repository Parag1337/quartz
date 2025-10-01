---
title: Questions On Binary Search
date: 2025-09-29
tags: 
---

# Question 1 : Occurance


First Occurrence of any number
```cpp
#include <iostream>
using namespace std;

int firstOcc(int arr[], int n, int key) {
    int start = 0;
    int end = n - 1;
    int ans = -1;   // -1 means not found

    while (start <= end) {
        int mid = start + (end - start) / 2;

        if (arr[mid] == key) {
            ans = mid;        // store answer
            end = mid - 1;    // move left to find earlier occurrence
        }
        else if (arr[mid] > key) {
            end = mid - 1;    // search left
        }
        else {
            start = mid + 1;  // search right
        }
    }

    return ans;
}

int main() {
    int even[5] = {1, 2, 3, 3, 5};
    cout << "First occurrence of 3 is at index "
         << firstOcc(even, 5, 3) << endl;
    return 0;
}

```

Last Occurance
```cpp
#include <iostream>
using namespace std;

int firstOcc(int arr[], int n, int key) {
    int start = 0;
    int end = n - 1;
    int ans = -1;   // -1 means not found

    while (start <= end) {
        int mid = start + (end - start) / 2;

        if (arr[mid] == key) {
            ans = mid;        // store answer
            start = mid + 1;    // move left to find earlier occurrence
        }
        else if (arr[mid] > key) {
            end = mid - 1;    // search left
        }
        else {
            start = mid + 1;  // search right
        }
    }

    return ans;
}

int main() {
    int even[5] = {1, 2, 3, 3, 5};
    cout << "Last occurrence of 3 is at index "
         << firstOcc(even, 5, 3) << endl;
    return 0;
}
```

# Question 2 : Mountain Array

![[Pasted image 20250929154750.png]]
```cpp
#include <iostream>
using namespace std;

int MountainPeak(int arr[], int size) {
    int start = 0;
    int end = size - 1;

    while (start < end) {   // use < to avoid out-of-bounds
        int mid = start + (end - start) / 2;

        if (arr[mid] < arr[mid + 1])
            start = mid + 1;  // increasing slope → go right
        else
            end = mid;        // decreasing slope → go left
    }
	
    return start;  // peak index
}

int main() {
```

# Question 3 : Pivot Element
![[Pasted image 20250929163047.png]]![[Pasted image 20250929163447.png]]