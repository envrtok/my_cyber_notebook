**Username enumeration** relies on spotting the "odd one out" among thousands of requests. While `-mr` looks for a specific success message, `-fs` and `-fw` are used to **hide the noise** (the standard "User Not Found" responses).

### The Command

``` bash
ffuf -w /usr/share/wordlists/SecLists/Usernames/Names/names.txt \
     -X POST \
     -d "username=FUZZ&email=x&password=x&cpassword=x" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -u http://10.114.164.165/customers/signup \
     -fs 1495 -fw 85
```

### Flag Breakdown

|**Flag**|**Name**|**Purpose**|
|---|---|---|
|**`-w`**|Wordlist|Path to your username list.|
|**`-X`**|Method|Request type (POST).|
|**`-d`**|Data|The POST body. **`FUZZ`** is the injection point.|
|**`-H`**|Header|Required for form data (`Content-Type`).|
|**`-u`**|URL|The target endpoint.|
|**`-mr`**|Match Regex|**The Matcher:** Only shows results containing a specific string.|
|**`-fs`**|Filter Size|**The Filter:** Hides responses of a specific byte size.|
|**`-fw`**|Filter Word|**The Filter:** Hides responses with a specific word count.|

---

### Why use `-fs` and `-fw` together?

In modern web apps, the page size might fluctuate by a few bytes on every load (due to a clock or a random ID), making `-fs` unreliable on its own. However, the number of **words** on the "Invalid User" page usually stays the same.

- **Size (`-fs`):** Great for static pages.
    
- **Word Count (`-fw`):** Great for dynamic pages where the text doesn't change, even if the byte size does.
    

> **Pro Tip:** To find these values, run a "canary" request first with a fake username. Look at the `ffuf` output for that request—it will tell you the `Size` and `Words`. Use those numbers to filter out the rest of the scan.