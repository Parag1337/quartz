---
title: HTML
---

## **Basic HTML Structure**

```html
<!DOCTYPE html>   <!-- Declares HTML5 -->
<html>
  <head>
    <title>Page Title</title>
  </head>
  <body>
    Page content here
  </body>
</html>
```

**Notes:**

- `<!DOCTYPE html>` → Tells browser to use HTML5.
- `<html>` → Root element of the page.
- `<head>` → Page info (title, metadata, styles, scripts).
- `<title>` → Text shown in browser tab.
- `<body>` → Main visible content.

---

## **Basic Tags**

- **Headings** → `<h1>` to `<h6>` (largest to smallest).
- **Paragraph** → `<p>` (normal text block).
- **Line Break** → `<br>` (break without new paragraph).
- **Horizontal Line** → `<hr>` (divider line).
- **Preformatted Text** → `<pre>` (keeps spaces & line breaks).
- **Bold Text** → `<b>` (bold), `<strong>` (bold + important).
- **Italic Text** → `<i>` (italic), `<em>` (italic + important).
- **Underline** → `<u>`.
- **Comments** → `<!-- text -->` (ignored by browser).
- **Button** → `<button></button>` (creates the button)

---

### **1. `<img>` Tag**

Used to display images in an HTML document.

**Syntax:**

```html
<img src="path/image.jpg" alt="Description" width="300" height="200">
```

**Important Attributes:**

| Attribute | Description                                                   | Example           |
| --------- | ------------------------------------------------------------- | ----------------- |
| `src`     | Path to the image file.                                       | `src="photo.jpg"` |
| `alt`     | Alternate text if image cannot be displayed.                  | `alt="A cat"`     |
| `width`   | Width of the image (in px or %).                              | `width="300"`     |
| `height`  | Height of the image (in px or %).                             | `height="200"`    |
| `loading` | Lazy loading to improve performance. Values: `lazy`, `eager`. | `loading="lazy"`  |

---

### **2. `<audio>` Tag**

Used to embed audio files in a webpage.

**Syntax:**

```html
<audio controls autoplay loop muted>
    <source src="audio.mp3" type="audio/mpeg">
    <source src="audio.ogg" type="audio/ogg">
    Your browser does not support the audio element.
</audio>
```

**Important Attributes:**

| Attribute  | Description                                                  | Example                           |
| ---------- | ------------------------------------------------------------ | --------------------------------- |
| `controls` | Shows play/pause, volume controls, etc.                      | `<audio controls>`                |
| `autoplay` | Starts playing audio automatically (often requires `muted`). | `<audio autoplay muted>`          |
| `loop`     | Replays the audio continuously.                              | `<audio loop>`                    |
| `muted`    | Starts audio with sound off.                                 | `<audio muted>`                   |
| `preload`  | Hints browser about loading: `auto`, `metadata`, `none`.     | `<audio preload="metadata">`      |
| `src`      | Directly set audio file source.                              | `<audio src="song.mp3" controls>` |
| `type`     | Defines audio file MIME type.                                | `type="audio/mpeg"`               |

---

### **3. `<video>` Tag**

Used to embed video files in a webpage.

**Syntax:**

```html
<video controls autoplay muted loop width="640" height="360" poster="thumbnail.jpg">
    <source src="video.mp4" type="video/mp4">
    <source src="video.webm" type="video/webm">
    Your browser does not support the video element.
</video>
```

**Important Attributes:**

| Attribute          | Description                                                | Example                           |
| ------------------ | ---------------------------------------------------------- | --------------------------------- |
| `controls`         | Shows video controls like play, pause, volume, fullscreen. | `<video controls>`                |
| `autoplay`         | Starts playing automatically (often needs `muted`).        | `<video autoplay muted>`          |
| `muted`            | Starts video without sound.                                | `<video muted>`                   |
| `loop`             | Restarts video after it ends.                              | `<video loop>`                    |
| `poster`           | Image displayed before video plays.                        | `poster="thumbnail.jpg"`          |
| `preload`          | Hints how much to preload: `auto`, `metadata`, `none`.     | `<video preload="auto">`          |
| `width` & `height` | Sets video display size.                                   | `width="640"`                     |
| `src`              | Directly set video source.                                 | `<video src="clip.mp4" controls>` |
| `type`             | Defines video MIME type.                                   | `type="video/mp4"`                |

---

## **4. `<a>` Tag (Anchor)**

- **Purpose:** Creates hyperlinks.
- **Common Attributes:**

| Attribute  | Description                                                    | Example                                   |
| ---------- | -------------------------------------------------------------- | ----------------------------------------- |
| `href`     | Link URL or location.                                          | `<a href="page.html">`                    |
| `target`   | Where to open the link (`_blank`, `_self`, `_parent`, `_top`). | `<a href="page.html" target="_blank">`    |
| `title`    | Tooltip text.                                                  | `<a href="page.html" title="Go to page">` |
| `download` | Downloads linked file instead of opening.                      | `<a href="file.pdf" download>`            |
| `rel`      | Relationship to linked document (`nofollow`, `noopener`).      | `<a href="page.html" rel="noopener">`     |
| `type`     | MIME type of the linked content.                               | `<a href="video.mp4" type="video/mp4">`   |



## **5. Text Formatting Tags**

- `<b>` → Bold text
- `<i>` → Italic text
- `<u>` → Underlined text
- `<del>` → Deleted / Strikethrough text
- `<big>` → Bigger text (not much used now)
- `<small>` → Smaller text
- `<sub>` → Subscript (e.g., H2O → H₂O)
- `<sup>` → Superscript (e.g., 22 → 2²)
- `<tt>` / `<code>` → Monospace font (typewriter style, often used for code)
- `<mark>` → Highlighted text (yellow by default)

---

## **6. `<span>` vs `<div>`**

- **`<span>`** → Inline container, used to style part of text (does not break line).
- **`<div>`** → Block-level container, used to group large sections (starts on a new line).

👉 **Block-level** → takes full width (e.g., `<div>`, `<p>`, `<h1>`).  
👉 **Inline** → takes only as much space as needed (e.g., `<span>`, `<a>`, `<b>`).

---

## **7. Lists**

### 1. Ordered List (`<ol>`)

- Creates **numbered list**.
- **Attributes:**
    - `type` → numbering style (`1, A, a, I, i`)
    - `start` → starting number (e.g., `<ol start="5">`
    - `reversed` → reverse order        

Example:

```html
<ol type="A" start="3">
  <li>Item 1</li>
  <li>Item 2</li>
</ol>
```

### 2. Unordered List (`<ul>`)

- Creates **bulleted list**.
    
- **Attributes:**
    - `type` (deprecated, but works) → `disc`, `circle`, `square`

Example:

```html
<ul type="square">
  <li>Item A</li>
  <li>Item B</li>
</ul>
```

### 3. Nested List

- A list inside another list.

Example:

```html
<ul>
  <li>Fruit
    <ul>
      <li>Apple</li>
      <li>Mango</li>
    </ul>
  </li>
</ul>
```

### 4. Description List (`<dl>`)

- Used for terms and definitions.
    

```html
<dl>
  <dt>HTML</dt>   <!-- Term -->
  <dd>HyperText Markup Language</dd> <!-- Definition -->
</dl>
```

---

## **8. Table Basics**

- `<table>` → Creates a table.
- `<tr>` → Table row.
- `<td>` → Table data (cell).
- `<th>` → Table header (bold + centered by default).
- `<caption>` → Table title (optional).

---

### **Simple Table Example**

```html
<table border="1">
  <caption>Student Data</caption>
  <tr>
    <th>Name</th>
    <th>Roll No</th>
    <th>Marks</th>
  </tr>
  <tr>
    <td>Parag</td>
    <td>101</td>
    <td>95</td>
  </tr>
  <tr>
    <td>Dhanashree</td>
    <td>102</td>
    <td>90</td>
  </tr>
</table>
```

👉 This makes a table with 2 rows of data + headings.

---

### **Table Attributes**

- `border="1"` → Adds border (old way, better use CSS).
- `cellpadding` → Space inside cell.
- `cellspacing` → Space between cells.
- `align` → Align table (left, center, right).
- `width` → Width of table.

---

### **Row/Column Spanning**

- `rowspan="n"` → Merge cells vertically.
- `colspan="n"` → Merge cells horizontally.

Example:

```html
<table border="1">
  <tr>
    <th rowspan="2">Name</th>
    <th colspan="2">Marks</th>
  </tr>
  <tr>
    <td>Math</td>
    <td>Science</td>
  </tr>
  <tr>
    <td>Parag</td>
    <td>90</td>
    <td>85</td>
  </tr>
</table>
```

---

## 📝 9. ![[HTML Forms – Complete Notes]]

## **10. Header And footer**


```html
<!DOCTYPE html>
<html>
<head>
  <title>Header & Footer Example</title>
</head>
<body>

  <!-- Header Section -->
  <header style="background-color: lightblue; padding: 10px;">
    <h1>My Website</h1>
    <nav>
      <a href="#home">Home</a> |
      <a href="#about">About</a> |
      <a href="#contact">Contact</a>
    </nav>
  </header>

  <!-- Main Content -->
  <main>
    <h2>Welcome to my site!</h2>
    <p>This is the main content area.</p>
  </main>

  <!-- Footer Section -->
  <footer style="background-color: lightgray; padding: 10px; text-align: center;">
    <p>&copy; 2025 MyWebsite. All rights reserved.</p>
    <p>Contact: myemail@example.com</p>
  </footer>

</body>
</html>
```

 `<nav>`, `<main>`, `<article>`, `<section>`, `<aside>`

---


## 📑 **1. Iframes (`<iframe>`)**

👉 Embeds another webpage, video, map, or document inside your page.

### Syntax:

```html
<iframe src="https://www.wikipedia.org" width="600" height="400"></iframe>
```

### Important Attributes:

- `src` → URL of page to embed.
- `width`, `height` → size of frame.
- `name` → can be targeted by links (`target="framename"`).
- `frameborder="0"` → removes border (deprecated, use CSS).
- `allowfullscreen` → allows fullscreen (for videos/maps).
- `loading="lazy"` → loads only when visible (performance).

### Example: Embedding YouTube Video

```html
<iframe width="560" height="315" 
src="https://www.youtube.com/embed/dQw4w9WgXcQ" 
title="YouTube video player" frameborder="0" 
allowfullscreen>
</iframe>
```

---

## 📑 **2. Semantic Tags (HTML5)**

👉 Tags that **describe meaning** of content, not just style. Improves SEO & accessibility.

| Tag            | Use                                      |
| -------------- | ---------------------------------------- |
| `<header>`     | Top section (logo, title, nav)           |
| `<footer>`     | Bottom section (contact, copyright)      |
| `<nav>`        | Navigation links/menu                    |
| `<main>`       | Main content of page                     |
| `<section>`    | Groups related content                   |
| `<article>`    | Independent piece (blog, news, post)     |
| `<aside>`      | Sidebar, ads, extra info                 |
| `<figure>`     | Media element (image, chart, code block) |
| `<figcaption>` | Caption for figure                       |
| `<time>`       | Machine-readable time/date               |
| `<mark>`       | Highlight text                           |
| `<address>`    | Contact details                          |

### Example:

```html
<header>
  <h1>My Blog</h1>
  <nav>
    <a href="#home">Home</a> | 
    <a href="#about">About</a>
  </nav>
</header>

<main>
  <article>
    <h2>Post Title</h2>
    <p>This is a blog post.</p>
  </article>

  <aside>
    <h3>Related Links</h3>
    <p>Sidebar content here.</p>
  </aside>
</main>

<footer>
  <p>&copy; 2025 My Blog</p>
</footer>
```

---

## 📑 **3. Meta Tags (`<meta>`)**

👉 Placed inside `<head>`, used for **SEO, responsiveness, and page info**.

### Common Meta Tags:

```html
<meta charset="UTF-8"> <!-- Character encoding -->
<meta name="viewport" content="width=device-width, initial-scale=1.0"> <!-- Mobile friendly -->
<meta name="description" content="Free HTML Notes for Beginners"> <!-- SEO -->
<meta name="keywords" content="HTML, CSS, JavaScript, Web Development"> <!-- SEO -->
<meta name="author" content="Parag Panzade">
<meta http-equiv="refresh" content="30"> <!-- Refresh page every 30s -->
```
 

---

## 📑 **5. Other Useful Elements**

#### A) Collapsible Content

```html
<details>
  <summary>Click to Expand</summary>
  <p>Hidden content revealed!</p>
</details>
```

#### B) Progress Bar

```html
<progress value="70" max="100"></progress>
```

Shows progress (e.g., downloads).

#### C) Meter (Measurement Gauge)

```html
<meter value="0.7" min="0" max="1">70%</meter>
```

Displays measurement within range (like disk usage).

#### D) Abbreviation

```html
<p>The <abbr title="World Health Organization">WHO</abbr> was founded in 1948.</p>
```

#### E) Address

```html
<address>
  Written by Parag Panzade<br>
  Visit us at: www.mywebsite.com
</address>
```

#### F) Special Characters (Entities)

```html
&lt;  → <  
&gt;  → >  
&nbsp; → space  
&copy; → ©  
&hearts; → ♥  
```

---