> [!summary] Protocol Overview
> 
>   
> 
> - **WHOIS (RFC 3912):** Legacy text-based query/response protocol operating over TCP port 43. Officially sunset by ICANN on **January 28, 2025** for generic top-level domains (gTLDs).
>     
>       
>     
> - **RDAP (Registration Data Access Protocol):** The modern authoritative successor. Operates over HTTPS, returns structured JSON, supports internationalization, and provides granular access controls aligned with data privacy regulations (GDPR/CCPA).
>     
>       
>     

## Key Data Fields & Recon Value

Post-GDPR/CCPA, personal contact details are standardly replaced with privacy services (`Withheld for Privacy`). Security assessments focus instead on:

  

- **Creation & Expiration Dates:** Evaluates domain age and identifies timing windows for social engineering or domain expiration/renewal attacks.
    
      
    
- **Registrar:** The domain broker (e.g., Namecheap, GoDaddy). Highlights registrar-specific phishing vectors or support workflows.
    
      
    
- **Name Servers:** Reveals authoritative DNS infrastructure and hosting providers for expanded attack surface mapping.
    
      
    
- **Status Codes:** Key security indicators, such as `clientTransferProhibited` (locks the domain against unauthorized hijacking/transfers).
    
      
    
- **Abuse Contacts:** Registrar email and phone contact points.
    
      
    
- **Historical WHOIS Data:** Snapshot services (e.g., Whoxy) reveal past ownership, historic DNS server migrations, and infrastructure shifts indicating past compromises.
    
      
    

## Protocol Comparison

|**Feature**|**WHOIS (Legacy)**|**RDAP (Modern Standard)**|
|---|---|---|
|**Transport Protocol**|TCP Port 43|HTTPS|
|**Data Format**|Unstructured plain text|Structured JSON|
|**Parsing Effort**|Custom regex per registrar|Native JSON parsing (`jq`)|
|**Privacy Support**|Binary (All or Redacted)|Differentiated / Granular access|
|**Current Status**|Sunset (Jan 28, 2025)|Active ICANN Standard|

## CLI Query Examples

### 1. Legacy WHOIS Client

Fast command-line lookup using TCP port 43.

  



```Bash
whois tryhackme.com
```

**Sample Output:**

  



```Plaintext
[Querying whois.verisign-grs.com]
[Redirected to whois.namecheap.com]
Domain name: tryhackme.com
Registry Domain ID: 2282723194_DOMAIN_COM-VRSN
Registrar WHOIS Server: whois.namecheap.com
Updated Date: 2021-05-01T19:43:23.31Z
Creation Date: 2018-07-05T19:46:15.00Z
Registrar Registration Expiration Date: 2027-07-05T19:46:15.00Z
Registrar: NAMECHEAP INC
Registrar Abuse Contact Email: abuse@namecheap.com
Domain Status: clientTransferProhibited https://icann.org/epp#clientTransferProhibited
Registrant Name: Withheld for Privacy Purposes
```

### 2. Modern RDAP Query via `curl`

Querying public endpoints returning JSON formatted via `jq`.

  



```Bash
curl -s https://rdap.verisign.com/com/v1/domain/tryhackme.com | jq .
```

**Sample Output:**

  



```JSON
{
  "domain": "tryhackme.com",
  "handle": "2282723194_DOMAIN_COM-VRSN",
  "ldhName": "TRYHACKME.COM",
  "status": [
    "clientTransferProhibited"
  ],
  "registrar": "NAMECHEAP INC",
  "events": [
    {"eventAction": "registration", "eventDate": "2018-07-05T19:46:15.00Z"},
    {"eventAction": "last update", "eventDate": "2025-05-11T...Z"},
    {"eventAction": "expiration", "eventDate": "2034-07-05T19:46:15.00Z"}
  ],
  "nameservers": [ ... ]
}
```

## Reconnaissance Checklist

> [!tip] Target Analysis Focus
> 
>   
> 
> 1. **Redirection Chain:** Track referral from registry servers (e.g., Verisign) to the actual registrar endpoint.
>     
>       
>     
> 2. **Domain Lifecycle:** Look for newly registered domains (higher risk/untrusted) or near-expiry dates.
>     
>       
>     
> 3. **Infrastructure Scope:** Extract authoritative name servers to scope subsequent DNS enumeration target lists.
>     
>       
>     
> 4. **Transfer Controls:** Confirm if EPP status flags like `clientTransferProhibited` are active.
>     
>       
>     

## Web Tools & Resources

- **RDAP Lookup (Modern):** [lookup.icann.org](https://lookup.icann.org/)
    
      
    
- **WHOIS Lookup (Legacy):** [whois.icann.org](https://whois.icann.org/)
    
      
    
- **Historical WHOIS Snapshots:** [whoxy.com](https://www.whoxy.com/)