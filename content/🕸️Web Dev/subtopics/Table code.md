---
title: Table code
---

## **Complete Form Example (registration style)**

```html
<!DOCTYPE html>
<html>
<head>
  <title>Registration Form</title>
</head>
<body>
  <h2>Registration Form</h2>

  <form action="/submit" method="post">
    
    <!-- Text Input -->
    <label for="username">Username:</label>
    <input type="text" id="username" name="username" placeholder="Enter username" minlength="3" maxlength="20" required>
    <br><br>

    <!-- Password -->
    <label for="pass">Password:</label>
    <input type="password" id="pass" name="pass" minlength="6" maxlength="12" required>
    <br><br>

    <!-- Email -->
    <label for="email">Email:</label>
    <input type="email" id="email" name="email" placeholder="example@mail.com" required>
    <br><br>

    <!-- Number -->
    <label for="age">Age:</label>
    <input type="number" id="age" name="age" min="18" max="100">
    <br><br>

    <!-- Date -->
    <label for="dob">Date of Birth:</label>
    <input type="date" id="dob" name="dob">
    <br><br>

    <!-- Gender (Radio) -->
    Gender:
    <input type="radio" id="male" name="gender" value="male">
    <label for="male">Male</label>
    <input type="radio" id="female" name="gender" value="female">
    <label for="female">Female</label>
    <br><br>

    <!-- Hobbies (Checkbox) -->
    Hobbies:<br>
    <input type="checkbox" id="reading" name="hobby" value="reading">
    <label for="reading">Reading</label>
    <input type="checkbox" id="sports" name="hobby" value="sports">
    <label for="sports">Sports</label>
    <input type="checkbox" id="music" name="hobby" value="music">
    <label for="music">Music</label>
    <br><br>

    <!-- File Upload -->
    <label for="file">Upload Document:</label>
    <input type="file" id="file" name="document" accept=".png, .jpeg, .pdf">
    <br><br>

    <!-- Select Dropdown -->
    <label for="course">Select Course:</label>
    <select id="course" name="course">
      <option value="html">HTML</option>
      <option value="css">CSS</option>
      <option value="js">JavaScript</option>
    </select>
    <br><br>

    <!-- Range -->
    <label for="satisfaction">Satisfaction Level:</label>
    <input type="range" id="satisfaction" name="satisfaction" min="0" max="10">
    <br><br>

    <!-- Color Picker -->
    <label for="favcolor">Favorite Color:</label>
    <input type="color" id="favcolor" name="favcolor">
    <br><br>

    <!-- Textarea -->
    <label for="msg">Message:</label><br>
    <textarea id="msg" name="msg" rows="4" cols="40" placeholder="Write something..."></textarea>
    <br><br>

    <!-- Submit & Reset -->
    <input type="submit" value="Submit">
    <input type="reset" value="Reset">

  </form>
</body>
</html>
```

---

✅ This file includes:  
✔ Text, password, email, number, date  
✔ Radio, checkbox, file upload  
✔ Select dropdown, range, color  
✔ Textarea  
✔ Submit & reset buttons