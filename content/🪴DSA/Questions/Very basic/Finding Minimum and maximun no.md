---
title: Finding Minimum and maximun no
---

```cpp
int getMax(int num[],int n){
    int max = 0;
    for(int i = 0 ; i < n ; i++){
        if(num[i] > max){
            max = num[i];
        }
    }
    return max;
}
```

```cpp
int getMin(int num[],int n){
    int mix = 0;
    for(int i = 0 ; i < n ; i++){
        if(num[i] < mix){
            mix = num[i];
        }
    }
    return mix;
}
```