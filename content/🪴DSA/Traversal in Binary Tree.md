---
title: Traversal in Binary Tree
date: 2025-10-20
tags: 
---




# 🌳 Tree Traversals in Binary Tree

Traversal means **visiting every node** in a tree **exactly once** in a specific order.  
There are mainly **three depth-first traversal methods**:

1. Inorder (L → Root → R)
2. Preorder (Root → L → R)  
3. Postorder (L → R → Root) 

---

## ⚙️ 1. Inorder Traversal (Left → Root → Right)

### Algorithm
1. Traverse the **left subtree** in Inorder.  
2. **Visit (print)** the root node.  
3. Traverse the **right subtree** in Inorder.

### Code
```cpp
void inorder(Node* root) {
    if (root == nullptr) return;
    inorder(root->left);
    cout << root->data << " ";
    inorder(root->right);
}
```

- Used in **Binary Search Trees (BSTs)** to get **sorted order** of elements.

---

## ⚙️ 2. Preorder Traversal (Root → Left → Right)

### Algorithm
1. **Visit (print)** the root node.  
2. Traverse the **left subtree** in Preorder.  
3. Traverse the **right subtree** in Preorder.


###  Code
```cpp
void preorder(Node* root) {
    if (root == nullptr) return;
    cout << root->data << " ";
    preorder(root->left);
    preorder(root->right);
}
```

- Used to **create a copy** of the tree.  
- Helpful for **serializing** trees (storing them in files).

---

## ⚙️ 3. Postorder Traversal (Left → Right → Root)

###  Algorithm
1. Traverse the **left subtree** in Postorder.  
2. Traverse the **right subtree** in Postorder.  
3. **Visit (print)** the root node.


###  Code
```cpp
void postorder(Node* root) {
    if (root == nullptr) return;
    postorder(root->left);
    postorder(root->right);
    cout << root->data << " ";
}
```

- Used for **deleting** or **freeing** all nodes in a tree.  
- Useful in **expression trees** to get **postfix expression**.

---

## Final Code
```cpp
#include <iostream>
using namespace std;

// Define a node structure
struct Node {
    int data;
    Node* left;
    Node* right;
};

// Function to create a new node
Node* newNode(int value) {
    Node* node = new Node();
    node->data = value;
    node->left = node->right = nullptr;
    return node;
}

// Traversal functions
void inorder(Node* root) {
    if (root == nullptr) return;
    inorder(root->left);
    cout << root->data << " ";
    inorder(root->right);
}

void preorder(Node* root) {
    if (root == nullptr) return;
    cout << root->data << " ";
    preorder(root->left);
    preorder(root->right);
}

void postorder(Node* root) {
    if (root == nullptr) return;
    postorder(root->left);
    postorder(root->right);
    cout << root->data << " ";
}



```

# Traversal By level

```cpp
vector<vector<int>> levelOrder(Node* Head) {
    vector<vector<int>> ans;
    if (Head == nullptr) return ans;

    queue<Node*> q;
    q.push(Head);    

    while (!q.empty()) {
        int size = q.size();
        vector<int> level;

        for (int i = 0; i < size; i++) {
            Node* temp = q.front();
            q.pop();

            level.push_back(temp->data);

            if (temp->left != nullptr) q.push(temp->left);
            if (temp->right != nullptr) q.push(temp->right);
        }

        ans.push_back(level);
    }

    return ans;
}
```

```cpp
vector<vector<int> levelorder(Node* Head){
	vector<vector<int> ans;
	if(Head == nullptr){return ans;}
	queue<Node*> q;
	q.push(Head);
	
	while(!q.empty()) {
		int size = q.size();
		vector<int> level;
		
		for(int i = 0; i<size;i++){
			Node* temp = q.front();
			q.pop();
			
			if(temp -> left != nullptr){q.push_back(temp -> left)}
			if(temp -> right != nullptr){q.push_back(temp -> right)}
		}
		ans.push_back(level);
	}
	return ans;
}
```

## ⚙️ 1. Preorder Traversal Iterative (Root → left → Right)
```cpp
vector<int> Preorder(Node* Head) {
    vector<int> ans;
    if (Head == nullptr) return ans;

    stack<Node*> st;
    st.push(Head);

    while (!st.empty()) {
        Node* temp = st.top();
        st.pop();

        ans.push_back(temp->data);  // Visit the node

        // Push right child first so left is processed first (LIFO)
        if (temp->right != nullptr) st.push(temp->right);
        if (temp->left != nullptr) st.push(temp->left);
    }

    return ans;
}
```

## ⚙️ 2. Inorder Traversal Iterative (Left → Root → Right)

```cpp

vector<int> inorder(Node* head) {
    vector<int> ans;
    stack<Node*> st;
    Node* temp = head;

    while (temp != nullptr || !st.empty()) {
        // Go to the leftmost node
        while (temp != nullptr) {
            st.push(temp);
            temp = temp->left;
        }

        // Process the top node
        temp = st.top();
        st.pop();
        ans.push_back(temp->data);

        // Move to the right subtree
        temp = temp->right;
    }

    return ans;
}
```

## ⚙️ 3. Post-order Traversal Iterative (Left → Right → Root)

```cpp

```