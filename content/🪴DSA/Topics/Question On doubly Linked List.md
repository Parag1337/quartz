---
title: Question On doubly Linked List
date: 2025-10-08
tags:
---
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
