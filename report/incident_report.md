# Incident Report: SSH Multi-Attack Analysis

## 1. Executive Summary

An analysis of SSH authentication logs identified multiple unauthorized access attempts originating from external IP addresses. The activity includes a confirmed brute-force attack, a password spraying attempt, and low-frequency probing behavior. Additionally, suspicious privilege abuse was detected from an internal user. No evidence of successful external compromise was found.

---

## 2. Scope

- Log Source: SSH authentication logs (`attacks_log.log`)
- Environment: Linux server
- Analysis Method: Command-line log analysis using grep, awk, sort, and uniq

---

## 3. Findings

### 3.1 Brute-Force Attack

- **Source IP:** 185.234.219.12
- **Target Account:** root
- **Activity:** 8 failed login attempts 
- **Pattern:** Attempts occurred at consistent ~2-second intervals  

**Assessment:**  
This behavior indicates an automated brute-force attack targeting the root account. No successful login attempts were observed from this IP.

---

### 3.2 Password Spraying Attack

- **Source IP:** 45.77.88.19  
- **Target Accounts:** admin, root, test, user, guest  
- **Activity:** 5 failed login attempts across multiple accounts  

**Assessment:**  
The attack pattern suggests password spraying, where a single password is attempted across multiple accounts to avoid lockouts. No successful authentication was observed.

---

### 3.3 Targeted Probing Activity

- **Source IP:** 103.56.22.90  
- **Target Account:** admin  
- **Activity:** 3 failed login attempts  

**Assessment:**  
This activity represents low-frequency targeted probing or reconnaissance. While not a full brute-force attack, it indicates interest in privileged accounts.

---

### 3.4 Low-Intensity Attack

- **Source IP:** 66.23.11.45  
- **Target Account:** root  
- **Activity:** 2 failed login attempts  

**Assessment:**  
This may represent early-stage brute-force probing. Continued monitoring is recommended.

---

### 3.5 Successful Authentication Activity

- **Users:** alice, bob, charlie, david, eve  
- **Source IPs:** 192.168.1.x (internal network)  

**Assessment:**  
All successful logins originated from internal IP addresses, indicating legitimate or trusted access. No external IP addresses successfully authenticated.

---

### 3.6 Privilege Usage Analysis

#### Bob
- Commands executed: directory listing and reading `/etc/passwd`

**Assessment:**  
Activity appears consistent with basic system usage or enumeration. No clear signs of malicious intent.

---

#### Charlie
- Commands executed:
  - Created a new user account
  - Set password for the new account
  - Moved `/etc/sudoers` to `/tmp/`

**Assessment:**  
This activity is highly suspicious and indicates potential privilege abuse. Modifying or relocating the sudoers file can compromise access control and system integrity.

---

#### David
- Commands executed: system package updates

**Assessment:**  
Normal administrative activity.

---

#### Eve
- Commands executed: restart of Nginx service

**Assessment:**  
Normal system administration behavior.

---

## 4. Security Assessment

- Brute-force and password spraying attacks were detected but were unsuccessful
- No evidence of external system compromise
- Internal user activity revealed potential privilege abuse
- Critical system file (`/etc/sudoers`) was manipulated, posing a high security risk

---

## 5. Recommendations

1. Disable direct root login over SSH  
2. Implement key-based authentication for SSH access  
3. Enforce account lockout policies to mitigate brute-force attempts  
4. Deploy intrusion prevention tools such as fail2ban  
5. Investigate and audit activities performed by user "charlie"  
6. Restore and verify integrity of the `/etc/sudoers` file  
7. Continuously monitor authentication logs for suspicious activity  

---

## 6. Conclusion

The system was subjected to multiple external attack attempts, including brute-force and password spraying attacks. While no unauthorized external access was achieved, suspicious internal activity indicates a potential insider threat or compromised account. Immediate investigation and remediation actions are recommended to ensure system security.
