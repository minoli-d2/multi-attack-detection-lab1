# SSH Multi-Attack Log Analysis

## Overview

This project demonstrates a practical cybersecurity investigation of SSH authentication logs to detect multiple attack patterns, analyze suspicious behavior, and assess potential system compromise.

The analysis simulates a real-world Security Operations Center (SOC) workflow using Linux command-line tools.

---

## Objectives

- Detect brute-force attacks from log data
- Identify password spraying attempts
- Recognize reconnaissance and probing activity
- Analyze privilege usage and detect potential abuse
- Differentiate between legitimate and malicious activity

---

## Tools & Technologies

- Kali Linux (Virtual Machine)
- Linux CLI tools: `grep`, `awk`, `sort`, `uniq`
- Git & GitHub for version control

---

## Project Structure

linux-ssh-log-analysis/

├── logs/
│   
└── attacks_log.log

│
├── analysis/
│   ├── commands.sh
│   └── analysis_notes.md

│
├── reports/
│   └── incident_report.md

│
├── screenshots/

│
├── session.log

└── README.md

---

## Attack Scenarios Covered

This project includes detection and analysis of multiple real-world attack patterns:

- **Brute-force attack** targeting privileged accounts
- **Password spraying attack** across multiple usernames
- **Reconnaissance / probing activity** from external sources
- **Privilege abuse** through misuse of sudo commands
- **Legitimate administrative activity** validation

---

## Detection Methodology

The investigation follows a structured SOC workflow:

1. Extract failed authentication attempts
2. Identify top attacking IP addresses
3. Analyze login frequency and timing patterns
4. Correlate failed and successful login attempts
5. Investigate privileged command usage (sudo)
6. Validate findings through log verification

All analysis was performed using Linux command-line tools.

---

## Key Findings

### Brute-Force Attack
- **IP:** 185.234.219.12  
- **Target:** root account  
- **Behavior:** Repeated attempts at consistent intervals  
- **Assessment:** Likely automated brute-force attack  
- **Result:** No successful login  

---

### Password Spraying Attack
- **IP:** 45.77.88.19  
- **Target:** Multiple user accounts  
- **Assessment:** Attempt to avoid account lockouts  
- **Result:** No successful login  

---

### Reconnaissance / Probing
- **IPs:** 103.56.22.90, 66.23.11.45  
- **Target:** Privileged accounts  
- **Assessment:** Low-frequency probing activity  

---

### Privilege Abuse (Internal)
- **User:** charlie  
- **Activity:**
  - Created a new user
  - Set password for the account
  - Modified `/etc/sudoers`  

- **Assessment:** Highly suspicious activity indicating potential misuse of privileges  

---

### Legitimate Activity
- Users: alice, bob, david, eve  
- Source: Internal IP addresses  
- Activity: Normal system usage and administration  

---

## Security Assessment

- External attack attempts were detected but unsuccessful
- No evidence of unauthorized external access
- Internal activity revealed potential privilege abuse
- Critical system configuration was modified, posing a security risk

---

## Recommendations

- Disable direct root login over SSH
- Enforce key-based authentication
- Implement account lockout policies
- Deploy intrusion prevention tools (e.g., fail2ban)
- Audit and investigate suspicious internal user activity
- Restore and secure critical configuration files
- Continuously monitor authentication logs

---

## Key Skills Demonstrated

- Log analysis and threat detection
- Identification of brute-force and password spraying attacks
- Linux command-line proficiency
- Security investigation and analytical thinking
- Incident reporting and documentation

---

## Conclusion

This project demonstrates the ability to analyze authentication logs, detect multiple attack types, and perform structured security investigations. It highlights both external threats and internal risks, emphasizing the importance of continuous monitoring and proper access control.

---

## Author

Minoli Silva  
Aspiring Cybersecurity Analyst
