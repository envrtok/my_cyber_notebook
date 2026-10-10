**theHarvester** is used to gather intelligence from public sources (search engines, PGP key servers, and social media). Since it queries third-party databases rather than the target directly, it is a key tool for **Passive Reconnaissance**.

### 🔍 Core Command Syntax

The basic structure of a command is:

`theHarvester -d <domain> -b <source> [options]`

### 🚩 Essential Flags

|**Flag**|**Function**|**Example / Note**|
|---|---|---|
|**`-d`**|**Domain**: Sets the target domain.|`-d nasa.gov`|
|**`-b`**|**Source**: Specifies the data source (engine).|`-b bing,google,hunter`|
|**`-l`**|**Limit**: Limits the number of results.|`-l 500` (Default is often enough)|
|**`-f`**|**File**: Saves results to HTML and XML files.|`-f recon_results`|
|**`-v`**|**Verify**: DNS resolution for hostnames.|Checks if discovered hosts are active.|
|**`-h`**|**Help**: Displays the manual.|Use this when you're stuck!|

---

### 🔑 Managing API Keys

Many of the best sources (like Hunter, Shodan, or GitHub) require API keys to work.

- **Location:** `~/.theHarvester/api-keys.yaml`
    
- **Pro-Tip:** If you are using a pre-installed version (like in Kali Linux), you might need to find where the package stores this file, but the home directory path is the standard for recent versions.
    

---

### 🚀 Practical Examples

#### 1. The "Cast a Wide Net" Scan

Gathers data from every available free source for a specific domain.

Bash

```
theHarvester -d example.com -b all
```

#### 2. The Focused Search (No APIs Needed)

Focuses on search engines and certificate transparency logs to find subdomains.

Bash

```
theHarvester -d example.com -b bing,duckduckgo,crtsh,virustotal
```

#### 3. The Stealthy "Save to File" Scan

Limits results to 200 and saves the output for a professional report later.

Bash

```
theHarvester -d example.com -l 200 -b google -f output_report
```

---

### 💡 Pro-Tips for the Field

- **Source Variety:** Don't just rely on `all`. Some sources are slower than others. If you're in a rush, stick to `bing`, `crtsh`, and `duckduckgo`.
    
- **Permissions:** You mentioned `sudo`. Generally, you don't need root privileges to run theHarvester unless you are saving files to a protected directory.
    
- **Rate Limiting:** If you spam Google too hard, they might temporarily block your IP with a CAPTCHA. Use a VPN or rotate your sources if you're doing heavy lifting.