

Subdomain enumeration is a critical part of the **Reconnaissance** phase. It expands the attack surface by identifying non-obvious entry points (e.g., `dev.example.com` or `internal-api.example.com`).

### 1. Certificate Transparency (CT) Logs

When a Certificate Authority (CA) issues an SSL/TLS certificate, the details are published in public **CT Logs**. These logs are an accidental goldmine for pentesters because they record every subdomain a company has ever requested a certificate for—even if that subdomain isn't linked anywhere on their main site.

- **Why it works:** It provides a historical record of subdomains, including those that might be "hidden" from search engines.
    
- **Key Tool:** [crt.sh](https://crt.sh)
    
    - _Pro Tip:_ Use the `%` wildcard in your search (e.g., `%.example.com`) to find all logged subdomains.
        

### 2. Search Engine Discovery (Google Dorking)

Search engines index billions of pages, many of which are subdomains indexed by accident or through old links. We can use **advanced operators** (Google Dorks) to filter out the noise.

- **The Logic:** Exclude the main `www` domain to force the engine to show us the "hidden" ones.
    
- **Syntax Example:**
    
    > `site:*.example.com -site:www.example.com`
    
- **Common Operators:**
    
    - `site:` – Limits results to a specific domain.
        
    - `-` – Excludes specific terms (like the main site).
        
    - `filetype:` – Can help find subdomains hosting specific files (e.g., `filetype:pdf`).
        

---

### 3. Automation Tools

Manual searching is great for precision, but automation is essential for speed and scale. These tools aggregate data from dozens of OSINT sources (CT logs, search engines, social media, etc.) simultaneously.

|**Tool**|**Description**|
|---|---|
|**Sublist3r**|A classic Python tool that aggregates results from many sources like Google, Bing, and DNSdumpster.|
|**Subfinder**|A modern, fast alternative that is part of the ProjectDiscovery ecosystem; known for being highly modular.|
|**Amass**|The "heavyweight" of enumeration; it uses active and passive techniques to map out an entire infrastructure.|

---

### Quick Summary Checklist

- [ ] Search **crt.sh** for historical certificate data.
    
- [ ] Run **Google Dorks** to find indexed but unlinked subdomains.
    
- [ ] Use **Sublist3r** or **Subfinder** to automate the collection process.
    
- [ ] Verify results (ensure the subdomains actually resolve to an IP).