#  SSH Multi-Attack Log Analysis Notes

---

## 1. Extract Failed Login Attempts

###  Command

grep "Failed password" logs/attacks_log.log

###  Output (summary)

Multiple failed login attempts observed from different external IPs targeting various user accounts.

###  Interpretation

The system is experiencing unauthorized login attempts from external sources. These events require further analysis to identify attack patterns such as brute-force or password spraying.

---

## 2. Identify Top Attacking IPs

###  Command

grep "Failed password" logs/attacks_log.log | awk '{print $11}' | sort | uniq -c | sort -nr

###  Output

8 185.234.219.12
5 45.77.88.19
3 103.56.22.90
2 66.23.11.45

###  Interpretation

    185.234.219.12 is the most active attacker → likely brute-force
    45.77.88.19 shows multiple attempts across users → password spraying
    Other IPs show low-frequency attempts → possible probing activity

---

## 3. Brute Force Analysis (185.234.219.12)

###  Command

grep "185.234.219.12" logs/attacks_log.log | awk '{print $1,$2,$3,$9,$11}'

###  Output

Apr 23 09:05:01 root 185.234.219.12
Apr 23 09:05:03 root 185.234.219.12
...
Apr 23 09:05:15 root 185.234.219.12

###  Interpretation

    Repeated attempts targeting root account
    Consistent ~2-second intervals
    Strong indication of automated brute-force attack

** Verification**

### Command

grep "185.234.219.12" logs/attacks_log.log | grep "Accepted"

###  Output

(no output)

###  Interpretation

No successful login detected → attack unsuccessful

---

## 4. Password Spraying Analysis (45.77.88.19)

### Command

grep "45.77.88.19" logs/attacks_log.log | awk '{print $1,$2,$3,$9,$11}'

###  Output

Apr 23 09:02:01 admin 45.77.88.19
Apr 23 09:02:03 root 45.77.88.19
Apr 23 09:02:05 test 45.77.88.19
Apr 23 09:02:07 user 45.77.88.19
Apr 23 09:02:09 guest 45.77.88.19

admin, root, test, user, guest targeted

###  Interpretation

    Multiple usernames targeted with low attempts per account
    Indicates password spraying attack
    Designed to avoid account lockouts

** Verification**

###  Command

grep "45.77.88.19" logs/attacks_log.log | grep "Accepted"

###  Output

(no output)

###  Interpretation

No successful login detected

---

## 5. Targeted Probing (103.56.22.90)

### Command

grep "103.56.22.90" logs/attacks_log.log | awk '{print $1,$2,$3,$9,$11}'

### Output

Repeated attempts targeting admin account

###  Interpretation

    Low-frequency attempts
    Focused on admin account
    Likely reconnaissance or targeted probing

** Verification**

###  Command

grep "103.56.22.90" logs/attacks_log.log | grep "Accepted"

###  Output

(no output)

###  Interpretation

No successful login detected

---

## 6. Low-Intensity Attack (66.23.11.45)

###  Command

grep "66.23.11.45" logs/attacks_log.log | awk '{print $1,$2,$3,$9,$11}'

###  Output

2 failed attempts targeting root

###  Interpretation

    Very low number of attempts
    Likely early-stage brute-force probing

---

## 7. Successful Login Analysis

###  Command

grep "Accepted" logs/attacks_log.log | awk '{print $1,$2,$3,$9,$11}'

###  Output

Apr 23 09:00:01 alice 192.168.1.10
Apr 23 09:01:10 bob 192.168.1.11
Apr 23 09:15:01 charlie 192.168.1.20
Apr 23 09:20:01 david 192.168.1.21
Apr 23 09:30:01 eve 192.168.1.22

### Interpretation

    All successful logins originate from internal IP range (192.168.1.x)
    Indicates legitimate or trusted access
    No external IP successfully authenticated

---

## 8. Privilege Usage Analysis

###  Command

grep "sudo" logs/attacks_log.log

### Output

Multiple sudo commands executed by users

### Interpretation

    Privilege usage detected
    Requires user-level investigation to identify misuse

---

## 9. User Behavior Investigation

** (i) Bob**

### Command

grep "bob" logs/attacks_log.log

### Output

    Login from internal IP
    Commands: /bin/ls, /etc/passwd

### Interpretation

    Normal login
    Basic system enumeration
    No clear malicious activity

** (ii) Charlie**

###  Command

grep "charlie" logs/attacks_log.log

###  Output

    Created new user
    Changed password
    Moved /etc/sudoers

### Interpretation

    Highly suspicious activity
    Indicates privilege abuse
    Modification of sudoers file is critical risk

** (iii) David**

###  Command

grep "david" logs/attacks_log.log

###  Output

    System updates using apt

### Interpretation

    Normal administrative activity

**(iv) Eve**

### Command

grep "eve" logs/attacks_log.log

###  Output

    Restarted Nginx service

### Interpretation

    Normal system administration behavior
    No suspicious activity detected

---

 Final Summary

    Confirmed brute-force attack from 185.234.219.12
    Password spraying attack from 45.77.88.19
    Reconnaissance/probing from 103.56.22.90 and 66.23.11.45
    No successful external login attempts
    Suspicious privilege abuse detected from charlie
    Other users show normal activity
