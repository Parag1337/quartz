---
title: Loops Basic Questions
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
# Question 
 
```
1 2 3 4 5 6 
1 2 3 4 5 
1 2 3 4 
1 2 3 
1 2 
1 
```
```cpp
#include <iostream>
using namespace std;

int main() {
    int n;
    cout << "Enter n: ";
    cin >> n;

    for (int i = 1; i <= n; i++) {
        for (int j = 0; j < n - i + 1; j++) {
            cout << j + 1 << " ";
        }
        cout << endl;
    }

    return 0;
}
```

---
# Question 
```
          *  
        * * *   
      * * * * *    
    * * * * * * *     
  * * * * * * * * *      
```
```cpp
#include <iostream>
using namespace std;

int main() {
    int n;
    cout << "Enter n: ";
    cin >> n;

    for (int i = 1; i <= n; i++) {

        // Print leading spaces
        for (int j = 0; j < n - i; j++) {
            cout << "  ";
        }

        // Print stars
        for (int j = 0; j < 2 * i - 1; j++) {
            cout << "* ";
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
# Question

```
  * * * * * * *  
    * * * * *   
      * * *    
        *     
         
```
```cpp
#include <iostream>
using namespace std;

int main() {
    int n;
    cout << "Enter n: ";
    cin >> n;

    for (int i = 1; i <= n; i++) {

        // Leading spaces
        for (int j = 0; j < i - 1; j++) {
            cout << "  ";
        }

        // Stars
        for (int j = 0; j < 2 * (n - i) + 1; j++) {
            cout << "* ";
        }
	
        cout << endl;
    }

    return 0;
}
```


---
# Question
```
 *
 *  *
 *  *  *
 *  *  *  *
 *  *  *  *  *
 *  *  *  *
 *  *  *
 *  *
 * 
```
```cpp
#include <iostream>
using namespace std;

int main() {
    int n;
    cout << "Enter n : ";
    cin >> n;

    for (int i = 1; i <= 2 * n - 1; i++) {

        int stars = i;
        if (i > n)
            stars = 2 * n - i;

        for (int j = 0; j < stars; j++) {
            cout << "* ";
        }

        cout << endl;
    }
}
```

---

# Question

```
1        1
12      21
123    321
1234  4321
1234554321
```
```cpp
#include <iostream>
using namespace std;

int main()
{
    int n;

    cout << "Enter n: ";
    cin >> n;

    for (int i = 1; i <= n; i++)
    {
        // Print increasing numbers
        for (int j = 0; j < i; j++)
        {
            cout << j + 1;
        }

        // Print spaces
        for (int j = 0; j < 2 * (n - i); j++)
        {
            cout << " ";
        }

        // Print decreasing numbers
        for (int j = 0; j < i; j++)
        {
            cout << i - j;
        }

        cout << endl;
    }

    return 0;
}
```
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

```cpp
#include <iostream>
using namespace std;

int main()
{
    int n;

    cout << "Enter n: ";
    cin >> n;

    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            // Print '*' on the boundary
            if (i == 0 || i == n - 1 || j == 0 || j == n - 1)
            {
                cout << "*";
            }
            else
            {
                cout << " ";
            }
        }

        cout << endl;
    }

    return 0;
}
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

![[Pasted image 20260808000610.png]]

https://youtu.be/tNm_NNSB3_w?si=6PY8y4DuYmDTEdQl