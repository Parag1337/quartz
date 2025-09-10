---
name: HTML Forms – Complete Notes
---

## 1. **Form Basics**
- `<form>` → Creates a form for user input.  
  - Attributes:  
    - `action="url"` → where form data goes.  
    - `method="get/post"` → how data is sent.  

```html
<form action="/submit" method="post">
   <!-- form fields go here -->
</form>
```

---

## 2. **Label**
- `<label>` → Label for input (clicking it focuses input).  
- Attribute: `for="id_of_input"`  

```html
<label for="username">Username:</label>
<input type="text" id="username" name="username">
```

---

## 3. **Input Types**

#### 🔹 Text Input
```html
<input type="text" id="name" name="name" placeholder="Enter your name" minlength="3" maxlength="20">
```
- Attributes:  
  - `id` → unique identifier.  
  - `minlength` / `maxlength` → input length limits.  
  - `placeholder` → hint text.  
#### 🔹Password
```html
<input type="password" id="pass" name="pass" minlength="6" maxlength="12">
```
#### 🔹Date
```html
<input type="date" id="dob" name="dob">
```
#### 🔹Radio Button
```html
<input type="radio" id="male" name="gender" value="male">
<label for="male">Male</label>

<input type="radio" id="female" name="gender" value="female">
<label for="female">Female</label>
```
Only **one option selectable** per group (`same name`).  

#### 🔹File Upload
```html
<input type="file" name="document" accept=".png, .jpeg, .pdf">
```
 `accept` = restrict file types.  

#### Submit & Reset
```html
<input type="submit" value="Submit">
<input type="reset" value="Reset">
```

---
## 4. **Select (Dropdown)**
```html
<label for="course">Choose Course:</label>
<select id="course" name="course">
  <option value="html">HTML</option>
  <option value="css">CSS</option>
  <option value="js">JavaScript</option>
</select>
```
 `multiple` attribute allows selecting multiple items.  

---
## 5. **Textarea (Multi-line Input)**
```html
<label for="msg">Your Message:</label><br>
<textarea id="msg" name="msg" rows="4" cols="40" placeholder="Type here..."></textarea>
```
---
## 6. **Extra Useful Input Types**
- `email` → `<input type="email">` (validates email format).  
- `number` → `<input type="number" min="1" max="100">`  
- `checkbox` → `<input type="checkbox">` (multiple selections).  
- `color` → `<input type="color">` (color picker).  
- `range` → `<input type="range" min="0" max="100">` (slider).  
- `url` → `<input type="url">` (validates URL).  
- `tel` → `<input type="tel" pattern="[0-9]{10}">` (phone number).  

---

✅ **Summary**  
- **Form container** → `<form>` with `action`, `method`.  
- **Inputs** → text, password, date, radio, checkbox, file, email, number, etc.  
- **Attributes** → `id`, `name`, `placeholder`, `minlength`, `maxlength`, `accept`.  
- **Buttons** → `submit`, `reset`.  
- **Select/option** → dropdown.  
- **Textarea** → multi-line input.  


## [[Table code]]