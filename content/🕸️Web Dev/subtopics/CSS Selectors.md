---
name: CSS Selectors
---

### **1. Element Selector**

Targets all elements of that type.

```css
h1 { color: red; }
p { font-size: 16px; }
```

### **2. ID Selector**

Unique for each element (use `#`).

```html
<p id="design1">This is styled with ID</p>
```

```css
#design1 { color: green; }
```

### **3. Class Selector**

Reusable across many elements (use `.`).

```html
<p class="highlight">First</p>
<p class="highlight">Second</p>
```

```css
.highlight { background: yellow; }
```

### **4. Grouping Selector**

Style multiple selectors together with `,`.

```css
h1, h2, p { font-family: Arial; }
```

### **5. Universal Selector**

Applies to all elements (`*`).

```css
* { margin: 0; padding: 0; }
```

### **6. Descendant Selector**

Styles elements inside another element.

```css
div p { color: blue; }
```

### **7. Child Selector**

Styles direct children only.

```css
div > p { color: red; }
```

### **8. Pseudo-classes (special states)**

```css
a:hover { color: orange; }   /* when mouse hovers */
input:focus { border: 2px solid green; }
```

### **9. Pseudo-elements**

```css
p::first-letter { font-size: 24px; }
p::before { content: "👉 "; }
```

---
