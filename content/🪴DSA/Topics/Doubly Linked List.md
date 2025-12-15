---
title: Doubly Linked List
date: 2025-10-06
tags: 
---


---

## What is a **Doubly Linked List (DLL)?**

A **Doubly Linked List** is a type of linked list where **each node is connected to both its previous and next node**.
So, every node stores:
- **Data**
- **Pointer to next node (`next`)**
- **Pointer to previous node (`back` or `prev`)**

This allows:  
✅ Traversal **forward** (using `next`)  
✅ Traversal **backward** (using `back`)

---

## 🔹 Structure of a Node

Each node in a doubly linked list looks like this:

```
| back | data | next |
```

So in C++:

```cpp
class Node {
public:
    int data;
    Node* next;
    Node* back;

    Node(int data1, Node* next1, Node* back1) {
        data = data1;
        next = next1;
        back = back1; 
    }

    Node(int data1) {
        data = data1;
        next = nullptr;
        back = nullptr;
    }
};
```

> 🟡 **Note:** You had a typo in your constructor →  
> `back1 = back1;` should be `back = back1;`  
> otherwise, your `back` pointer will never store the previous node properly.

---

## 🔹 Converting Array → Doubly Linked List

Your function:

```cpp
Node* convertArr2DLL(vector<int> &arr){
    Node* head = new Node(arr[0]);
    Node* prev = head;

    for (int i = 1; i < arr.size(); i++) {
        Node* temp = new Node(arr[i], nullptr, prev); // prev = previous node
        prev->next = temp;
        prev = temp;
    }
    return head;
}
```

```
Node* convertAre2LL(vector)
```

**Explanation:**

1. Create the **head node** from first element.
2. Keep a pointer `prev` to the last node created.
3. For every new element:
    - Create a node whose `back` = `prev`
    - Link `prev->next = temp`        
    - Move `prev` forward
4. Return the head pointer.

---

## 🔹 Traversal (Forward)

```cpp
Node* temp = head;
while (temp != nullptr) {
    cout << temp->data << " ";
    temp = temp->next;
}
```

This moves from the head to the tail.

---

## 🔹 Traversal (Backward)

Once you reach the last node, you can also move **backward** using the `back` pointer:

```cpp
Node* tail = head;
while (tail->next != nullptr) tail = tail->next; // go to last node

while (tail != nullptr) {
    cout << tail->data << " ";
    tail = tail->back;
}
```

---

## 🔹 Visualization

For your array `{12, 5, 8, 7}`:

```
nullptr <- [12] <-> [5] <-> [8] <-> [7] -> nullptr
```

Each `<->` means both `next` and `back` pointers are linked.

---

### Delete The Head Of Doubly Linked List

```cpp
Node* DeleteHead(Node* Head){
	if(head == NULL || head->next == NULL){
	return NULL;
	}
	
	Node* prev = head;
	head = head->next;
	
	head -> back = nullptr;
	prev -> next = nullptr;
	delete prev;
	return Head;
}
```

### Delete The tail Of Doubly Linked List
```cpp
Node* DeleteTail(Node* head) {
    // Case 1: Empty list or only one node
    if (head == NULL || head->next == NULL) {
        delete head;     // delete single node (if it exists)
        return NULL;
    }

    Node* temp = head;

    // Traverse to the second last node
    while (temp->next->next != NULL) {
        temp = temp->next;
    }

    // 'temp->next' is the tail node
    Node* tail = temp->next;

    temp->next = nullptr;   // detach the tail
    tail->back = nullptr;   // remove backward connection
    delete tail;            // free memory

    return head;
}

```

### Delete Kth Term

```cpp
Node* DeleteKth(Node* head, int k) {
    // Case 1: Empty or single-node list
    if (head == NULL) return NULL;
    if (head->next == NULL && k == 1) {
        delete head;
        return NULL;
    }

    // Case 2: Delete first node
    if (k == 1) {
        Node* oldHead = head;
        head = head->next;
        head->back = nullptr;
        oldHead->next = nullptr;
        delete oldHead;
        return head;
    }

    // Case 3: Delete kth node (k > 1)
    Node* temp = head;
    for (int i = 1; i < k - 1 && temp != NULL; i++) {
        temp = temp->next;
    }

    // If k is out of range
    if (temp == NULL || temp->next == NULL) return head;

    Node* todel = temp->next;
    temp->next = todel->next;

    if (todel->next != NULL) { // not deleting the last node
        todel->next->back = temp;
    }

    todel->next = nullptr;
    todel->back = nullptr;
    delete todel;

    return head;
}

```
![[Pasted image 20251007000544.png|350]]

### Insert At the Before Head Of Doubly Linked List
```cpp
Node* InsertAtHead(Node* head, int value) {
    // Case 1: Empty list
    if (head == NULL) {
        Node* newHead = new Node(value);
        return newHead;
    }

    // Case 2: Non-empty list
    Node* newHead = new Node(value,head,nullptr); // create new node
    head->back = newHead;            // old head points back to new node

    return newHead;                  // return new head
}

```

### Insert Before the Tail Of Doubly Linked List
```cpp
Node* InsertBeforeTail(Node* head, int value) {
    // Case 1: Empty list
    if (head == NULL) {
        return new Node(value);
    }

    // Case 2: Only one node → inserting before tail = before head
    if (head->next == NULL) {
        Node* newNode = new Node(value, head, nullptr); // insert before the only node
        head->back = newNode;
        return newNode; // new head
    }

    // Case 3: General case
    Node* temp = head;
    while (temp->next->next != nullptr) {
        temp = temp->next; // stop at second last node
    }

    Node* tail = temp->next;                   // original tail
    Node* newNode = new Node(value, tail, temp); // new node points next=tail, back=temp
    temp->next = newNode;                 // previous node points to new node
    tail->back = newNode;                // tail points back to new node

    return head;
}

```

![[Pasted image 20251007003456.png|350]]

### Insert Before Kth Element
```cpp
Node* InsertBeforeKth(Node* head, int value, int k) {
    // Case 1: Empty list or inserting at head
    if (head == nullptr || k == 1) {
        Node* newHead = new Node(value, head, nullptr);
        if (head != nullptr) head->back = newHead;
        return newHead;
    }

    // Traverse to (k-1)-th node
    Node* temp = head;
    for (int i = 1; i < k - 1 && temp != nullptr; i++) {
        temp = temp->next;
    }

    // If k is out of bounds
    if (temp == nullptr || temp->next == nullptr) return head;

    Node* newNode = new Node(value, temp->next, temp); // create new node
    temp->next->back = newNode; // fix backward link of K-th node
    temp->next = newNode;       // fix forward link of (k-1)-th node

    return head;
}

```

## ✅ Advantages of Doubly Linked List

|Feature|Explanation|
|---|---|
|Two-way traversal|Can move forward and backward|
|Easier deletion|Can delete a node without traversing from the head|
|Easier insertion|Can insert before or after any node easily|

---

## ⚠️ Disadvantages

- Extra memory for storing `back` pointer
- Slightly more complex implementation

---

[[Question On doubly Linked List]]