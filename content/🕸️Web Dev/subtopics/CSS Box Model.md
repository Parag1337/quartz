---
name: CSS Box Model
---

Every HTML element is treated as a **box** in CSS. The box model defines how **content**, **padding**, **border**, and **margin** are rendered around an element.  

![[Pasted image 20250821160042.png]]

---

### **Box Model Properties**

### **1. Content**
- The actual text, image, or data inside the element.  
- Controlled by: `width`, `height`, `max-width`, `min-width`, `max-height`, `min-height`.

```css
p {
  width: 300px;
  height: 150px;
}
```

---

### **2. Padding**
- Space **between content and border**.  
- Transparent (takes background color of the element).  

```css
p {
  padding: 20px;                 /* all sides */
  padding: 10px 20px;            /* top/bottom | left/right */
  padding: 5px 10px 15px 20px;   /* top | right | bottom | left */
}
```

---

### **3. Border**
- The edge surrounding the padding & content.  

```css
p {
  border: 2px solid black;  
  border-radius: 10px;          /* rounded corners */
  border-top: 3px dashed red;
  border-left: 5px double blue;
}
```

Common border styles: `solid`, `dashed`, `dotted`, `double`, `groove`, `ridge`, `none`.

---

### **4. Margin**
- Space **outside the border** (transparent).  
- Used for spacing between elements.  

```css
p {
  margin: 20px;                 /* all sides */
  margin: 10px 30px;            /* top/bottom | left/right */
  margin: 5px 10px 15px 20px;   /* top | right | bottom | left */
  margin: auto;                 /* center align (block elements) */
}
```

⚡ **Margin Collapsing**: If two vertical margins meet, only the larger one is applied (not both added).

---

## **Shorthand Summary**

- **Padding / Margin**:  
  - `padding: top right bottom left;`  
  - `margin: top right bottom left;`  
- **Border**:  
  - `border: width style color;` → `border: 2px solid green;`  
- **Border Radius**:  
  - `border-radius: 50%;` → makes a circle/ellipse.  

---
