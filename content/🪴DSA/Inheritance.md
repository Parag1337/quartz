---
title: Inheritance
date: 2025-09-30
tags: 
---
```cpp
#include<iostream>
using namespace std;

class Human{
	public:
	int height;
	int weight;
	int age;
	
	public:
	int getage(){return this->age;}
	int setWeight(int w){this->weight = w;}
};

class Male : public Human {
	public:
	string color;
	
	void sleep(){cout << "Male is sleeping";}
};


int main(){
	Male object1;
	
	cout << object1.age << endl;  // Here we dont have delcarred this attributes in male class but we stil can use these things
	cout << object1.weight << endl;
	cout << object1.weight << endl;
	
	cout << object1.color << endl;
	object1.sleep();
	
	object1.setweight(50) << endl;
	cout << object1.weight;
	return 0;
}

```

- If we declare something in `Private` in base in class, And inherited that thing in class then it is not possible 
![[Pasted image 20250930190826.png]]