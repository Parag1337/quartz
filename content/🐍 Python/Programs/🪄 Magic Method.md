---
name: 🪄 Magic Method
---

Dunder method (double underscore) `__init__`,`__str__`,`__eq__` 
They are automatically called by many of pythons' build in operators.
They allows develops to define or customize the behavior of object. 

```python
class Book:
	def __init__ (self,title,author,num_pages):
		self.title = title
		self.author = author
		self.num_pages = num_pages

	def __str__(self):
		return f"{self.title} by {self.author}"

	def __eq__(self,other):
		return self.title == other.title and self.author == other.author

	def __lt__(self,other):
		return self.num_pages < other.num_pages

	def __add__(self,other):
		return f"{self.num_pages + other.num_pages}"

	def __contains__(self,keyword):
		return keyword in self.title

	def __getitem__(self,key):
		if key == "title"
			return self.title
		if key == "author":
			return self.author
		

book1 = Book("The Hobbit", "J.R.R. Tolkien", 310) 
book2 = Book ("Harry Potter and The Philosopher's Stone", "J.K. Rowling", 223) 
book3 = Book("The Lion the Witch and the Wardrobe","CS Wardrobe", 172)
book4 = Book("The Hobbit", "J.R.R. Tolkien", 50) 

print(book1)
print(book1 == book4 )
print(book2<book3)
print(book1 + book2)

print("Lion" in book3)

print(book1['author'])
```

#### 1. **Object Initialization and Representation**:

- **`__init__(self, ...)`**: Constructor method, called when a new object is created
- **`__del__(self)`**: Destructor method, called when an object is about to be destroyed.
#### 2. **String Representation**:

- **`__str__(self)`**: Called by `str()` or `print()` to get a human-readable string representation of the object.
- **`__repr__(self)`**: Called by `repr()` to get a more formal string representation, useful for debugging
- **`__format__(self, format_spec)`**: Used for custom formatting, called by `format()`.
#### 3. **Comparison Methods**:

- **`__eq__(self, other)`**: Called by the `==` operator.
- **`__ne__(self, other)`**: Called by the `!=` operator.
- **`__lt__(self, other)`**: Called by the `<` operator.
- **`__le__(self, other)`**: Called by the `<=` operator.
- **`__gt__(self, other)`**: Called by the `>` operator.
- **`__ge__(self, other)`**: Called by the `>=` operator.
#### 4. **Arithmetic and Mathematical Operations**:

- **`__add__(self, other)`**: Called by the `+` operator.
- **`__sub__(self, other)`**: Called by the `-` operator.
- **`__mul__(self, other)`**: Called by the `*` operator.
- **`__truediv__(self, other)`**: Called by the `/` operator.
- **`__floordiv__(self, other)`**: Called by the `//` operator.
- **`__mod__(self, other)`**: Called by the `%` operator.
- **`__pow__(self, other)`**: Called by the `**` operator.

#### 5. **Container-like Behavior**:

- **`__getitem__(self, key)`**: Called to get an item, e.g., `obj[key]`.
- **`__setitem__(self, key, value)`**: Called to set an item, e.g., `obj[key] = value`.
- **`__delitem__(self, key)`**: Called to delete an item, e.g., `del obj[key]`.
- **`__iter__(self)`**: Called to return an iterator, used for iteration.
- **`__next__(self)`**: Called to return the next item in iteration.
- **`__contains__(self, item)`**: Called by `in` operator to check if an item exists in an object.
#### 6. **Object Size and Hashing**:

- **`__len__(self)`**: Called by `len()` to get the length of an object.
- **`__hash__(self)`**: Called by `hash()` to get the hash value of an object (important for hashable objects).
- **`__eq__(self, other)`**: Defines behavior for `==` equality check.
- **`__ne__(self, other)`**: Defines behavior for `!=` inequality check.
#### 7. **Callable Objects**:

- **`__call__(self, ...)`**: Allows an instance to be called like a function.
