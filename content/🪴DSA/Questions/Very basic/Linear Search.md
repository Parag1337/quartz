---
title: Linear Search
---

```cpp
#include <iostream>
using namespace std;

bool linearsearch(int n[], int size, int key) {
    for (int i = 0; i < size; i++) {
        if (key == n[i]) {
            return true;   // Key found
        }
    }
    return false;          // Key not found
}

```