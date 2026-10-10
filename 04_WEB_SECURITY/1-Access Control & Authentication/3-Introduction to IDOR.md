### 🛡️ Definition

**Insecure Direct Object Reference (IDOR)** occurs when an application provides direct access to objects based on user-supplied input. It happens because the application doesn't perform an adequate **authorization check** to ensure the user is allowed to access that specific resource.

> [!IMPORTANT]
> 
> IDOR is essentially a failure of **Access Control**, not necessarily a failure of authentication. You are logged in, but you're looking at things you shouldn't.

---

### 🔍 How it Works

1. **The Request:** You log in and see your profile at `https://example.com/api/user/1005`.
    
2. **The Manipulation:** You change the ID in the URL to `https://example.com/api/user/1006`.
    
3. **The Flaw:** If the server returns the data for user `1006` without checking if you own that account, you've found an IDOR.
    

### 📍 Where to Look

- **URL Parameters:** `?id=123`, `?order=55`
    
- **API Endpoints:** `/v1/messages/99`
    
- **Body Parameters:** JSON data like `{"user_id": "50"}`
    
- **Cookies:** Sometimes IDs are stored in cookies that can be modified.
    

---

### 📊 Common Impacts

|**Impact**|**Description**|
|---|---|
|**Data Leakage**|Viewing private info of other users (PII).|
|**Account Takeover**|Modifying password/email via an IDOR on a "Update Profile" request.|
|**Data Deletion**|Deleting resources belonging to others (e.g., `DELETE /post/10`).|

---

### 🛠️ Prevention

- **Implement RBAC/ABAC:** Use Role-Based or Attribute-Based Access Control.
    
- **Check Ownership:** Every time a resource is requested, verify: `Does User A own Resource B?`
    
- **Use GUIDs/UUIDs:** Instead of predictable integers (`1, 2, 3`), use random strings (`550e8400-e29b-41d4-a716-446655440000`).
    
    - _Note: This is "security through obscurity" and should be a secondary defense, not the only one!_