---
title: Stack And Queue
date: 2025-10-07
tags: 
---
# Stack Functions (LIFO)

`push()`,`pop()`,`top()`,`size()
![[LIFO-Operations-in-stack 1.jpg|500]]`
![[Pasted image 20251009152840.png|400]]
## Stack Implementation using Arrays

```cpp
#include <iostream>
using namespace std;

class StackImplementation {
    int top;
    int st[10];

public:
    StackImplementation() {
        top = -1;
    }

    void push(int x) {
        if (top == 9) {
            cout << "Stack Overflow!" << endl;
        } else {
            top++;
            st[top] = x;
            cout << x << " pushed into stack." << endl;
        }
    }

    void pop() {
        if (top == -1) {
            cout << "Stack Underflow!" << endl;
        } else {
            cout << st[top] << " popped from stack." << endl;
            top--;
        }
    }

    int peek() {
        if (top == -1) {
            cout << "Stack is empty!" << endl;
            return -1;
        } else {
            return st[top];
        }
    }

    bool isEmpty() {
        return top == -1;
    }
    
    void showstack(){
	    for(int i = 0; i<top+1;i++){
		    cout << st[i] << " ";
	    }
    }
};

int main() {
    StackImplementation st;
    st.push(5);
    st.push(10);
    cout << "Top element: " << st.peek() << endl;
    cout << endl
    st.showstack():
    st.pop();
    st.pop();
    st.pop();  // Test underflow
}
```

## Stack Using Linked-List
```cpp

```

# Queue Function (FIFO) 

![[First-In-First-Out-Queue-1024x683.png|500]]

## Queue Using Arrays

```cpp
#include <iostream>
using namespace std;

class QueueImp {
public:
    int start, end, curr_size, size;
    int *q; // dynamic array for the queue

    QueueImp(int size) {
        this->size = size;
        q = new int[size];
        start = -1;
        end = -1;
        curr_size = 0;
    }

    void push(int x) {
        if (curr_size == size) {
            cout << "Queue Overflow!" << endl;
            return;
        }
        if (curr_size == 0) {
            start = 0;
            end = 0;
        } else {
            end = (end + 1) % size;
        }
        q[end] = x;
        curr_size++;
        cout << x << " pushed into queue." << endl;
    }

    void pop() {
        if (curr_size == 0) {
            cout << "Queue Underflow!" << endl;
            return;
        }
        cout << q[start] << " popped from queue." << endl;
        if (curr_size == 1) {
            start = -1;
            end = -1;
        } else {
            start = (start + 1) % size;
        }
        curr_size--;
    }

    int front() {
        if (curr_size == 0) {
            cout << "Queue is empty!" << endl;
            return -1;
        }
        return q[start];
    }

    int getSize() {
        return curr_size;
    }

    bool isEmpty() {
        return curr_size == 0;
    }

    ~QueueImp() {
        delete[] q;
    }
};

int main() {
    QueueImp q(5);
    q.push(10);
    q.push(20);
    q.push(30);
    cout << "Front element: " << q.front() << endl;
    q.pop();
    cout << "Front element after pop: " << q.front() << endl;
    cout << "Current size: " << q.getSize() << endl;
}
```

