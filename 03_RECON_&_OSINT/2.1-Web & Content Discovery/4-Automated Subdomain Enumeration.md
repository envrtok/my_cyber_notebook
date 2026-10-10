Subdomain enumeration is the process of identifying valid subdomains for a target domain to expand the attack surface. This often reveals internal staging environments, forgotten dev tools, or hidden login portals.

### 1. DNS Bruteforcing

This method involves querying DNS servers against a predefined wordlist of common subdomain names (e.g., `dev`, `api`, `mail`).

- **Tool:** `dnsrecon`
    
- **Command:**
    

```Bash
dnsrecon -t brt -d acmeitsupport.thm
```

- **Key Flags:**
    
    - `-t brt`: Specifies the enumeration type as **Bruteforce**.
        
    - `-d`: Sets the target **Domain**.
        

---

### 2. Virtual Host (VHost) Enumeration

Unlike DNS enumeration, which looks for records on a nameserver, VHost enumeration identifies multiple websites hosted on the **same IP address**. The web server uses the `Host` header in the HTTP request to determine which site to serve.

- **Tool:** `ffuf` (Fuzz Faster U Fool)
    
- **Basic Fuzzing Command:**
    

```Bash
ffuf -w /usr/share/wordlists/SecLists/Discovery/DNS/namelist.txt -H "Host: FUZZ.acmeitsupport.thm" -u http://10.113.173.131
```

- **Refined Command (Filtering False Positives):**
    
    When a server responds with the same page size for non-existent subdomains, you need to filter those out to see the real hits.
    

```Bash
ffuf -w /usr/share/wordlists/SecLists/Discovery/DNS/namelist.txt -H "Host: FUZZ.acmeitsupport.thm" -u http://10.113.173.131 -fs {size}
```

#### 🛠️ Command Breakdown:

|**Flag**|**Description**|
|---|---|
|`-w`|**Wordlist:** Path to the list of potential subdomains.|
|`-H`|**Header:** We inject the `FUZZ` keyword into the `Host` header.|
|`-u`|**URL:** The target IP address.|
|`-fs`|**Filter Size:** Hides responses of a specific byte size (crucial for ignoring "Not Found" pages that return a `200 OK`).|

---

> **Pro-Tip:** Always start by running a "dummy" request to a subdomain you know doesn't exist (e.g., `random123.target.com`). Note the response size, then use that value with the `-fs` flag to clear the noise!
