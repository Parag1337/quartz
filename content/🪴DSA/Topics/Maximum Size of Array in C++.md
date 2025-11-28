---
title: Maximum Size of Array in C++
date: 2025-11-28
tags: 
---

### ✔Inside main (local array)

Local arrays are stored **on stack memory**.

👉 Typical stack size = **8 MB**

You can safely allocate around:

```
2 × 10^6 integers (~2 million)
```

Because:

```
1 int = 4 bytes
2,000,000 ints ≈ 8 MB
```

If you exceed this → **stack overflow error**.

### ✔ Global array

Global arrays are stored in **global/static memory**, which is much larger.

You can allocate:

```
10^7 integers (10 million) safely
```

Some compilers allow up to:

```
2 × 10^8 ints (200 million)
```

But safe limit = **10 million ints**.

---
