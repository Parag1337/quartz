---
title: Python For Engineering
---

>Python : An versatile, high-level programming language known for its readability and simplicity

# 1. 🧱 Data Types

- `str` → **String** (e.g., `"Hello"`)
- `int` → **Integer** (e.g., `10`)
- `float` → **Floating point number** (e.g., `3.14`)
- `bool` → **Boolean** (`True` or `False`)

---

# 2. 🔁 Type Checking & Type Casting

#### Type Checking

```python
type(variable)  # Returns the type of the variable
```

#### Type Casting

```python
int("10")      # Convert string to integer
float("3.14")  # Convert string to float
str(100)       # Convert number to string
bool(1)        # Convert to Boolean (1=True, 0=False)
```
#### Example
```python
a = b ** 2  # a is b squared
```
#### Modulus Operator
```python
%  # Returns remainder
```

---

# 3. ⚙️ Built-in Functions

| Function      | Description                              |
| ------------- | ---------------------------------------- |
| `round(a, b)` | Round number `a` to `b` decimal places   |
| `abs(x)`      | Returns the absolute value of `x` → `    |
| `pow(x, y)`   | Returns `x` raised to the power `y`      |
| `max()`       | Returns the largest of the given values  |
| `min()`       | Returns the smallest of the given values |

---

# 4. 🧮 Math Library Functions

```python
import math
```

| Function        | Description                           |
| --------------- | ------------------------------------- |
| `math.pi`       | π = 3.14159...                        |
| `math.e`        | Euler’s number = 2.718...             |
| `math.sqrt(x)`  | Square root of `x`                    |
| `math.ceil(x)`  | Round **up** to the nearest integer   |
| `math.floor(x)` | Round **down** to the nearest integer |

---

# 5. 🔀 Conditional Statements

```python
if condition:
    # Code block if condition is True
elif another_condition:
    # Code block if elif is True
else:
    # Code block if none of the above are True
```

### Example

```python
x = 10
if x > 0:
    print("Positive number")
else:
    print("Non-positive number")
```

---

# 6. ✨ String Methods 

| Method                     | Description                                                                   |
| -------------------------- | ----------------------------------------------------------------------------- |
| `len(string)`              | Returns the length of the string                                              |
| `string.find("x")`         | Returns the index of the first occurrence of `"x"`; returns `-1` if not found |
| `string.upper()`           | Converts all characters to uppercase                                          |
| `string.lower()`           | Converts all characters to lowercase                                          |
| `string.capitalize()`      | Capitalizes only the first character                                          |
| `string.isdigit()`         | Returns `True` if the string contains only digits                             |
| `string.isalpha()`         | Returns `True` if the string contains only alphabetic characters              |
| `string.count("-")`        | Counts the number of occurrences of `"-"`                                     |
| `string.replace("-", " ")` | Replaces all `"-"` with a space                                               |
|                            |                                                                               |

### 🛈 To explore more string methods:

```python
print(help(str))
```

---

# 7. 🔢 String Indexing & Slicing

#string_indexing

> Indexing is accessing elements of a sequence using square brackets `[ ]`  
> Format: `[start : end : step]`

| Expression            | Description                  | Output (for `credit_number = "123-5678-9012-3456"`) |
| --------------------- | ---------------------------- | --------------------------------------------------- |
| `credit_number[0:4]`  | Characters from index 0 to 3 | `'123-'`                                            |
| `credit_number[:4]`   | From start to index 3        | `'123-'`                                            |
| `credit_number[5:]`   | From index 5 to end          | `'678-9012-3456'`                                   |
| `credit_number[-2]`   | Second last character        | `'5'`                                               |
| `credit_number[::2]`  | Every second character       | `'13-6891-36'`                                      |
| `credit_number[::-1]` | Reversed string              | `'6543-2109-8765-321'`                              |

---
# 8. 🎯 Format Specifiers

> Format specifiers are used inside `f""` strings to control the appearance of values.
### Common Format Flags:

| Syntax | Description                     |
| ------ | ------------------------------- |
| `.2f`  | Round to 2 decimal places       |
| `:10`  | Allocate 10 spaces              |
| `:03`  | Zero-pad to 3 digits            |
| `:<10` | Left align                      |
| `:>10` | Right align                     |
| `:^10` | Center align                    |
| `:+`   | Show sign (`+` or `-`)          |
| `:=`   | Sign before number padding      |
| `:`    | Space before positive numbers   |
| `:,`   | Add comma as thousand separator |

### Examples

```python
price1 = 1234.567
price2 = 49.9

print(f"Price of 1 is ${price1:>10,.2f}")  # Right aligned, comma, 2 decimal
print(f"Price of 2 is ${price2:.2f}")      # Rounded to 2 decimal places
```

---

# 🔁 9. Loops

#### 🔄 While Loops

**Syntax:**

```python
while condition:
    # code to repeat
```

**Example: Input Validation**

```python
name = ""
while name == "":
    print("You did not enter your name.")
    name = input("Enter your name: ")

print(f"Hello {name}")
```

**Infinite Loop (manual break):**

```python
while True:
    user_input = input("Type 'exit' to quit: ")
    if user_input == "exit":
        break
```
#### 🔂 For Loops

**Syntax:**

```python
for variable in range(start, stop, step):
    # code to repeat
```

**Examples:**

```python
# Print numbers from 1 to 10
for x in range(1, 11):
    print(x)

# Print numbers in reverse from 10 to 1
for x in range(10, 0, -1):
    print(x)

# Print odd numbers from 1 to 10
for x in range(1, 11, 2):
    print(x)
# Print numbers in reverse from 1 to 10 using reversed()
for x in reversed(range(1, 11)):
    print(x)
# Print odd numbers from 1 to 10
for x in range(1, 11, 2):
    print(x)
```

---
# 10. [[📦 Collections]]

---

#  11. 🎲 Random Library Functions

#random_library

| Function                              | Description                                                                       | Example Usage                                  |
| ------------------------------------- | --------------------------------------------------------------------------------- | ---------------------------------------------- |
| `random.randint(a, b)`                | Returns a random integer N such that `a <= N <= b`.                               | `random.randint(1, 10)`                        |
| `random.random()`                     | Returns a random float in the range `[0.0, 1.0)`.                                 | `random.random()`                              |
| `random.choice(seq)`                  | Returns a random element from a non-empty sequence.                               | `random.choice(['rock', 'paper', 'scissors'])` |
| `random.shuffle(list)`                | Shuffles the sequence in place (only works on mutable sequences like lists).      | `random.shuffle(cards)`                        |
| `random.uniform(a, b)`                | Returns a random float N such that `a <= N <= b`.                                 | `random.uniform(1.5, 5.5)`                     |
| `random.sample(population, k)`        | Returns a list of `k` unique elements chosen from the population sequence or set. | `random.sample(range(100), 5)`                 |
| `random.seed(value)`                  | Initializes the random number generator with a seed value for reproducibility.    | `random.seed(42)`                              |
| `random.randrange(start, stop, step)` | Returns a randomly selected element from `range(start, stop, step)`.              | `random.randrange(0, 10, 2)`                   |

### Example:

```python
import random

options = ("rock", "paper", "scissors")
cards = [1, 2, 3, 4, 5]

print(random.randint(1, 6))               # e.g., 4
print(random.random())                    # e.g., 0.37444887175646646
print(random.choice(options))             # e.g., 'paper'
random.shuffle(cards)
print(cards)                             # e.g., [3, 1, 5, 2, 4]
print(random.uniform(1.0, 10.0))          # e.g., 6.8723
print(random.sample(range(20), 5))        # e.g., [4, 19, 7, 11, 2]
```

---
# 12.  [[🛒 Functions]] 

> 1. **Positional**  
> 2. **Default**
> 3. **Keyword**
> 4. **Arbitrary (`*args`, `**kwargs`)**

---
# 13. Iterables

	*An object/collection that can return its element one at a time, allowing it to be iterated over in loop*

```python
for element in (1, 2, 3, 4, 5): 
	print(element) my_numbers = (1, 2, 3, 4, 5) 
	
for element in my_numbers: print(element)
```
```python
dictonaryies
```

---
# 14. ✅ Membership Operators

#membership_operator

>_Used to test if a value exists in a sequence (`string`, `list`, `tuple`, `set`, `dict`)_

- `in` → True if found
- `not in` → True if not found

```python
word = "apple"
letter = input("Guess a letter: ")
if letter in word:
    print(f"There is a {letter}")
else:
    print(f"{letter} not found")
```

---

# 15. 🧠 List Comprehension

#list_comprehension

>_A short and clean way to build lists:_

```python
[expression for item in iterable if condition]
```

```python
# Doubles & Triples
double = [x*2 for x in range(1, 11)]
triple = [x*3 for x in range(1, 11)]

# Uppercase fruits
fruits = ["apple", "banana", "coconut"]
upfruits = [fruit.upper() for fruit in fruits]

# Filter positives
numbers = [1, -2, 3, -4, 5]
positives = [n for n in numbers if n >= 0]
```

---

Here's the corrected and clean version of your **Match Case (Switch)** example for Python:

---

# 16. 🧭 Match Case (Switch Alternative)  
#match_case  
*Introduced in Python 3.10+ as an alternative to switch-case*

```python
day = int(input("Enter the day (1–7): "))

match day:
    case 1:
        print("It's Monday")
    case 2:
        print("It's Tuesday")
    case 3:
        print("It's Wednesday")
    case 4:
        print("It's Thursday")
    case 5:
        print("It's Friday")
    case 6:
        print("It's Saturday")
    case 7:
        print("It's Sunday")
    case _:
        print("Invalid day")
```

 version using strings or keywords too (e.g., `"mon"`, `"tue"`).
 
---

# 17. 📦 Modules
#modules
>*A file containing code you want to include in your program use 'import' to include a module (build-in or your own) usefull to break up a large programs reusable separate files*

`print(help("modules"))`
`print(help("maths"))`

```python
import maths as m      # It is very helpfull to wrtie short code
print(m.pi)

from maths import pi
print(pi)
```

*Use can also create your own function by just simply naming the py file 
and then import example

---
## 18.  Scope Resolution 
#scope_resoultion
**variable scope** : *Where a variable is visible and accesible*
**Scope Resolution** : *(LEGB) Local -> Enclosed -> Global -> Build-in*

##### Local and unclosed variable
```python
def outer_function():
    message = "Enclosed Scope"

    def inner_function():
        message = "Local Scope"
        print("Inner:", message)  # Local variable is used here

    inner_function()
    print("Outer:", message)  # Enclosed variable is used here

outer_function()

```
##### Global variable
```python
def fun1():
	print(x)
def fun2():
	print(x)
x = 2
fun1()
fun2()
```
#### Build-In
```python
from maths import e
print(e)
```

---
# 19. if  \_\_name\_\_ == \_\_main\_\_

`if __name__ == __main__` : *(this script can be imported OR run standalone)\
						 Functions and classes in this module can be reused
						 without the main block of code executing*

ex. Library = Import library for functionality
			When running directly, display a help page

Suppose we have two files
	==library.py==
```python
def add(a, b):
    return a + b

print("library.py __name__ =", __name__)

if __name__ == "__main__":
    print("Running test code in library:")
    print(add(2, 3))

```
Secound file is 
	==main.py==
```python
import library

print("main.py __name__ =", __name__)

```

###### Case i :
==main.py==
```
library.py __name__ = library
main.py __name__ = __main__
```

-  -When Python runs `main.py`, it **imports** `library.py`.
- So in `library.py`, `__name__ = "library"` → this means the test code under `if __name__ == "__main__":` **won’t run**.
- In `main.py`, `__name__ = "__main__"` → since it’s the main entry point.

###### Case ii :
==library.py==
```
library.py __name__ = __main__
Running test code in library:
5
```

- Now you're directly running `library.py`.
- So `__name__ = "__main__"` inside it → the test block **does run**, and `add(2, 3)` is printed.

## [[Encryption Program]]

---

# 20. [[Object Oriented Programming in Python]]

---


# 21. 💐 Decorator

A function that extends the behavior of another function  W/O modifying the base functions
Pass the base function as an argument to the decorator

```python
def add_sprinkles(func):
	def wrapper(*args,**kwargs):
		print("* You add sprinkles ♨️")
		func(*args,**kwargs)
	return wrapper

def add_fudge(func):
	def wrapper(*args,**kwargs):
		print("*You add fudge*🍫")
		func(*args,**kwargs)
	return wrapper


@add_sprinkles
@add_fudge
def get_ice_cream(flavor):
	print(f"Here is your {flavor} ice cream 🍦")

get_ice_cream(flavor)
```

Here’s an improved and clearer version of your **Exception Handling** notes with better formatting, explanations, and examples:

---

# 🧨 22. Exception Handling in Python

### What is an Exception?

An **exception** is an **unexpected error** that occurs during program execution and disrupts the normal flow.  
Examples:

- `ZeroDivisionError` – dividing by zero
- `TypeError` – invalid operations between incompatible types
- `ValueError` – invalid value passed (e.g., converting a letter to an integer)
    

### 🔁 Flow of Exception Handling

Python uses **try–except–finally** blocks to handle exceptions gracefully.

```python
try:
    # Code that might raise an exception
except SomeError:
    # Handle specific exception
except AnotherError:
    # Handle another specific exception
except Exception:
    # Handle any other exception (not recommended as first choice)
finally:
    # Cleanup code that runs no matter what (optional)
```

---

### ✅ Best Practice Example:

```python
try:
    number = int(input("Enter a number: "))
    result = 10 / number
    print("Result:", result)
except ZeroDivisionError:
    print("❌ Cannot divide by zero!")
except ValueError:
    print("❌ Please enter a valid number.")
except Exception as e:
    print("⚠️ Something went wrong:", e)
finally:
    print("✅ Cleanup: This always runs.")
```

---

### ⚠️ Avoid This (Not Recommended):

```python
try:
    number = int(input("Enter a number: "))
except Exception:
    print("Something went wrong!")  # Vague and not helpful
```

> ❗ **Why not use generic `except Exception` first?**  
> Because it hides the actual problem and makes debugging difficult. Always catch **specific exceptions first**, then use a general exception handler as a last resort.
---

## 23.  [[File Handling in Python]]


---

## 24. 📘 ASCII Values in Python

>- **ASCII** stands for **American Standard Code for Information Interchange**.
>- It assigns a unique **numeric code** to each character (letters, digits, symbols).
#### 1. `ord()`
- **Purpose**: Returns the ASCII value of a **single character**.
- ✅ **Examples**:
  ```python
  ord('A')  # Output: 65
  ord('5')  # Output: 53
```
#### 2. `chr()`
- **Purpose**: Converts an ASCII value (integer) back to its corresponding character.
- ✅ **Examples**:
    ```python
    chr(97)  # Output: 'a'
    chr(36)  # Output: '$'
    ```
##### 🔹 Bonus: Convert Full String to ASCII List
```python
text = "Hi5"
ascii_list = [ord(ch) for ch in text]
print(ascii_list)
```
**Output:**
```
[72, 105, 53]
```
### 🧠 Key Points Summary

- `ord()` → character to ASCII
- `chr()` → ASCII to character
- `ord()` requires a **string of length 1**
- Use list comprehension to convert full strings easily


[[NumPy]]