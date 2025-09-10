---
name: CSS (1)
---


# **Preference (CSS Specificity Order)**

1. **Inline CSS** → `<p style="color:red;">` (Highest priority)
2. **Internal CSS** → inside `<style>...</style>` in `<head>`.
3. **External CSS** → linked with `<link>` tag.
4. **Browser defaults** → lowest priority.

✅ If multiple rules conflict:

- **Inline > Internal > External** (unless overridden).    
- `!important` increases priority (even beats inline).


---

# Internal & External CSS

- **Internal CSS** → write inside `<style>` tag in the `<head>` section.


```html
<style>
  p { color: blue; }
</style>
```

- **External CSS** → link a separate file (`style.css`).  

```html
<link rel="stylesheet" href="style.css">
```

---

# **[[CSS Selectors]]

Things Included :
	1. Element Selector
	2. ID Selector
	3. Class Selector
	4. Grouping Selector
	5. Universal Selector
	6. Descendant Selector
	7. Child Selector
	8. Pseudo-Class
	9. Pseudo-elements

---

# **CSS Typography, Colors, Border**

## 1. CSS Fonts

```css
p {
  font-size: 20px;
  font-family: "Arial", sans-serif;
  font-style: italic;
  font-weight: bold;
  line-height: 1.5;
  letter-spacing: 2px;
  word-spacing: 5px;
  text-transform: uppercase;
}
```

### Common Font Properties

- **`font-size`** → sets text size (`px`, `em`, `%`, `rem`).
- **`font-family`** → sets the font (always use fallback fonts).  
    Example: `"Times New Roman", serif` or `"Roboto", sans-serif`.
- **`font-style`** → normal | italic | oblique.
- **`font-weight`** → normal | bold | 100–900 (thin to extra-bold).
- **`line-height`** → vertical spacing between lines (e.g., `1.5`).
- **`letter-spacing`** → spacing between letters.
- **`word-spacing`** → spacing between words.
- **`text-transform`** → uppercase | lowercase | capitalize.
- **`text-decoration`** → underline | overline | line-through | none.
- **`font-variant`** → small-caps (rarely used).

👉 Shorthand example:

```css
p {
  font: italic small-caps bold 18px/1.6 "Georgia", serif;
}
```

---

## 2. CSS Colors

You can define **colors** in multiple ways:

```css
#firstpage {
  background-color: yellow;              /* Named color */
}
#secondpara {
  background-color: rgb(100, 109, 102);  /* RGB */
}
#thirdpara {
  background-color: rgba(66, 245, 25, 0.5); /* RGBA → includes alpha (transparency) */
}
#fourthpara {
  background-color: #ffab23;             /* Hexadecimal color */
}
#fifthpara {
  background-color: hsl(0, 100%, 50%);   /* HSL → Hue, Saturation, Lightness */
}
#sixthpara {
  background-color: hsla(200, 70%, 40%, 0.7); /* HSLA with transparency */
}
```

### Common Color Properties

- **`color`** → text color.
- **`background-color`** → background fill color.
- **`border-color`** → border color.
- **`outline-color`** → outline color.
- **`opacity`** → makes entire element transparent (`0` = invisible, `1` = solid).

---
Nice Parag 👌 you’re building really solid notes!  
I’ll **clean this up**, fix typos, expand with **shorthand examples**, and add missing **important points** about the **CSS Box Model**.  

---

## 3. [[CSS Box Model]]

![[Pasted image 20250821160042.png]]

