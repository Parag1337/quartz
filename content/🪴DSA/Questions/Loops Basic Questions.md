---
name: Loops Basic Questions
---


# Question 1 : Rectangle 
```
11111
22222
33333
44444
```
```c
#include <iostream>
using namespace std;

int main() {
    int length, breadth;

    cout << "Enter the length and breadth: ";
    cin >> length >> breadth;

    for (int i = 0; i < length; i++) {
        for (int j = 0; j < breadth; j++) {
            cout << i;
        }
        cout << endl;
    }

    return 0;
}

```

---
# Question 2 : Normal Triangle
```

1 
1 2
1 2 3
1 2 3 4

```
```c
#include <iostream>
using namespace std;

int main() {
    int size;
    cout << "Enter the size: ";
    cin >> size;

    for (int i = 1; i <= size; i++) {
        for (int j = 1; j <= i; j++) {
            cout << j << " ";
        }
        cout << endl;
    }

    return 0;
}

```

---
# Question 3 : Triangle with Rev number
```
1 
2 1
3 2 1
4 3 2 1
5 4 3 2 1
```
```c
#include <iostream>
using namespace std;

int main() {

    int size;
    cout << "Enter the size: ";
    cin >> size;

    for (int i = 1; i <= size; i++) {
        for (int j = 1; j <= i; j++) {
            cout << i - j + 1 << " ";
        }
        cout << endl;
    }

    return 0;
}

```

---
# Question 4 : Triangle with Rev Alphabets

```
A
B A
C B A
D C B A
```
```c
#include <iostream>
using namespace std;

int main() {
	    int size;
    cout << "Enter the size: ";
    cin >> size;

    for (int i = 1; i <= size; i++) {
        char ch = 'A' + i - 1;
        for (int j = 1; j <= i; j++) {
            cout << (char)(ch - j + 1) << " ";
	        }
        cout << endl;
    }

    return 0;
}
```

---
# Question 5 : Rectangle Mix of Dash And Star

```
- - - *
- - * *
- * * *
* * * *
```
```c
#include<iostream>
using namespace std;

int main() {
    int l, b;
    cout << "Enter the length and breadth: ";
    cin >> l >> b;

    int dashCount = b - 1;

    for (int i = 1; i <= l; i++) {
        for (int j = 0; j < dashCount; j++) {
            cout << "- ";
        }
        for (int j = 0; j < b - dashCount; j++) {
            cout << "* ";
        }
        dashCount--;
        cout << endl;
    }

    return 0;
}
```

# Question 6: Diamond 
```
        * 
      * * * 
    * * * * * 
  * * * * * * * 
* * * * * * * * * 
* * * * * * * * * 
  * * * * * * * 
    * * * * * 
      * * * 
        * 

```
```c
#include<iostream>
using namespace std;

int main() {
    int n;
    cout << "Enter the value of n: ";
    cin >> n;

    // Top Half
    for (int i = 1 ; i <= n; i++) {
        for (int j = 1 ; j <= (n - i) ; j++) {
            cout << "  ";  // 2 spaces
        }
        for (int j = 1 ; j <= (2 * i - 1); j++) {
            cout << "* ";
        }
        cout << endl;
    }

    // Bottom Half
    for (int i = n ; i >= 1; i--) {
        for (int j = 1 ; j <= (n - i) ; j++) {
            cout << "  ";  // 2 spaces
        }
        for (int j = 1 ; j <= (2 * i - 1); j++) {
            cout << "* ";
        }
        cout << endl;
    }

    return 0;
}

```

# Question 7 : Hollow Rectangle 
```
*************
*           *
*           *
*           *
*************

```
```c

// This one is slightly unbalanced
#include<iostream>
using namespace std;

int main() {
    int l, b;
    cout << "Enter the length and breadth: ";
    cin >> l >> b;

    for (int i = 1; i <= l; i++) {
        if (i == 1 || i == l) {
            // Top or bottom row: full stars
            for (int j = 1; j <= b; j++) {
                cout << "*";
            }
        } else {
            // Middle rows: star, spaces, star
            cout << "*";
            for (int j = 1; j <= b - 2; j++) {
                cout << " ";
            }
            cout << "*";
        }
        cout << endl;
    }

    return 0;
}
```

```c
//Chatgpt answer
#include<iostream>
using namespace std;

int main(){
    int n;
    cout << "Enter the input: ";
    cin >> n;

    // Top Half
    for (int i = 1 ; i <= n; i++){
        for (int j = 1 ; j <= i; j++){
            cout << "*";
        }
        for (int j = 1 ; j <= 2 * (n - i); j++){
            cout << " ";
        }
        for (int j = 1 ; j <= i; j++){
            cout << "*";
        }
        cout << endl;
    }

    // Bottom Half (without repeating middle row)
    for (int i = n - 1 ; i >= 1; i--){
        for (int j = 1 ; j <= i; j++){
            cout << "*";
        }
        for (int j = 1 ; j <= 2 * (n - i); j++){
            cout << " ";
        }
        for (int j = 1 ; j <= i; j++){
            cout << "*";
        }
        cout << endl;
    }

    return 0;
}
```

---
# Question 8 : Fibonacci 
```
0, 1, 1, 2, 3, 5, 8, 13, ...
```
```c
#include<iostream>
using namespace std;

int main() {
    int a = 0;
    int b = 1;
    int n;
    int temp = 0;

    cout << "Enter the times: ";
    cin >> n;

    while (n > 0) {
        cout << a << " ";
        temp = a + b;
        a = b;
        b = temp;
        n--;
    }

    return 0;
}

```