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

# Final Code
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

int main() {
    // Manually creating the given tree
    /*
                    39
                 /      \
               29        49
              /  \      /  \
            24   34   44   59
           /  \             / \
         14   27          54  69
    */

    Node* root = newNode(39);
    root->left = newNode(29);
    root->right = newNode(49);

    root->left->left = newNode(24);
    root->left->right = newNode(34);
    root->left->left->left = newNode(14);
    root->left->left->right = newNode(27);

    root->right->left = newNode(44);
    root->right->right = newNode(59);
    root->right->right->left = newNode(54);
    root->right->right->right = newNode(69);

    cout << "Inorder Traversal: ";
    inorder(root);
    cout << endl;

    cout << "Preorder Traversal: ";
    preorder(root);
    cout << endl;

    cout << "Postorder Traversal: ";
    postorder(root);
    cout << endl;

    return 0;
}

```