The goal of these tools is to map out the hidden attack surface by brute-forcing URLs against a wordlist.

### 1. ffuf (Fuzz Faster U Fool)

**Best for:** Speed and flexibility. It’s the industry favorite because it can fuzz almost anything (headers, parameters, JSON data).

- **Basic Directory Discovery:**
    
    `ffuf -w /path/to/wordlist.txt -u http://TARGET_IP/FUZZ`
    
- **Pro Tip (Filter by Size/Word count):**
    
    `ffuf -w /path/to/wordlist.txt -u http://TARGET_IP/FUZZ -fs 4242`
    
    _(Useful for hiding "false positives" that all return the same page size.)_
    

### 2. Gobuster

**Best for:** Stability and specific modes (DNS, VHosts, S3 buckets). It's written in Go, making it very fast without the complexity of ffuf.

- **Basic Directory Discovery:**
    
    `gobuster dir -u http://TARGET_IP/ -w /path/to/wordlist.txt`
    
- **Pro Tip (Search for specific file types):**
    
    `gobuster dir -u http://TARGET_IP/ -w /path/to/wordlist.txt -x php,txt,html`
    
    _(Crucial for finding configuration files or backup scripts.)_
    

### 3. dirb

**Best for:** Quick, "old-school" recursion. It's slower and doesn't handle threading as well as the others, but it's pre-installed on almost every distro.

- **Basic Usage:**
    
    `dirb http://TARGET_IP/ /path/to/wordlist.txt`
    
- **Note:** Dirb is recursive by default, meaning it will automatically start brute-forcing any subdirectories it finds.
    

---

### ⚡ Quick Comparison

|**Tool**|**Speed**|**Primary Use Case**|**Recursive?**|
|---|---|---|---|
|**ffuf**|🚀 Blazing|Advanced fuzzing (params, headers)|No (requires flags)|
|**Gobuster**|🏎️ Fast|Standard directory/DNS discovery|Optional (`-r`)|
|**dirb**|🐢 Slow|Simple, automated recursion|Yes (Default)|

---

### 💡 Expert Advice: The "Gold Standard" Wordlist

Regardless of the tool, your results are only as good as your wordlist. If you have **SecLists** installed, always aim for this one first:

`/usr/share/SecLists/Discovery/Web-Content/DirBuster-2007_directory-list-2.3-medium.txt`