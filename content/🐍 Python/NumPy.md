

---
## 🧠 NumPy Basics: 

### ✅ 1. **Creating Arrays**

```python
import numpy as np

a = np.array([1, 2, 3])             # 1D array
b = np.array([[1, 2], [3, 4]])      # 2D array (matrix)
```

---

### 🔢 2. **Array Arithmetic (Element-wise)**

```python
a = np.array([1, 2, 3])
b = np.array([4, 5, 6])

print(a + b)    # [5 7 9]
print(a - b)    # [-3 -3 -3]
print(a * b)    # [4 10 18]
print(a / b)    # [0.25 0.4 0.5]
```

---

### 🔄 3. **Universal Functions (ufuncs)**

```python
np.sqrt(a)      # Square root
np.exp(a)       # Exponential e^x
np.log(a)       # Natural log
np.sum(a)       # Sum
np.mean(a)      # Average
np.max(a)       # Max value
np.min(a)       # Min value
```

---

### 📏 4. **Shape & Reshape**

```python
a = np.array([[1, 2, 3], [4, 5, 6]])

a.shape          # (2, 3)
a.reshape(3, 2)  # Change shape to 3x2
```

---

### 🎯 5. **Slicing and Indexing**

```python
a = np.array([10, 20, 30, 40, 50])

print(a[1])     # 20
print(a[1:4])   # [20 30 40]
print(a[-1])    # 50
```

For 2D arrays:

```python
b = np.array([[1, 2], [3, 4], [5, 6]])

b[0, 1]         # 2 (row 0, column 1)
b[:, 0]         # [1 3 5] (all rows, column 0)
```

---

### 🎲 6. **Random Numbers**

```python
np.random.rand(3)       # 1D array with 3 random values
np.random.randint(1, 10, size=(2, 3))  # 2x3 array of ints from 1 to 9
```

---

### 🔁 7. **Matrix Multiplication**

```python
a = np.array([[1, 2], [3, 4]])
b = np.array([[2, 0], [1, 2]])

np.dot(a, b)       # Matrix multiplication
a @ b              # Same as above (Python 3.5+)
```

---

### ⚠️ 8. **Type Conversion**

```python
a = np.array([1.5, 2.3])
a.astype(int)      # [1 2]
```

---

### 🧼 9. **Filtering with Conditions**

```python
a = np.array([10, 15, 20, 25, 30])

a[a > 20]         # [25 30]
```

---

### 🧱 10. **Stacking Arrays**

```python
a = np.array([1, 2])
b = np.array([3, 4])

np.hstack((a, b))  # [1 2 3 4]
np.vstack((a, b))  # [[1 2], [3 4]]
```

### 📐 **Array Creation**

```python
np.zeros((2, 3))        # 2x3 array of zeros
np.ones((2, 3))         # 2x3 array of ones
np.full((2, 3), 7)      # 2x3 array filled with 7
np.eye(3)               # 3x3 Identity matrix
```

