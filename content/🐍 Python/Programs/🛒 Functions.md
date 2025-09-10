---
name: 🛒 Functions
---

### Python Function Arguments - Cleaned & Improved Notes

Python allows multiple ways to pass arguments into functions. These are:

> 1. **Positional**  
> 2. **Default**
> 3. **Keyword**
> 4. **Arbitrary (`*args`, `**kwargs`)**


---

### 1. Positional Arguments

- Arguments are passed based on their position.
- Order matters.

```python
def happy_birthday(age, name):
    print(f"Happy birthday to {name}")
    print(f"You are {age} years old!")

happy_birthday(20, "Bro")
happy_birthday(30, "Bro")
```

**Return Statement** – ends the function and sends a result back:

```python
def add(x, y):
    return x + y

print(add(1, 2))
```

---

### 2. Default Arguments

- Provide default values to parameters.
- Used when no argument is passed for that parameter.

```python
def net_price(list_price, discount=0, tax=0.05):
    return list_price * (1 - discount) * (1 + tax)

print(net_price(500))
print(net_price(500, 0.1))
print(net_price(500, 0.1, 0))
```

Invalid example (will cause error):

```python
# Parameter with no default cannot follow one with default
# def count(start=0, end): ❌ Invalid
```

Correct way:

```python
import time

def count(start, end=10):
    for x in range(start, end + 1):
        print(x)
        time.sleep(1)

count(5)
```

---

### 3. Keyword Arguments

- Arguments are passed using parameter names.
- Order doesn’t matter.
- Improves readability.

```python
def hello(greeting, title, first, last):
    print(f"{greeting} {title} {first} {last}")

# Positional
hello("Hello", "Mr.", "Spongebob", "Squarepants")

# Keyword
hello(first="Spongebob", last="Squarepants", title="Mr.", greeting="Hello")

# Mixing (positional must come first)
hello("Hello", first="Spongebob", last="Squarepants", title="Mr.")
```

---

### 4. Arbitrary Arguments

> Used when the number of arguments is not known in advance.

#### *args (Non-keyworded)

```python
def add(*args):
    total = 0
    for num in args:
        total += num
    return total

print(add(1, 2, 3, 4))
```

```python
def display_name(*args):
    for arg in args:
        print(arg, end=" ")

display_name("Dr.", "Spongebob", "Squarepants", "III")
```

#### **kwargs (Keyworded)

```python
def print_address(**kwargs):
    for key, value in kwargs.items():
        print(f"{key}: {value}")

print_address(
    street="123 Fake St.",
    city="Detroit",
    state="MI",
    zip="54321"
)
```

#### Using *args and **kwargs together

```python
def shipping_label(*args, **kwargs):
    for arg in args:
        print(arg, end=" ")
    print()
    for key, value in kwargs.items():
        print(f"{key}: {value}")

shipping_label("Dr.", "Spongebob", "Squarepants", "III",
               street="123 Fake St.",
               apt="100",
               city="Detroit")
```

---

### 📊 Summary Table

|Type|Syntax|Description|
|---|---|---|
|Positional|`func(a, b)`|Standard position-based arguments|
|Default|`func(a=1)`|Used if value not provided|
|Keyword|`func(b=2, a=1)`|Passed using key=value, order doesn’t matter|
|*args|`*args`|Collects extra **non-keyword** args into a tuple|
|**kwargs|`**kwargs`|Collects extra **keyword** args into a dictionary|

---
