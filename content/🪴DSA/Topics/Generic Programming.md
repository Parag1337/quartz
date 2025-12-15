---
title: Generic Programming
date: 2025-12-05
tags: 
---
```cpp
#include<iostream>

using namespace std;

  

template<typename T>

T add(T a, T b){

    return a+b;

}

int main(){

    cout << add<int>(4,5);

}
```


```cpp
#include<iostream>

using namespace std;

  

template<typename T>

class Box{

    public:

    T value;

    Box(T v){

        value = v;

    }

    void show(){

        cout << value;

    }

};

  

int main(){

    Box<int>dabba(50);

  

    dabba.show();

  

}
```