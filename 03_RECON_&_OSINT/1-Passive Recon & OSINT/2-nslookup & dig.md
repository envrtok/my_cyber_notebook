
> [!summary] Tools Overview
> 
>   
> 
> - **`nslookup` (Name Server Lookup):** Legacy, cross-platform (Windows, Linux, macOS) utility for querying DNS records. Supports interactive REPL and non-interactive command modes.
>     
>       
>     
> - **`dig` (Domain Information Groper):** Modern, flexible DNS lookup utility standard on Linux/Unix systems. Preferred for security assessments and automation due to structured raw DNS outputs and detailed header flags.
>     
>       
>     

## Protocol & Tool Comparison

|**Feature**|**nslookup**|**dig**|
|---|---|---|
|**Primary OS**|Standard on Windows (Cross-platform)|Standard on Linux / macOS|
|**Output Formatting**|Simplified / High-level summary|Detailed / Raw DNS wire format|
|**Scriptability**|Basic (clunky to parse)|Excellent (`+short`, `+noall +answer`)|
|**Interactive Mode**|Supported (`nslookup` shell)|Not supported (CLI execution only)|
|**Resolution Tracing**|Limited|Supported (`+trace`)|
|**Zone Transfers**|Interactive `ls -d` mode|Direct syntax (`AXFR`)|

## `dig` Usage & Examples

Syntax: `dig [@server] [domain] [type] [options]`

  

### Common Queries



```Bash
# Basic A record lookup using system DNS
dig tryhackme.com

# Query specific record types (MX, TXT, NS, AAAA, SOA)
dig tryhackme.com MX
dig tryhackme.com TXT

# Direct query to a specific DNS server (e.g., Cloudflare 1.1.1.1)
dig @1.1.1.1 tryhackme.com A

# Return concise answer only (ideal for scripting)
dig tryhackme.com +short

# Reverse DNS lookup (PTR record)
dig -x 1.1.1.1
```

### Advanced Reconnaissance Commands



```Bash
# Full recursive trace from root DNS servers down to authoritative server
dig tryhackme.com +trace

# Attempt a DNS Zone Transfer (AXFR) to dump all domain records
dig @ns1.example.com example.com AXFR

# Filter output to show only the Answer Section
dig tryhackme.com +noall +answer
```

## `nslookup` Usage & Examples

Syntax: `nslookup [domain] [server]`

  

### Non-Interactive Queries



```Bash
# Basic lookup using default DNS server
nslookup tryhackme.com

# Query against a specific DNS server
nslookup tryhackme.com 8.8.8.8

# Query specific record types (e.g., MX, TXT)
nslookup -type=mx tryhackme.com
nslookup -type=txt tryhackme.com

# Reverse DNS lookup
nslookup 1.1.1.1
```

### Interactive Mode



```Plaintext
$ nslookup
> server 1.1.1.1
> set type=mx
> tryhackme.com
> exit
```

## Key Record Types for Security Assessment

- **A / AAAA:** IPv4 / IPv6 mappings. Identifies target IP addresses and hosting infrastructure.
    
      
    
- **MX (Mail Exchange):** Mail server hostnames. Identifies email infrastructure and third-party SaaS providers (e.g., Google Workspace, Proofpoint).
    
      
    
- **TXT:** Arbitrary text data. Frequently contains SPF (`v=spf1`), DKIM, DMARC, and domain ownership verification tokens for third-party services.
    
      
    
- **NS (Name Server):** Authoritative DNS servers. Maps out the target's DNS provider (e.g., Cloudflare, AWS Route 53) or self-hosted DNS servers.
    
      
    
- **SOA (Start of Authority):** Administrative metadata including primary NS, admin email (e.g., `hostmaster.example.com`), and serial numbers.
    
      
    
- **PTR (Pointer):** Resolves IP addresses back to domain names during reverse lookups.
    
      
    

## Reconnaissance Checklist

> [!tip] Target Analysis Focus
> 
>   
> 
> 1. **Mail Flow & Security:** Examine MX records and parse TXT records for SPF/DMARC policies to identify potential phishing vectors.
>     
>       
>     
> 2. **SaaS Footprinting:** Inspect TXT records for verification hashes (e.g., `google-site-verification`, `atlassian-domain-verification`) to reveal connected cloud ecosystems.
>     
>       
>     
> 3. **Zone Transfer Vulnerabilities:** Always test every discovered authoritative name server for unauthenticated AXFR requests (`dig @NS domain AXFR`).
>     
>       
>     
> 4. **IP Subnet Scope:** Collect all A/AAAA record IPs to build target lists for active port scanning.
>