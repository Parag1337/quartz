---
title: Single Linked List
date: 2025-10-06
tags: 
---
Got it 👍 Let’s go step by step so you get a clear understanding of **Linked List in C++**.

---

# What is a Linked List?

A **Linked List** is a **linear data structure** where elements (called **nodes**) are stored at non-contiguous memory locations.  
Each node contains:

1. **Data** → stores the actual value.
2. **Pointer (next)** → stores the address of the next node.

Unlike arrays:

- Size is not fixed (dynamic in nature)/    
- Insertion & deletion are easier (no shifting required).\

Where it is used
- It is used in storing for Stack and queue.
- In real life it is used in browser

---

## 🔹 Types of Linked Lists

1. **Singly Linked List** – Each node points to the next node.
2. **Doubly Linked List** – Each node points to both next and previous nodes.
3. **Circular Linked List** – Last node points back to the first node.

---

## 🔹 Structure of a Node

In C++ we usually define a node using a `struct` or `class`:

```cpp
#include <iostream>
using namespace std;

// Node structure
class Node {
public:
    int data;
    Node* next;  // Pointer to next node

    Node(int val) {  // Constructor
        data = val;
        next = NULL;
    }
};
```


```cpp
int main(){
	vector<int> arr = {3,5,6,78};
	Node* y = new Node(arr[0]);  // dyanamicaly
	Node b = Node{arr[2]}
	
	cout << y->data;
	cout << b.data;
}
```

### Step by step:

1. **`Node* y`**
    - Declares `y` as a **pointer to a Node**.
    - `y` itself lives on the **stack** (because it’s a local variable).
    - Its value will be the **address of a Node object**.

2. **`new Node(arr[0])`**    
    - Dynamically allocates a `Node` object on the **heap**.
    - Calls the **Node constructor** with `arr[0]` as the parameter.
    - Returns the **address** of that heap-allocated Node.
        
3. **Assignment to `y`**
    - `y` now stores the **address of the newly created Node**.

### Memory Used By it 

- Stack: `y` (the pointer) → 8 bytes (64-bit system).
- Heap: `*y` (the integer value 5) → 4 bytes.

Total = 12 bytes (roughly).

---

## 🔹 Basic Operations on Linked List

```cpp
Node* convertArr2LL(vector<int> &arr){
	Node *head = new Node(arr[0]);
	Node *mover = head;
	for(int i = 1 ; i < arr.size(); i++){
		Node* temp = new Node(arr[i]);
		mover -> next = temp;
		mover = temp;
	}
	return head;
}
```


### Now we will do traversing
```cpp
int main(){
	vector<int> arr = {12,5,8,7};
	Node* Head = convertArr2LL(arr);
	Node* temp = Head;
	
	while(temp!= NULL){
		cout << temp->data << " " ;
		temp = temp->next;
	}
}
```

### Search In linked list
```cpp
Node* (Node* Head,int value){
	Node* temp = Head;
	while(temp!= NULL){
		if(temp->data == value){
			return 1
		}
		temp = temp->next;
	}
	return 0;
}
```

### Delete the head
```cpp
Node * DeleteHead(Node * head){
	if(head== NULL){return head};
    Node * temp = head;
    head = head->next;
    delete temp;
    return head;
}
```

### Delete the tail
```cpp
Node* DeleteTail(Node* head) {
    if (head == NULL || head->next == NULL) {
        delete head; // free memory if single node
        return NULL;
    }

    Node* temp = head;
    while (temp->next->next) {
        temp = temp->next;
    }

    // temp->next is the last node
    delete temp->next;
    temp->next = NULL;

    return head;
}

```

### Delete Kth Node
```cpp
Node* deleteK(Node* head, int k) {
    if (head == NULL) return head;

    if (k == 1) { // delete head
        Node* temp = head;
        head = head->next;
        delete temp;
        return head;
    }

    Node* temp = head;
    for (int i = 1; i < k - 1 && temp->next != NULL; i++) {
        temp = temp->next;
    }

    if (temp->next == NULL) return head; // k is out of bounds

    Node* nodeToDelete = temp->next;
    temp->next = temp->next->next; // skip the k-th node
    delete nodeToDelete;

    return head;
}

```
### Delete According to value k
```cpp
Node* deleteByValue(Node* head, int val) {
    if (head == NULL) return head;

    // If head itself needs to be deleted
    if (head->data == val) {
        Node* temp = head;
        head = head->next;
        delete temp;
        return head;
    }

    Node* temp = head;
    while (temp->next != NULL && temp->next->data != val) {
        temp = temp->next;
    }

    if (temp->next == NULL) return head; // value not found

    Node* nodeToDelete = temp->next;
    temp->next = temp->next->next;
    delete nodeToDelete;

    return head;
}

```

### Insert New Head
```cpp
Node* InsertNewHead(Node* Head,int value){
	Node* NewHead = new Node(value);
	NewHead->next = Head;
	return NewHead;
}
```

### Insert New tail
```cpp
Node* InsertNewTail(Node* head, int value) {
    if (head == NULL) {
        return new Node(value); // empty list, new node becomes head
    }

    Node* temp = head;
    while (temp->next != NULL) { // traverse to last node
        temp = temp->next;
    }

    temp->next = new Node(value); // add new node at the end
    return head;
}

```

### Insert At Kth position
```cpp
Node* InsertAtK(Node* head, int k, int value) {
    // Insert at head
    if (k == 1 || head == NULL) {
        Node* newNode = new Node(value);
        newNode->next = head;
        return newNode;
    }

    Node* temp = head;
    // Move to the (k-1)-th node
    for (int i = 1; i < k - 1 && temp->next != NULL; i++) {
        temp = temp->next;
    }

    // Create new node and insert
    Node* newNode = new Node(value);
    newNode->next = temp->next;
    temp->next = newNode;

    return head;
}

```
	


![[Pasted image 20251002142159.png | 500]]

[[Questions On Linked List]]


