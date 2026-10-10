Manual discovery involves interacting with the target website directly through a browser or command-line tools to uncover its structure, hidden pages, and underlying technologies.

- **`robots.txt`**
    
    - **What it is:** A text file designed to tell legitimate web crawlers (like Googlebot) which directories or pages they should _not_ index.
        
    - **Pentesting Value:** Administrators often use it to hide sensitive areas (e.g., `/admin`, `/api`, `/dev-backup`). Pentesters check this file to easily find exactly what the website owner is trying to hide from search engines.
        
- **`sitemap.xml`**
    
    - **What it is:** A file that provides a map of the website's public pages to help search engines navigate and index the site efficiently.
        
    - **Pentesting Value:** It acts as a ready-made directory structure. Pentesters use it to discover hidden endpoints, forgotten pages, or older API versions that might still be active and vulnerable.
        
- **Favicon Hashing**
    
    - **What it is:** The favicon is the small icon displayed in the browser tab.
        
    - **Pentesting Value:** Developers often forget to change the default favicon provided by their web framework (e.g., Spring Boot, React, Tomcat). By downloading the favicon using `curl` and generating its hash (usually MurmurHash3), pentesters can cross-reference it with known databases (like Shodan) to instantly identify the specific framework and version running on the server.
        
- **HTTP Response Headers**
    
    - **What it is:** Metadata sent back by the server alongside the webpage content.
        
    - **Pentesting Value:** Headers often leak sensitive infrastructure details. For example, headers like `Server` or `X-Powered-By` can reveal the exact web server (e.g., Apache/2.4.41) or backend language (e.g., PHP/7.4) being used. You can easily view these by running a verbose curl command: `curl -v <target_URL>`.
        
- **Framework / Tech Stack Identification**
    
    - **What it is:** Determining the complete list of technologies running the website (languages, databases, analytics tools, libraries).
        
    - **Pentesting Value:** Once the stack is identified, a pentester can search for known vulnerabilities (CVEs) associated with those specific technologies. This can be done manually by inspecting HTML source code, cookies, and headers, or by using browser extensions like Wappalyzer.