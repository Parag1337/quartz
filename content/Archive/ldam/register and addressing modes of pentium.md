---
title: Untitled 1
date: 2025-11-21
tags: 
---
Here is a **clean, exam-oriented, easy-to-understand** explanation of:

# ⭐ 1. **Register Set of Pentium**

# ⭐ 2. **Addressing Modes of Pentium**

These notes are perfect for Unit-5 of your syllabus.

---

# ⭐ **1. REGISTER SET OF PENTIUM**

(Programmer-visible registers)

Pentium is fully backward compatible with 8086, 80286, 80386, and 80486.

So its **register set is identical to 80386**, but with some extensions.

Let’s list them clearly.

---

# 🔵 **A) General Purpose Registers (GPRs) - 32-bit**

These 8 registers can be used for arithmetic, logic, addressing, and data movement.

| 32-bit  | 16-bit | 8-bit  |
| ------- | ------ | ------ |
| **EAX** | AX     | AH, AL |
| **EBX** | BX     | BH, BL |
| **ECX** | CX     | CH, CL |
| **EDX** | DX     | DH, DL |
| **ESI** | SI     | –      |
| **EDI** | DI     | –      |
| **EBP** | BP     | –      |
| **ESP** | SP     | –      |

### Special uses:

- **EAX** = Accumulator (mul, div, I/O)
    
- **ECX** = Counter (loops, shifts)
    
- **EDX** = High word for multiply/div; I/O port address
    
- **ESI/EDI** = String operations
    
- **EBP** = Stack frame base
    
- **ESP** = Stack pointer
    

---

# 🔵 **B) Segment Registers (16-bit Selectors)**

Pentium uses the same segmentation mechanism as 80386.

Segment registers store **selectors**, not base addresses.

Registers:

- **CS** → Code segment
    
- **DS** → Data segment
    
- **SS** → Stack segment
    
- **ES**, **FS**, **GS** → Extra segments (point to descriptors)
    

These refer to descriptors in GDT/LDT.

---

# 🔵 **C) Instruction Pointer**

- **EIP** → 32-bit instruction pointer
- Combined with CS → Logical Address CS:EIP
    

Shows the linear address of the next instruction.

---

# 🔵 **D) EFLAGS Register (32-bit)**

Holds condition flags, control flags, and system flags.

### Status Flags:

- CF (Carry)
    
- ZF (Zero)
    
- SF (Sign)
    
- OF (Overflow)
    
- PF (Parity)
    
- AF (Aux Carry)
    

### Control Flags:

- IF (Interrupt Enable)
    
- DF (Direction)
    
- TF (Trap)
    
- IOPL (I/O Privilege Level)
    

### System Flags:

- VM (Virtual 8086 mode)
    
- RF (Resume)
    
- VIF/VIP (Virtual interrupts)
    
- ID (CPUID support)
    

---

# 🔵 **E) Control Registers (CR0–CR4)**

Used for mode switching, paging, protection.

- **CR0** → Enables protected mode, paging
    
- **CR2** → Page-fault linear address
    
- **CR3** → Page Directory Base (root of paging system)
    
- **CR4** → Extra features (page size extension, VME, PAE, etc.)
    

---

# 🔵 **F) Debug Registers (DR0–DR7)**

Used for hardware breakpoints (debugging).

---

# 🔵 **G) Test Registers (TR6–TR7)**

(Not used by programmers; used for testing cache/TLB.)

---

# 🔵 **H) Floating-Point & MMX Registers**

(If Pentium MMX or with FPU)

- **MM0–MM7** (64-bit) for MMX
    
- **ST0–ST7** (FPU stack registers, 80-bit)
    

---

# ⭐ **SUMMARY OF PENTIUM REGISTER SET**

Pentium supports the same programmer-visible register model as 80386 PLUS:

- EFLAGS extensions
    
- CR4
    
- Debug registers
    
- MMX/FPU registers (in versions that support them)
    

---

# ⭐ 2. ADDRESSING MODES OF PENTIUM

Pentium uses **all 80386 addressing modes** and adds support for **scaled indexing**, making it very powerful.

Addressing modes specify **how the effective address is computed**.

Pentium has the following addressing modes:

---

# 🔵 **A) Immediate Addressing**

Value is inside the instruction.

```
MOV EAX, 10
ADD EBX, 0x1234ABCD
```

---

# 🔵 **B) Register Addressing**

Operand is in a register.

```
MOV EAX, EBX
INC ECX
```

---

# 🔵 **C) Direct Memory Addressing**

Instruction contains a 32-bit address.

```
MOV EAX, [0x00405000]
```

---

# 🔵 **D) Register Indirect Addressing**

Memory address = Contents of a register

```
MOV EAX, [EBX]
MOV BYTE PTR [EDI], AL
```

---

# 🔵 **E) Based Addressing**

Uses Base Register + Displacement

```
MOV EAX, [EBP + 4]
MOV EDX, [EBX + 100]
```

---

# 🔵 **F) Indexed Addressing**

Uses Index register + displacement

```
MOV EAX, [ESI + 2]
MOV EBX, [EDI + 8]
```

---

# 🔵 **G) Based Indexed Addressing**

Two registers: Base + Index

```
MOV EAX, [EBX + ESI]
```

---

# 🔵 **H) Based Indexed with Displacement**

Base + Index + Constant

```
MOV EAX, [EBX + ESI + 16]
```

---

# 🔵 **I) Scaled Indexed Addressing (VERY IMPORTANT for Pentium)**

Index register can be multiplied by:

- 1
    
- 2
    
- 4
    
- 8
    

Pentium introduced **scaling** of index values for array access.

Effective Address:

```
Base + (Index * Scale) + Displacement
```

Example:

```
MOV EAX, [EBX + ESI*4]     ; array of dwords
MOV EDX, [EDI + ECX*8 + 12]
```

**Scale factor** is useful for:

- int arrays (4 bytes)
    
- long long arrays (8 bytes)
    
- structures
    
- matrices
    

---

# ⭐ **Summary of Addressing Modes (Remember these 9 types)**

1. Immediate
    
2. Register
    
3. Direct memory
    
4. Register indirect
    
5. Based
    
6. Indexed
    
7. Based indexed
    
8. Based indexed + displacement
    
9. **Scaled indexed (Pentium-specific enhancement)**
    

---

# ⭐ Final Quick Revision (for exam viva)

**Register Set:**  
Pentium has 32-bit general registers (EAX–EDI), segment registers (CS–GS), EIP, EFLAGS, control registers (CR0–CR4), debug registers, and FPU/MMX registers.

**Addressing Modes:**  
Pentium supports all 80386 modes PLUS scaled indexing, allowing:

```
EA = Base + Index*Scale + Displacement
```

---

If you want, I can provide **diagrams**, **practice examples**, or a **one-sheet summary** for both topics.
