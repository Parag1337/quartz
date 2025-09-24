---
title: CSS
---
[[]]
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
# [[CSS Typography, Colors, Border]]

1. CSS Fonts
2. CSS Colors
3. Box Model



4