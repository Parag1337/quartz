---
title: Questions On Linked List
date: 2025-10-08
tags: 
---
### Reverse a linked list
```cpp
Node* ReverseLinkedlList(Node* head) {
    stack<int> list = {};      // stack to store node data
    Node* temp = head;

    // Step 1: Push all data into the stack
    while (temp != nullptr) {
        int value = temp->data;
        list.push(value);
        temp = temp->next;
    }

    // Step 2: Replace node data from stack (in reverse order)
    temp = head;
    while (temp != nullptr) {
        temp->data = list.top();
        list.pop();
        temp = temp->next;
    }

    return head;
}

```
### Reverse the linked List reclusively
```cpp
Node* reverseLinkedList(Node* head){
	if(head == NULL || head ->next == NULL){
		returnn head;
	}
	Node* newHead = reverseLinkedList(head ->next;)
	Node* front = head -> next
	front -> next = head;
	head -> next = NULL;
	return newHead;
}
```

### Reverse a doubly Linked List 
```cpp
Node* ReverseDoublyLinkedList(Node* head){
	if(head == nullptr || head-> next == nullptr){
		return head;
	}
	Node* current = head;
	Node* last = nullptr
	while(current!=nullptr){
		last = current -> back;
		current -> back = current -> next;
		current -> next = last
		current = current ->back
	}
	return prev->back;
}
```
