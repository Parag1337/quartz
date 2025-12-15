---
title: Exception Handling
date: 2025-12-05
tags: 
---
Instead of terminating the program abruptly when an error occurs, C++ allows you to ****throw**** exceptions and ****catch**** them for graceful handling.

- **Throwing an Exception:** When an error or unexpected situation occurs, the program uses the `throw` keyword to signal an exception.
- **Catching an Exception:** The program searches for a matching `catch` block to intercept and handle the thrown exception.
- **Handling the Exception:** The `catch` block contains the logic to respond to the error, allowing the program to recover or terminate gracefully.

# try-catch Block

```cpp
try {         
    // Code that might throw an exception
} 
catch (ExceptionType e) {   
    // exception handling code
}
```

```cpp
int main{
	string word = "four";
	try{
		cout << word.at(4);
	}
	catch(...){
		cout << "Exception occured"
	}
}
```


```cpp
int main(){
	string word = "four";
	try{
		cout << word.at(4);
	}
	catch(out_of_range& e){
		cout << "Exception occured : " << e.what()
	}
}
```

```cpp
int main(){
	
	try{
		int * arr = new int[999999999];
	}
	catch(bad_alloc& e){
		cout << "Exception occured : " << e.what()
	}
}
```

```cpp
int main(){
	
	try{
		int * arr = new int[999999999];
	}
	catch(exception& e){
		cout << "Exception occured : " << e.what()
	}
}

```

![[Pasted image 20251208193711.png]]

```cpp
int main(){
	try{
		throw exception();
	}
	catch(bad_alloc& e){
		cout << "Exception occured : " << e.what()
	}
	catch(exception& e){
		cout << "Exception occured : " << e.what()
	}
	
}
```


## We can also make our own  `exception` 
```cpp
#include<iostream>
using namespace std;

class custom_exception : public exception{
	virtual const char* what() const noexcept{
		return "Custom Exception";
	}
};

int main(){
	try{
		throw custom_exception();
	}
	catch(exception& e){
		cout << "Exception occured : " << e.what();
	}
}

```


```cpp
int main(){
	try{
		throw 20;
	}
	catch(int code){
		cout << "Exception occured : " << code;
	}
}
```

```cpp
void myfunction1(){
	throw 20;
}

int main(){
	try{
		myfunction1();
	}
	catch(exception& e){
		cout << "Exception occured : " << e.what();
	}
}
```