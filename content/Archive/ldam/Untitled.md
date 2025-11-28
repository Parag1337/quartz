---
title: Untitled
date: 2025-11-20
tags: 
---

---

# ⭐ **SEGMENTATION IN 80386 — COMPLETE NOTES**

---

# 🔵 1. **Descriptor**

A **Descriptor** is an **8-byte entry** that describes a segment.  
It is stored in **GDT** or **LDT**.

### **Descriptor stores:**

- **Base Address (32-bit)** → starting address of segment
    
- **Limit (20-bit)** → size of segment
    
- **Type** (code/data/system)
    
- **DPL (Descriptor Privilege Level)**: 0–3
    
- **Present bit (P)**
    
- **Granularity bit (G)**
    
- **Other control flags**
    

### **Function:**

➡ Provides complete information about a memory segment.

---

# 🔵 2. **GDT (Global Descriptor Table)**

A table located in memory containing descriptors used **system-wide**.

### **Contains:**

- Kernel code segment
    
- Kernel data segment
    
- User code segment
    
- User data segment
    
- System segments (TSS, LDT descriptors)
    
- Video memory descriptor
    
- Other OS-defined segments
    

### **Register:**

- **GDTR** stores base + limit of GDT.
    

### **Function:**

➡ Provides global segments accessible by all programs.

---

# 🔵 3. **LDT (Local Descriptor Table)**

A table containing segment descriptors **specific to one process**.

### **Contains:**

- Process-specific code segment
    
- Process-specific data segment
    
- Process stack segment
    
- Any private memory areas used by the process
    

### **Register:**

- **LDTR** stores base + limit of LDT.
    

### **Function:**

➡ Provides _private_ segments for each process, enabling memory protection.

---

# 🔵 4. **Selector (Segment Selector)**

A **16-bit value** stored in segment registers (CS, DS, SS, ES, FS, GS).  
It is NOT a base address; it **selects** a descriptor.

### **Selector Format:**

```
15            3  2   1  0
--------------------------------
|  Index (13)  | TI | RPL |
--------------------------------
```

### **Fields:**

- **Index (13 bits):** Descriptor number in GDT/LDT
    
- **TI (Table Indicator):**
    
    - 0 → use **GDT**
        
    - 1 → use **LDT**
        
- **RPL (Requested Privilege Level):**
    
    - 0 → highest privilege
        
    - 3 → lowest privilege (user)
        

### **Function:**

➡ Tells CPU **which descriptor** to use to access a segment.

---

# 🔵 5. **Segment Registers**

Store **selectors**, not base addresses.

Registers:

- **CS** – Code Segment
    
- **DS** – Data Segment
    
- **SS** – Stack Segment
    
- **ES**, **FS**, **GS** – Extra Segments
    

### **Function:**

➡ Let the CPU know which segment to use for code, data, stack, etc.

---

# 🔵 6. **Privilege Levels (Protection Rings)**

Privilege levels ensure memory protection.

|Level|Name|Explanation|
|---|---|---|
|**0**|Kernel Mode|Full access|
|**1**|System|Drivers|
|**2**|Supervisor|Reserved|
|**3**|User Mode|Least access|

### **CPU checks:**

```
Max(CPL, RPL) ≤ DPL ?
```

- **CPL** = Current Privilege Level (from CS)
    
- **RPL** = Requested Privilege Level (from selector)
    
- **DPL** = Descriptor Privilege Level (from descriptor)
    

If TRUE → Access allowed  
If FALSE → #GP Fault

---

# 🔵 7. **Segmentation Process (Full Flow)**

1. Program loads selector into CS/DS/SS/ES/FS/GS
    
2. CPU decodes selector:
    
    - Index → descriptor number
        
    - TI → choose GDT or LDT
        
    - RPL → privilege request
        
3. CPU fetches descriptor from table
    
4. Privilege check: `Max(CPL, RPL) ≤ DPL`
    
5. Descriptor gives:
    
    - Base
        
    - Limit
        
    - Type
        
6. CPU forms **Linear Address**:
    
    ```
    Linear Address = Base + Offset
    ```
    
7. If paging ON → linear → physical
    

---

# 🔵 8. **Example of Selector Operation**

Selector = `0x0023`  
→ Index = 4  
→ TI = 0 (GDT)  
→ RPL = 3

CPU fetches **GDT[4]**, the User Data segment descriptor.

If CPL = 3, DPL = 3 → access allowed.

---

# 🔵 9. **Why Segmentation?**

- Memory protection
    
- Multitasking
    
- Separate kernel/user memory
    
- Isolated process memory
    
- Supports virtual memory and paging
    

---

# ⭐ **CRYSTAL CLEAR SUMMARY**

- **Descriptor** = 8-byte definition of a segment.
    
- **GDT** = table of global descriptors.
    
- **LDT** = table of per-process descriptors.
    
- **Selector** = 16-bit pointer to a descriptor.
    
- **Segment registers store selectors**, not base addresses.
    
- **CPU fetches descriptor** using selector.
    
- **Descriptor gives base + limit → forms linear address**.
    
- **Privilege levels ensure protection** (Ring 0–3).
    
- **Segmentation + Paging = Memory safety + Virtual memory**.
    

---

---
---
---


Absolutely — let’s take **ONE SIMPLE EXAMPLE** and I will walk you through EVERYTHING step-by-step:

- **GDT**
    
- **Selector**
    
- **Descriptor Number**
    
- **Descriptor**
    
- **Base + Offset → Linear Address**
    
- **Privilege check**
    

ALL IN ONE FLOW.  
By the end, you will understand segmentation 100%.

---

# ⭐ **REAL EXAMPLE (Very Easy & Clean)**

## 🎯 Step 1: Assume our **GDT** looks like this:

```
GDT (Global Descriptor Table)

Index | Descriptor Name      | Base         | Limit   | DPL
--------------------------------------------------------------
0     | NULL                 | ----         | ----    | -
1     | Kernel Code Segment  | 0x00000000   | 4GB     | 0
2     | Kernel Data Segment  | 0x00000000   | 4GB     | 0
3     | User Code Segment    | 0x00400000   | 1MB     | 3
4     | User Data Segment    | 0x00500000   | 1MB     | 3
5     | Video Memory         | 0x00A00000   | 64KB    | 3
```

THIS is common in operating systems.

---

# ⭐ **Step 2: Program loads a selector into DS**

Let’s say a **user program** wants to access its data segment.

It loads:

```
DS = 0x0023
```

Now decode this selector.

---

# ⭐ **Step 3: Decode Selector (0x0023)**

Selector = 16 bits:

```
Index (13 bits) | TI | RPL
```

Convert 0x0023 to binary:

```
0x0023 = 0000 0000 0010 0011
```

Break into fields:

- Last 2 bits → **RPL** = 11₂ = **3**
    
- Next 1 bit → **TI** = 0 → **Use GDT**
    
- Remaining bits → **Index** = 000 0000 0010 = **4**
    

### ✔ So:

- INDEX = **4**
    
- TI = **0** → Use **GDT**
    
- RPL = **3**
    

---

# ⭐ **Step 4: CPU selects the correct descriptor**

Using:

- TI = 0 → GDT
    
- INDEX = 4 → 4th descriptor
    

So CPU goes to:

```
Descriptor = GDT[4]
```

From our table above:

```
GDT[4] = User Data Segment
Base  = 0x00500000
Limit = 1 MB
DPL   = 3
```

---

# ⭐ **Step 5: Privilege Check**

CPU checks:

```
Max(CPL, RPL) ≤ DPL ?
```

For a user program:

- CPL = 3 (because CS for user code has RPL = 3)
    
- RPL = 3 (from selector)
    
- DPL = 3 (from descriptor)
    

Check:

```
Max(3,3) = 3
3 ≤ 3 → TRUE ✔
```

👉 **Access allowed**  
Because user programs can access user-level data segments.

---

# ⭐ **Step 6: CPU forms the Linear Address**

Assume the instruction used offset:

```
Offset = 0x00001234
```

Linear Address = Base + Offset:

```
0x00500000
+0x00001234
----------------
= 0x00501234  (Linear Address)
```

This is the **final linear address** for the memory access.

---

# ⭐ **Step 7: If paging is ON → Page table → Physical address**

If paging is ON:

```
Linear Address 0x00501234 → Page Table → Physical Address
```

But segmentation part **is already completed**.

---

# 🎉 **COMPLETE SUMMARY OF THE EXAMPLE**

### ✔ Selector = **0x0023**

- INDEX = 4
    
- TI = 0 → GDT
    
- RPL = 3
    

### ✔ CPU goes to **GDT[4]**

Descriptor has:

- Base = 0x00500000
    
- Limit = 1MB
    
- DPL = 3
    

### ✔ Privilege check

Max(CPL, RPL) ≤ DPL → OK

### ✔ Final Address

Linear Address = Base + Offset  
Linear = 0x00500000 + 0x00001234  
Linear = **0x00501234**

---

# ⭐ Would you like one more example

(e.g., what happens when a user program TRIES to access kernel memory and gets denied?)

Or a **diagram** version of this?



---

# ⭐ 1️⃣ Selector chooses _WHICH_ descriptor

Descriptor contains _WHAT_ segment info.

Think of it like this:

### ✔ Selector = _Index / Address of descriptor_

### ✔ Descriptor = _Actual details of the segment_

Selector’s job is _not_ to store a memory address.

Selector’s job is **to choose the descriptor**.

Descriptor’s job is **to store the 32-bit base address**.

--- 