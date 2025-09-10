---
name: Object Oriented Programming in Python
---


[[Python For Engineering]]


**Object** : A "Bundle" of related attributed (variable) and methods (functions)
		Ex. Phone, cup, book
		You need a "class" to create many objects
		
**Class** : (blueprint) used to design the structure and layout of an object

```python
# They can be put inside the main file or can be imported 
# from car import Car
class car:
	def __init__(self, model, year, color, for_sale)
		self.model = model
		self.year = year
		self.color = color
		self.for.sale = for_sale
	def drive(self):
		print(f"You drive the car{self.model}")
	def stop(self):
		print(f"You stop the car{self.mode}")
```
```python
car1 = Car("Mustang", 2024, "red", False)
print(car1.model)
print(car1.color)

car2 = Car("Corvette", 2025, "blue", True)
print(car2.model)
print(car.for_sale)

car1.drive()
car2.stop()
```

## Class Variables 

Shared among all instances of a class 
Defined outside the constructor
Allow you to share data among all object created from that class

```python
class Student:

	class_year = 2024          # This is not class variable
	num_student = 0
	def __init__(self,name,age):
		self.name = name
		self.age = age
		Student.num_student += 1

```
```python
student1 = Student("Spongebob", 30)
student2 + Studnent2("Patrick", 35)

print(student2.name)
print(student2.class_year)
print(Student.class_year)     # It is good to access Class variable by directly class instead of another variable

print(Student.num_student)
print(f"My graduating class of {Student.class_year} has {Student.num_student} students")
```

## Inheritance 

Allow a class to inherit attributes and methods from another class
Helps with code reusability and extensibility
`class Child(Parent)`

```python
class Animal:
	def __int__(self,name):
		self.name = name
		self.isalive = True

	def eat(self):
		print(f"{self.name} is eating")
	def sleep(self):
		print(f"{self.name} is sleeping")
		
```
```python
class Dog(Animal):
	pass

class Cat(Animal)
	def speak(self):
		print("Meow!")

class Mouse(Animal):
	pass
```
```python
dog = Dog("Scooby")
cat = Cat("Garfield")
mouse = Mouse("Mickey")

print(dog.name)
dog.sleep()
cat.speak()
```

### Type of Inheritance

**Multiple inheritance** = inherit from more than one parent class
	C(A,B)

**Multilevel inheritance** = inherit from a parent which inherits from another parent 
	C(B) <- B(A) <- A

#### Multiple Inheritance
```python
class Prey:
	def flee(self):
		print("This animal is fleeing")

class Predator:
	def hunt(self):
		print("This animal is hunting")

class Rabit(Prey):
	pass

class Hawk(Predator):
	pass

class Fish(Prey, Predator):
	pass
```
```python
rabbit = Rabbit()
hawk = Hawk()
fish = Fish()

#rabbit.hunt()    # Rabbit has no attributrr hunt ERROR
hawk.hunt()
fish.flee()       # Fish has both attributes
fish.hunt()
```

#### Multilevel Inheritance 
```python
class Animal:
	def __init__(self,name):
		self.name = name
	def eat(self):
		print(f"{self.name} is eating")
	def sleep(self):
		print(f"{self.name} is sleeping")
		
class Prey(Animal):
	def flee(self):
		print(f"This {self.name} is fleeing")

class Predator(Animal):
	def hunt(self):
		print(f"This {self.name} is hunting")

class Rabit(Prey):
	pass

class Hawk(Predator):
	pass

class Fish(Prey, Predator):
	pass
```
```python
rabbit = Rabbit("Bugs")
hawk = Hawk("Tony")
fish = Fish("Nemo")

#rabbit.hunt()    # Rabbit has no attributrr hunt ERROR
hawk.hunt()
fish.flee()       # Fish has both attributes
fish.hunt()
rabbit.eat()

```

`Animal : GrandParent`
`Predactor, Prey : Parent`
`Rabit, Hawk, fish : child`

*fish has two parents*

#### Super()
`super()` = Function used in a child class to call methods from a parent class (superclass).
		Allows you to extend the functionality of the inherited methods

```python
class Shape:
    def __init__(self, color, is_filled):
        self.color = color
        self.is_filled = is_filled


class Circle(Shape):
    def __init__(self, color, is_filled, radius):
        super().__init__(color, is_filled)
        self.radius = radius


class Square(Shape):
    def __init__(self, color, is_filled, width):
        super().__init__(color, is_filled)
        self.width = width

class Triangle(Shape):
    def __init__(self, color, is_filled, width, height):
        super().__init__(color, is_filled)
        self.width = width
        self.height = height

```
```python
circle = Circle("red",True,5)
print(circle.color)
```



```python
class Shape:
	def __init_(self,color,is_filled):
		self.color = color
		self.is_filled = is_filled
	def describe(self):
		print(f"It is {self.color} and {'filled' if self.is_filled else 'not_filled'}")

class Circle(Shape):
	def __init__(self,color,is_filled,radius):
		super().__init__(color,is_filled)
		self.radius = radius

	def describe(self):
		print(f"It is a circle with an area of {3.14 * self.radius * self.radius}cm^2")
		super().describe()    # aftet putting this it will print both parent and chil version 
		
```
```python
circle = Circle("red",True,5)
circle.describe()     #It show print the child version not of pareent

```

#### Polymorphism

*Means to have many forms or faces*

Polymorphism can be achieved in two ways
	**1. Inheritance** =  An object could be treated of the same type as a parent class
	**2. Duck Typing** = Object must have necessary attributes /methods
	


```python
from abc import ABC, abstractmethod

class Shape(ABC):
    @abstractmethod
    def area(self):
        pass


class Circle(Shape):
    def __init__(self, radius):
        self.radius = radius

    def area(self):
        return 3.14 * self.radius ** 2


class Square(Shape):
    def __init__(self, side):
        self.side = side

    def area(self):
        return self.side ** 2


class Triangle(Shape):
    def __init__(self, base, height):
        self.base = base
        self.height = height

    def area(self):
        return 0.5 * self.base * self.height

class Pizza(Circle):
	def __init__(self,toppings,radius):
		super().__init__(radius)
		self.topping = toppings
```
```python
shapes = [Circle(4), Square(5), Triangle(6, 7), Pizza("peppe",15)]
for shape in shapes:
    print(f"{shape.__class__.__name__} Area: {shape.area()}")
	
```

## Duck Typing

"**If it looks like a duck, swims like a duck, and quacks like a duck – it _is_ a duck.**"
So therefore,
**If an object behaves like a certain type (has required methods), it _can be used like that type_** — no need for inheritance.


```python
class Animal:
	alive = True

class Dog(Animal):
	def speak(self):
		print("Woof")

class Cat(Animal):
	def speak(self):
		print("Meow")

class Car:
	def speak(self): 
		print("HONK!")
animals = [Dog(), Cat(),Car()]

for animal in animals:
	animal.speak()
```

- You are **not checking** if each item is an `Animal`.
- You are simply calling `animal.speak()` — assuming they all have a `speak()` method.
- This works **even though** `Car` is not an **Animal**.
- So Python doesn't care about class inheritance — it only cares **whether the object has a `speak()` method**.

> **That’s duck typing!** If it quacks like a duck (has `speak()`), it's treated like one 🦆


## 🧱 Types of Class Method 


### 1. ✅ **Instance Method**

- **Most common**
- Takes `self` as the first argument
- Can access and modify **instance variables**
- Belongs to an **object (instance)**
### 2. ✅ **Static Method**

**Static Method** = A method that belongs to class rather than a object from that class (instance)
Usually used for general Utility function

- *Instance Method* = Best for operations on instances of the class (objects)
- *Static Methods* = Best for utility functions that do not need access to class data

```python
class Employee :
	def __init__(self,name,position):
		self.name = name
		self.position = position
	
	def get_info(self):
		return f"{self.name} = {self.position}"

	@staticmethod
	def is_valid_position(position):
		valid_positions = ["Manager", "Cashier", "Cook", "Janitor"]
		return position in valid_positions

print(Employee.is_valid_position)
employee1 = Employee("Eugene","Manager")
employee2 = Employee("Squidward", "Cashier")
employee3 = Employee("Spongebob","Cook")

print(Employee.is_valid_position("Cook"))
print(employee1.get_info())
print(employee2.get_info())
print(employee3.get_info())
``` 

- A **static method** is a method that does **not depend on class (`cls`) or instance (`self`) data**. It is used for **utility functions** that relate to the class.

- `is_valid_position` is a **static method**.
- It checks whether a given position is valid.
- It does **not use `self` or `cls`**, so it's defined as `@staticmethod`.

### 3. ✅ **Class Method**

Allow operations to the class itself
Take (cls) as the first parameter, which is represents the class itself

```python
class Student :

	count = 0
	total_gpa = 0
	
	def __init__(self,name,gpa):
		self.name = name
		self.gpa = gpa
		Student.count += 1
		Student.total_gpa += gpa

	#INSTANCE METHOD
	def get_info(self):
		return f"{self.name}{self.gpa}"

	@classmethod
	def get_count(cls):
		return f"Total # of student : {cls.count}"

	@classmethod
	def get_average_gpa(cls):
		if cls.count == 0:
			return 0
		else:
			return f"{cls.total_gpa / cls.count:.2f}"

student1 = Student("Spongebob",3.2)
student2 = Student("Patrick", 2.0)
student3 = Student("Sandy",4.0)
print(Student.get_count())
print(Student.get_average_gpa())
```

🔸 What is a **class method**?
- Defined using `@classmethod`
- First parameter is `cls` → refers to the class, not the object
- Used when:
    - You want to access or modify **class-level variables**
    - You want behavior tied to the class, not any one student.

### 🧠 Summary Chart

| Type            | Decorator       | First Argument | Can Access | Belongs To | Used For                     |
| --------------- | --------------- | -------------- | ---------- | ---------- | ---------------------------- |
| Instance Method | _None_          | `self`         | Instance   | Object     | Working with object data     |
| Class Method    | `@classmethod`  | `cls`          | Class      | Class      | Working with class-wide data |
| Static Method   | `@staticmethod` | (none)         | Neither    | Class      | Utility functions            |

## [[🪄 Magic Method]]


##  ⚙️ Property

Decorator used to define a method as property (it can be accessed like an attributes)
Benefits : 
an additional login when read, write, or delete attributes 
Gives you better, setter, and deleter method

```python
class Rectangle:
    def __init__(self, width, height):
        self._width = width
        self._height = height

    @property
    def width(self):
        return f"{self._width:.1f}cm"

    @property
    def height(self):
        return f"{self._height:.1f}cm"

    @width.setter
    def width(self, new_width):
        if new_width > 0:
            self._width = new_width
        else:
            print("Width must be greater than zero")

    @height.setter
    def height(self, new_height):
        if new_height > 0:
            self._height = new_height
        else:
            print("Height must be greater than zero")

    @width.deleter
    def width(self):
        del self._width
        print("Width has been deleted")

    @height.deleter
    def height(self):
        del self._height
        print("Height has been deleted")


# Test the class
rectangle = Rectangle(3, 4)

rectangle.width = 5
rectangle.height = 6
print(rectangle.width)     # 5.0cm
print(rectangle.height)    # 6.0cm

del rectangle.width        # Width has been deleted
del rectangle.height       # Height has been deleted

# These will raise an AttributeError because the properties are deleted:
try:
    print(rectangle.width)
except AttributeError as e:
    print("Error:", e)

try:
    print(rectangle.height)
except AttributeError as e:
    print("Error:", e)

```

## 💐 Decorator

A function that extends the behavior of another function  W/O modifying the base functions
Pass the base function as an argument to the decorator

```python
def add_sprinkles(func):
	def wrapper():
		print("* You add sprinkles ♨️")
		func()
	return wrapper

def add_fudge(func):
	def wrapper():
		print("*You add fudge*🍫")
	return wrapper


@add_sprinkles
@add_fudge
def get_ice_cream():
	print("Here is your ice cream 🍦")

get_ice_cream()
```