When performing a brute-force or credential-stuffing attack with multiple variables (e.g., both username and password), `ffuf` requires custom keywords to map specific wordlists to specific fields.

### The Command

``` bash
ffuf -w valid_usernames.txt:W1,/usr/share/wordlists/SecLists/Passwords/Common-Credentials/xato-net-10-million-passwords-10000.txt:W2 \
     -X POST -d "username=W1&password=W2" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -u http://10.114.164.165/customers/login \
     -fc 200
```

---

### Parameter Breakdown

|**Flag**|**Purpose**|
|---|---|
|`-w`|**Wordlist:** Defines the lists. Note the format `path:KEYWORD`. `W1` is usernames, `W2` is passwords.|
|`-X POST`|**Request Method:** Specifies a POST request (standard for login forms).|
|`-d`|**Data:** The POST body. Here, we inject `W1` and `W2` into their respective parameters.|
|`-H`|**Header:** Sets the Content-Type so the server knows how to parse the POST data.|
|`-u`|**URL:** The target login endpoint.|
|`-fc 200`|**Filter Code:** Tells `ffuf` to **hide** responses with a `200 OK` status (assuming a failed login returns 200 and a success redirects or errors).|

---

### Key Concept: Custom Fuzzing Keywords

Standard `ffuf` commands use the `FUZZ` keyword by default. However, when using **multiple wordlists**, you must define unique identifiers (like `W1`, `W2`, or `USER`, `PASS`) to tell the tool exactly which list belongs in which part of the request.

> **Note on Attack Modes:**
> 
> By default, `ffuf` uses the **clusterbomb** mode when multiple wordlists are provided. This means it will try _every_ password in `W2` for _every_ username in `W1` (an $N \times M$ operation). If you wanted to try them in pairs (User1:Pass1, User2:Pass2), you would add `-mode pitchfork`.