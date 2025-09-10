---
name: Flowchart and Execution
---

[[Lecture 1.pdf]]
# **Flowchart Symbols **

#### **1. Terminator**

- **Use:** Start or end of a program
- **Shape:** Oval
- ![[Pasted image 20250615211414.png|300]]
#### **2. Input/Output**

- **Use:** Take input or show output
- **Shape:** Parallelogram
- ![[Pasted image 20250615211530.png|300]]
#### **3. Process**

- **Use:** Perform calculations or actions
- **Shape:** Rectangle
- ![[Pasted image 20250615211627.png|300]]
#### **4. Decision**

- **Use:** Make a choice (Yes/No)
- **Shape:** Diamond
- ![[Pasted image 20250615211656.png|300]]
#### **5. Connector**

- **Use:** Jump to another point
- **Shape:** Circle
#### **6. Arrow (Flowline)**

- **Use:** Show direction of flow

![[Pasted image 20250615212644.png|440]]


# Execution Of the **C++** Program

```c
.cpp → [Preprocessor] → .i  
// Handles #include, macros, removes comments

.i → [Compiler] → .s  
// Converts code to assembly (checks syntax, generates low-level code)

.s → [Assembler] → .o  
// Converts assembly to machine code (object file)

.o → [Linker] → Executable  
// Links with libraries, produces final runnable file

Executable → Run → Output  
// Executes the program, displays the result
```