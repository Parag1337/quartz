---
name: File Handling in Python
---



## 📁 Python File Detection

Use the `os` module to check if a file or directory exists:

```python
import os

file_path = "file/test.txt"

if os.path.exists(file_path):
    print(f"✅ The location '{file_path}' exists.")
    
    if os.path.isfile(file_path):
        print("📄 It is a file.")
    elif os.path.isdir(file_path):
        print("📁 It is a directory.")
else:
    print("❌ The location does not exist.")
```

> ✅ `os.path.exists(path)` → Checks if the path exists  
> 📄 `os.path.isfile(path)` → Checks if it's a file  
> 📁 `os.path.isdir(path)` → Checks if it's a directory

---

## 📝 Writing to Files

You can write to `.txt`, `.csv`, `.json`, and more using the built-in `open()` function.

### ✍️ Write Mode (`"w"`)

```python
txt_data = "I like Pizza"
file_path = "output.txt"

with open(file_path, "w") as file:
    file.write(txt_data)
    print(f"✅ File '{file_path}' was created (or overwritten).")
```

> `"w"` mode: Writes to the file (overwrites if file exists)

---

### ➕ Append Mode (`"a"`)

```python
with open("output.txt", "a") as file:
    file.write("\nExtra topping: Cheese")
    print("✅ Data appended to the file.")
```

> `"a"` mode: Appends to the file (creates it if it doesn't exist)

---

### ❗ Exclusive Create Mode (`"x"`)

```python
txt_data = "I like Pizza"
file_path = "output.txt"

try:
    with open(file_path, "x") as file:
        file.write(txt_data)
        print(f"✅ File '{file_path}' was created.")
except FileExistsError:
    print("⚠️ That file already exists. Creation aborted.")
```

> `"x"` mode: Creates a new file, but raises `FileExistsError` if it already exists.

---

### 🔒 Why use `with open(...)`?

- Automatically closes the file after the block
- Safer and cleaner than manually using `file.close()`

---

### 📌 Summary of File Modes:

`open(file, mode)` — Short Format
`with` takes care of closing the file

| Mode  | Description                        |
| ----- | ---------------------------------- |
| `"r"` | Read (default)                     |
| `"w"` | Write (overwrites existing file)   |
| `"a"` | Append to existing file            |
| `"x"` | Create file (error if file exists) |
| `"b"` | Binary mode (e.g., `"wb"`, `"rb"`) |
| `"t"` | Text mode (default, optional)      |

---

```python
employees = ["Eugene", "Squidward", "Spongebob", "Patrick"] 

file_path = "output.txt" 
try: 
	with open(file_path, "w") as file: 
	for employee in employees: 
		file.write(employee + " ") 
	print(f"txt file '{file_path}' was created") 
except FileExistsError: 
print("That file already exists!")
```

### **Writing in JSON File**
```python
import json

employee = {
	"name" : "Spongebob",
	"age" : "30",
	"job" : "cook"
}

file_path = "test.json"

try :
	with open(file_path, "w") as file:
		json.dump(employee,file, indent = 4)
		print(f"txt file '{file_path}' was created")
except Exception:
	print("Something went wrong")
```

### **Writing in CSV**
 ```python 
import json
import csv
employee = [["Name","age","Job"],
			["Spongebob",30,"Cook"],
			["Patrick",37,"Unemployed"],
			["Sandy",27,"Scientist"]]

file_path = "test.csv"
try:
	with open(file_path,"w", newline="") as file :
		writer = csv.writer(file)
		for rown in employee:
			writer.writerow(rown)
			print("Done")

except Exception:
	print("Something went wrong")


# We are writing newline="" b/c after every row one line is added
```

## 📖 Reading to the file

Python reading in `.txt`, `.csv`, `.json`

### **Reading the txt file**
```python
file_path = "test.txt"

with open(file_path,"r") as file:
	content  = file.read()
	print(content)
```

### **Reading the JSON File**
```python
import json

file_path = "test.json"

with open(file_path,"r") as file:
	content = json.load(file)
	print(content)
	print(content["name"])

```

### **Reading the CSV File**
```python
import json

file_path = "test.csv"

with open(file_path,"r") as file:
	content = csv.load(file)
	for line in content:
		print(line)     #line[0] for row 1

```

### ✅ Catch All Errors:
```python
try:
    # risky code
except Exception as e:
    print("An error occurred:", e)

```
### 🔍 Explanation:

- `Exception` is the **base class** for most built-in errors in Python.
- `as e` captures the specific error object so you can print or log it.
