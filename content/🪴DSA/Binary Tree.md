---
title: Binary Tree
date: 2025-10-19
tags: 
---

# 🌳 Introduction to Binary Trees

A **Binary Tree** is a non-linear hierarchical data structure in which each node can have at most **two children**, referred to as the **left child** and the **right child**.

---

### 🔹 Basic Terms

- **Root** – The topmost or starting node of a tree. It has no parent.
    
- **Children** – The nodes that are directly connected and below a node.
    
- **Subtree** – Any node along with all its descendants forms a subtree.
    
- **Leaf Node** – A node that has **no children** (both left and right pointers are `NULL`).
    
- **Ancestors** – All nodes that exist on the path from the **root** to a given node (excluding the node itself).
    

![[Pasted image 20251019210409.png|300]]

---

## 🌲 Types of Binary Trees

### 1. Full Binary Tree

A binary tree in which every node has **either 0 or 2 children**.  
There are **no nodes with only one child**.

### 2. Complete Binary Tree

A binary tree in which:

1. All levels are **completely filled** except possibly the last level.
2. The last level’s nodes are **as far left as possible** (i.e., filled from left to right).

This type of tree is mainly used in **heaps** and **priority queues**.

![[Pasted image 20251019211249.png|300]]

---

### 3. Perfect Binary Tree

A binary tree where:

- **All internal nodes** have exactly two children, and
- **All leaf nodes** are at the **same level**.

For a perfect binary tree with height `h`, the total number of nodes is:  
$$
[  
N = 2^{h+1} - 1  
]
$$
![[img2.png|300]]

### 4. Balanced Binary Tree

A binary tree where the height difference between the left and right subtrees of any node is **at most 1**.  
The overall height is **``O(log N)``**, ensuring efficient operations like search, insert, and delete.

Examples: **AVL Tree**, **Red-Black Tree**, **B-Trees**, etc.
![[balance-vs-unbalance-binnary-tree.webp|300]]

### 5. Degenerate (or Skewed) Binary Tree

A binary tree in which **every node has only one child** (either left or right).  
It behaves like a **linked list**, and the height of such a tree is equal to the number of nodes.

---
## Binary Tree Representation in C++

```cpp
#include <iostream>
using namespace std;

// Define a Node class representing each node in the binary tree
class Node {
public:
    int data;
    Node* left;
    Node* right;

    // Constructor to initialize a new node with given data
    Node(int data) {
        this->data = data;
        left = right = nullptr;
    }
	};

int main() {
    // Create the root node
    Node* root = new Node(2);

    // Display root data
    cout << "Root Node: " << root->data << endl;

    // Create left and right child nodes
    root->left = new Node(3);
    root->right = new Node(4);

    // Display child nodes
    cout << "Left Child: " << root->left->data << "  ";
    cout << "Right Child: " << root->right->data << endl;

    return 0;
}

```


---

# Traversal Techniques (BFS / DFS)

Traversal means **visiting every node** of a binary tree exactly once in a particular order.  
It is mainly classified into two types:

1. **Depth First Traversal (DFS)**
2. **Breadth First Traversal (BFS)**

---

## Depth First Traversal (DFS)

DFS explores as far as possible along each branch before backtracking.  
It uses a **stack** (either explicitly or via recursion).

### Common DFS Orders:

1. **Inorder Traversal** → `(Left → Root → Right)`
2. **Preorder Traversal** → `(Root → Left → Right)`
3. **Postorder Traversal** → `(Left → Right → Root)`

---

### Example 1                                     Example 2

![[Pasted image 20251019220359.png|300]]   ![[Pasted image 20251019221209.png|300]]



### 1️⃣ Inorder Traversal (Left → Root → Right)

- **Definition:**  
    Visit the **left subtree**, then the **root**, and finally the **right subtree**.
    
- **Used for:**  
    Getting **sorted order** of elements in a **Binary Search Tree (BST)**.
    

**Example 1 Output:**  
`4 5 6` → `1` → `6 3 7`  
**Final Order:** `4 5 6 1 6 3 7`

**Example 2 Output:**  
`4 2` → `8 5` → `1` → `6 3` → `9 7 10`  
**Final Order:** `4 2 8 5 1 6 3 9 7 10`

---

### 2️⃣ Preorder Traversal (Root → Left → Right)

- **Definition:**  
    Visit the **root** first, then **left subtree**, and finally **right subtree**.
    
- **Used for:**  
    Copying or **creating a clone** of the tree.
    

**Example 1 Output:**  
`1` → `2 4 5` → `3 6 7`  
**Final Order:** `1 2 4 5 3 6 7`

**Example 2 Output:**  
`1` → `2 4` → `5 8` → `3 6` → `7 9 10`  
**Final Order:** `1 2 4 5 8 3 6 7 9 10`

---

### 3️⃣ Postorder Traversal (Left → Right → Root)

- **Definition:**  
    Visit the **left subtree**, then **right subtree**, and finally the **root**.
    
- **Used for:**  
    **Deleting** or **freeing** the tree from memory (since children are processed before the parent).
    

**Example 1 Output:**  
`4 5 2 6 3 7 1`

**Example 2 Output:**  
`4 8 5 2 6 9 10 7 3 1`

---

## 🌾 Breadth First Traversal (BFS)

![[Pasted image 20251019235035.png|300]]

- Also called **Level Order Traversal**.
    
- Visits nodes **level by level**, from **top to bottom** and **left to right**.
    
- Implemented using a **queue**.
    

**Order:**  
`1 2 3 4 5 6 7 8 9 10`

---
More Example To practise
![[postorder-traversal-1.png|300]] ![[Binary-Search-Tree-Example.png|250]] ![[Pasted image 20251020181215.png|300]]

---
# [[Traversal in Binary Tree]]

1. Inorder Traversal (`Left → Root → Right`)
2. Preorder Traversal `(Root → left → Right`)
3. Postorder Traversal (`Left → Right → Root`)


