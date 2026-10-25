

### 1. Advanced Search (Google Dorking)

- **Subdomain Discovery:** `site:*.target.com -www`
    
      
    
- **Sensitive Files:** `site:target.com filetype:env OR filetype:conf`
    
      
    
- **Login Pages:** `site:target.com inurl:login | admin`
    
      
    

### 2. Entity Harvesting (theHarvester)

- **What it finds:** Emails, names, subdomains, IP addresses, and open ports via Shodan.
    
      
    
- **The Goal:** Build a target list for social engineering (phishing) or identify "forgotten" subdomains that search engines missed.
    
      
    
- **Quick Command:**
    
      
    
    ```bash
    theHarvester -d target.com -l 500 -b google,bing,linkedin,shodan
    ```
    
    _(Searches 500 results across Google, Bing, LinkedIn, and Shodan)_
    
      
    

### 3. Passive DNS Reconnaissance (DNSDumpster) 

- **What it finds:** Subdomains, DNS records (A, MX, NS, TXT), hosting providers, and visual network topology maps.
    
      
    
- **The Goal:** Quickly discover an organization’s attack surface and mapped infrastructure without sending traffic directly to the target servers.
    
      
    

### 4. Internet-Connected Device Search (Shodan.io) 

- **What it finds:** Open ports, service banners, operating systems, webcams, industrial control systems, and unpatched servers.
    
      
    
- **The Goal:** Search for specific IP ranges, SSL certificates, or HTTP headers to identify exposed endpoints, default credentials, or vulnerable software versions.
    
      
    
- **Useful Dorks:**
    
      
    - `hostname:target.com`
        
          
        
    - `ssl:"target.com"`
        
          
        
    - `org:"Organization Name"`
        
          
        

### 5. Tech Stack Profiling (Wappalyzer)

- **What to look for:** CMS (WordPress), Web Server (Nginx), and JavaScript Frameworks.
    
      
    
- **Strategy:** Identify version numbers. Outdated frameworks (like jQuery 1.12) are instant red flags.
    
      
    

### 6. Historical Data (Web Archive / Wayback Machine)

- **The Goal:** Find old endpoints or deleted "coming soon" pages that might still be active on the server.
    
      
    
- **Pro Tip:** Look for old `/robots.txt` files; they often list directories the company used to want hidden.
    
      
    

### 7. Code Leakage (GitHub)

- **Search for:** `target.com "API_KEY"` or `target.com "password"`
    
      
    
- **Check History:** Look at the Commit History. Developers often "delete" a secret in a new commit, but it stays in the git logs forever.
    
      
    

### 8. Cloud Infrastructure (S3 Buckets)

- **Common Naming:** `target-stage`, `target-backup`, `target-assets`
    
      
    
- **Testing:** Use tools like `S3Scanner` to see if permissions are accidentally set to "Public."
    

### 🔍 Updated Summary Table

| **Tool**            | **Primary Purpose**      | **Best For...**                                       |
| ------------------- | ------------------------ | ----------------------------------------------------- |
| **Google Dorks**    | Search Hacking           | Finding indexed sensitive files/configs.              |
| **theHarvester**    | Mass Gathering           | Collecting emails and subdomains from 20+ sources.    |
| **DNSDumpster**     | Passive DNS Discovery    | Mapping subdomains, DNS records, and host topologies. |
| **Shodan.io**       | IoT & Port Search Engine | Discovering open ports, banners, and exposed assets.  |
| **Wappalyzer**      | Fingerprinting           | Identifying the tech stack and CVE-prone versions.    |
| **Wayback Machine** | Historical Recon         | Finding old endpoints or "hidden" directories.        |
| **GitHub**          | Secret Hunting           | Finding leaked API keys and hardcoded credentials.    |
| **S3 Buckets**      | Cloud Discovery          | Locating exposed databases or private assets.         |