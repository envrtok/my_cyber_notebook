**Local File Inclusion (LFI)** is a security vulnerability that allows an attacker to read local files on a server (e.g., `/etc/passwd` on Linux systems). It typically occurs when web applications use functions like `include`, `require`, or `include_once` in PHP without properly validating user input.

Below are the fundamental LFI scenarios, including advanced bypass techniques discovered in lab environments:

### 1. Unrestricted Inclusion

The developer includes user input directly into the function without specifying any directory or extension.

- **Vulnerable Code:** `include($_GET["lang"]);`
    
- **Obstacle:** None. Any file can be accessed starting from the root directory.
    
- **Exploit (Payload):** `?lang=/etc/passwd` (Using an absolute path)
    

### 2. Directory Restriction (Directory Prefix)

The developer forces the application to look for files only within a specific folder (e.g., `languages/`).

- **Vulnerable Code:** `include("languages/" . $_GET['lang']);`
    
- **Obstacle:** The system looks for the input inside the `languages/` folder.
    
- **Exploit (Payload):** `?lang=../../../../etc/passwd` (**Path Traversal**)
    
- **Logic:** Use `../` to navigate out of the restricted directory until you reach the root directory (`/`) to access the target file.
    

### 3. Mandatory File Extension (Suffix) & Null Byte

The developer automatically appends an extension like `.php` to the user's input.

- **Vulnerable Code:** `include("languages/". $_GET['lang'] .".php");`
    
- **Obstacle:** Requesting `/etc/passwd` results in a search for `/etc/passwd.php`.
    
- **Exploit (Payload):** `?lang=../../../../etc/passwd%00` (**Null Byte Bypass**)
    
- **The Twist:** This technique can also be applied to **Cookies**. If the vulnerable parameter is stored in a cookie (e.g., `THM=../../etc/flag2%00`), you can modify it using Browser DevTools or Burp Suite.
    
- **Logic:** `%00` signals the end of a string. It terminates the path before the `.php` is added. _(Fixed in PHP 5.3.4+)_.
    

### 4. Keyword Filtering & HTTP Method Manipulation

The developer filters specific keywords (like `../` or `/etc/passwd`) or limits access based on the HTTP method.

- **Obstacle:** The application blocks `GET` requests containing traversal strings.
    
- **Exploit (Payload):** Change request from `GET` to `POST` + Payload.
    
- **The Twist:** Filters are often applied only to `$_GET` variables. If the backend uses `$_REQUEST` (which accepts both GET and POST), sending the payload via a **POST request** using Burp Suite can bypass the filter entirely.
    
- **Alternative Logic:** Use the "Current Directory Trick": `?lang=../../../../etc/passwd/.` to break exact string matching.
    

### 5. Inadequate Cleaning (Recursive Filter Bypass)

The developer attempts to remove the `../` sequence by replacing it with an empty string (`""`).

- **Obstacle:** The `../` sequence is stripped from the input.
    
- **Exploit (Payload):** `?lang=....//....//....//etc/passwd`
    
- **Logic:** Filters often run only once. When the system removes the "inner" `../`, the remaining characters (`..` + `/`) collapse together to form a new, valid `../` sequence.
    

### 6. Mandatory Prefix Requirement

The application requires the input to start with a specific directory name.

- **Obstacle:** Input not starting with the required prefix (e.g., `languages/`) is rejected.
    
- **Exploit (Payload):** `?lang=languages/../../../../etc/passwd`
    
- **Logic:** Provide the required prefix to satisfy the validation, then immediately use `../` to "back out" of that folder.
    

---

### ⚡ Quick Summary Cheat Sheet

|**Scenario / Obstacle**|**Situation**|**Bypass Technique / Payload**|
|---|---|---|
|**No Restriction**|Can access files directly.|`/etc/passwd`|
|**Directory Restriction**|Restricted to a specific folder.|`../../../../etc/passwd`|
|**Mandatory Extension**|`.php` is appended to input.|`../../../../etc/passwd%00`|
|**Input Source**|Parameter is in a Cookie.|Modify Cookie value in Storage tab.|
|**Method Filtering**|`GET` is filtered/blocked.|Change method to **POST** in Burp Suite.|
|**Keyword Filter**|`etc/passwd` is blacklisted.|`../../../../etc/passwd/.`|
|**Character Stripping**|`../` is deleted by the filter.|`....//....//etc/passwd`|
|**Mandatory Prefix**|Must start with a specific folder.|`folder/../../../../etc/passwd`|