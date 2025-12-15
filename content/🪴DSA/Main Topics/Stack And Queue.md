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
#include <iostream>
using namespace std;

// Node structure
class Node {
public:
    int data;
    Node* next;  

    Node(int val) {  
        data = val;
        next = NULL;
    }
};
```
```cpp

class StackImp {
    Node* topNode;
    int size;

public:
    StackImp() {
        topNode = nullptr;
        size = 0;
    }

    void push(int x) {
        Node* temp = new Node(x);
        temp->next = topNode; // new node points to current top
        topNode = temp;       // update top
        size++;
        cout << x << " pushed to stack." << endl;
    }

    void pop() {
        if (topNode == nullptr) {
            cout << "Stack Underflow!" << endl;
            return;
        }
        Node* temp = topNode;
        cout << topNode->data << " popped from stack." << endl;
        topNode = topNode->next;
        delete temp;
        size--;
    }

    int peek() {
        if (topNode == nullptr) {
            cout << "Stack is empty!" << endl;
            return -1;
        }
        return topNode->data;
    }

    int length() {
        return size;
    }

    bool isEmpty() {
        return topNode == nullptr;
    }
};

int main() {
    StackImp st;
    st.push(10);
    st.push(20);
    st.push(30);
    cout << "Top element: " << st.peek() << endl;
    st.pop();
    cout << "Top element after pop: " << st.peek() << endl;
    cout << "Current size: " << st.length() << endl;
}
```

## Creating Stack Using Queue

```cpp
#include <iostream>
#include <queue>
using namespace std;

class Stack {
    queue<int> q;

public:
    // Push element onto stack
    void push(int x) {
        int size = q.size();
        q.push(x);
        cout << x << " is pushed in stack" << endl;

        // Move all previous elements behind the new one
        for (int i = 0; i < size; i++) {
            q.push(q.front());
            q.pop();
        }
    }

    // Remove top element
    void pop() {
        if (q.empty()) {
            cout << "Stack Underflow!" << endl;
            return;
        }
        q.pop();
    }

    // Return top element
    int top() {
        if (q.empty()) {
            cout << "Stack is empty!" << endl;
            return -1;
        }
        return q.front();
    }

    // Return current size
    int size() {
        return q.size();
    }

    // Check if empty
    bool empty() {
        return q.empty();
    }
};

// Driver code
int main() {
    Stack s;
    s.push(10);
    s.push(20);
    s.push(30);

    cout << "Top element: " << s.top() << endl;
    s.pop();
    cout << "Top after pop: " << s.top() << endl;
    cout << "Current size: " << s.size() << endl;

    return 0;
}
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

## Queue Using LinkedList

```cpp
#include <iostream>
using namespace std;

// Node structure
class Node {
public:
    int val;
    Node* next;  

    Node(int data) {  
        val = data;
        next = NULL;
    }
};
```

```cpp
// Queue class
class Queue {
    Node* start;
    Node* end;
    int size;

public:
    Queue() {
        start = nullptr;
        end = nullptr;
        size = 0;
    }

    void push(int x) {
        Node* temp = new Node(x);
        if (start == nullptr) {  // First element case
            start = end = temp;
        } else {
            end->next = temp;
            end = temp;
        }
        size++;
    }

    void pop() {
        if (size == 0) {
            cout << "Queue Underflow\n";
            return;
        }
        Node* temp = start;
        start = start->next;
        delete temp;
        size--;
        if (start == nullptr) end = nullptr; // reset end when queue becomes empty
    }

    int peek() {
        if (size == 0) {
            cout << "Queue is empty\n";
            return -1;  // return an invalid value
        }
        return start->val;
    }

    int length() {
        return size;
    }
};

int main() {
    Queue q;
    q.push(10);
    q.push(20);
    q.push(30);

    cout << "Front element: " << q.peek() << endl;
    q.pop();
    cout << "Front after pop: " << q.peek() << endl;
    cout << "Queue size: " << q.length() << endl;
}

```

## Creating Queue using stack

### Approach 1

- if your code has lot of pop or top operations then use this operation 
- Since push is very expensive here
```cpp
#include <iostream>
#include <stack>
using namespace std;

class Queue {
    stack<int> s1, s2;

public:
    // Enqueue (push)
    void push(int x) {
        // Move all elements from s1 to s2
        while (!s1.empty()) {
            s2.push(s1.top());
            s1.pop();
        }

        // Push new element into s1
        s1.push(x);

        // Move all elements back from s2 to s1
        while (!s2.empty()) {
            s1.push(s2.top());
            s2.pop();
        }

        cout << x << " is pushed in queue" << endl;
    }

    // Dequeue (pop)
    void pop() {
        if (s1.empty()) {
            cout << "Queue Underflow!" << endl;
            return;
        }
        s1.pop();
    }

    // Get front element
    int peek() {
        if (s1.empty()) {
            cout << "Queue is empty!" << endl;
            return -1;
        }
        return s1.top();
    }

    // Get size
    int size() {
        return s1.size();
    }

    // Check if empty
    bool empty() {
        return s1.empty();
    }
};

// Driver code
int main() {
    Queue q;
    q.push(10);
    q.push(20);
    q.push(30);

    cout << "Front element: " << q.peek() << endl;
    q.pop();
    cout << "Front after pop: " << q.peek() << endl;
    cout << "Queue size: " << q.size() << endl;
}

```

### Approach 2

- If your algorithm has lot of push operations then use this algorithm 
- Here pop and top is expensive 
```cpp
#include <iostream>
#include <stack>
using namespace std;

class Queue {
    stack<int> s1, s2;  // two stacks

public:
    // Push operation — O(1)
    void push(int x) {
        s1.push(x);
        cout << x << " is pushed in queue" << endl;
    }

    // Pop operation — O(n)
    void pop() {
        if (s1.empty()) {
            cout << "Queue Underflow!" << endl;
            return;
        }

        // Move all elements except the last one to s2
        while (s1.size() > 1) {
            s2.push(s1.top());
            s1.pop();
        }

        // Remove the front element (bottom of s1)
        s1.pop();

        // Move everything back to s1
        while (!s2.empty()) {
            s1.push(s2.top());
            s2.pop();
        }
    }

    // Peek front element
    int peek() {
        if (s1.empty()) {
            cout << "Queue is empty!" << endl;
            return -1;
        }

        // Move all elements to s2 to access front
        while (s1.size() > 1) {
            s2.push(s1.top());
            s1.pop();
        }

        int front = s1.top();  // front element

        // Move it to s2 temporarily
        s2.push(front);
        s1.pop();

        // Move everything back to s1
        while (!s2.empty()) {
            s1.push(s2.top());
            s2.pop();
        }

        return front;
    }

    // Return current size
    int size() {
        return s1.size();
    }

    bool empty() {
        return s1.empty();
    }
};

int main() {
    Queue q;
    q.push(10);
    q.push(20);
    q.push(30);

    cout << "Front element: " << q.peek() << endl;
    q.pop();
    cout << "Front after pop: " << q.peek() << endl;
    cout << "Queue size: " << q.size() << endl;

    return 0;
}

```
