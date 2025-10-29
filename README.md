# System Recon - Linux System Reconnaissance Tool

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Bash](https://img.shields.io/badge/Bash-4.0%2B-green.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Linux-blue.svg)](https://www.linux.org/)

**Author**: Manuel Sánchez Gutiérrez  
**Date**: October 2024  
**Purpose**: Educational tool for Linux system reconnaissance and auditing

---

## 📋 Description

**System Recon** is a command-line tool written in Bash to gather detailed information from Linux systems. Developed as part of my training in **Network Systems Administration (ASIR)** and my specialization in **cybersecurity**.

This tool is useful in the **post-exploitation** phase of pentesting, as well as for **security audits** and **system documentation**.

---

## ✨ Features

- ✅ **System information** (OS, kernel, architecture, uptime)
- ✅ **Network configuration** (interfaces, routes, DNS, active connections)
- ✅ **Users and groups** (users with shell, last logins, active sessions)
- ✅ **Privileges and permissions** (sudo, SUID/SGID files, writable files)
- ✅ **Processes and services** (running processes, active services, cron jobs)
- ✅ **Installed software** (Python, GCC, Git versions, development tools)
- ✅ **Storage** (disk usage, mounted partitions, block devices)
- ✅ **Environment variables** (PATH, HOME, sensitive variables)
- ✅ **Sensitive files** (SSH configuration, command history, .env files)
- ✅ **Security configuration** (firewall, SELinux, AppArmor)
- ✅ **System logs** (authentication, syslog)
- ✅ **Complete report export** to text file
- ✅ **Quiet mode** for automation

---

## 🚀 Installation

### Requirements

- Operating system: Linux (Ubuntu, Debian, Kali Linux, CentOS, etc.)
- Bash 4.0 or higher
- Execution permissions (some commands require sudo)

### Steps

1. Clone the repository:
```bash
git clone https://github.com/yourusername/system-recon.git
cd system-recon
```

2. Grant execution permissions:
```bash
chmod +x system_recon.sh
```

3. Ready to use!

---

## 💻 Usage

### Basic Syntax

```bash
./system_recon.sh [OPTIONS]
```

### Options

| Option | Description | Example |
|--------|-------------|---------|
| `-o, --output FILE` | Save complete report to file | `-o report.txt` |
| `-q, --quiet` | Quiet mode (only save, don't display) | `-q` |
| `-h, --help` | Show help | `-h` |

### Usage Examples

**Display information on screen:**
```bash
./system_recon.sh
```

**Save report to file:**
```bash
./system_recon.sh -o system_report.txt
```

**Quiet mode (only save):**
```bash
./system_recon.sh -o report.txt -q
```

**Run with sudo for complete information:**
```bash
sudo ./system_recon.sh -o complete_report.txt
```

---

## 📊 Example Output

```
╔═══════════════════════════════════════════════════════════╗
║       SYSTEM RECON - Linux System Reconnaissance         ║
║                   Ethical Use Only                        ║
╚═══════════════════════════════════════════════════════════╝

[*] System: ubuntu-server
[*] User: manuel
[*] Date: 2024-10-28 16:00:15
============================================================

[*] SYSTEM INFORMATION
============================================================
[+] Hostname
ubuntu-server

[+] Operating System
Ubuntu 22.04.3 LTS

[+] Kernel Version
5.15.0-91-generic

[+] Architecture
x86_64

[+] Uptime
up 5 days, 3 hours, 24 minutes

[*] NETWORK INFORMATION
============================================================
[+] Network interfaces
lo               UNKNOWN        127.0.0.1/8 ::1/128
eth0             UP             192.168.1.100/24 fe80::a00:27ff:fe4e:66a1/64

[+] Routing table
default via 192.168.1.1 dev eth0
192.168.1.0/24 dev eth0 proto kernel scope link src 192.168.1.100

[+] Listening ports
tcp   LISTEN  0.0.0.0:22      sshd
tcp   LISTEN  0.0.0.0:80      nginx
tcp   LISTEN  0.0.0.0:3306    mysqld

[*] USERS AND GROUPS
============================================================
[+] Current user
manuel

[+] User ID
uid=1000(manuel) gid=1000(manuel) groups=1000(manuel),27(sudo)

[+] Users with shell
root
manuel
admin

[*] PRIVILEGES AND PERMISSIONS
============================================================
[+] User sudo permissions
User manuel may run the following commands:
    (ALL : ALL) ALL

[+] Files with SUID
/usr/bin/sudo
/usr/bin/passwd
/usr/bin/chsh
/usr/bin/newgrp
...

[*] PROCESSES AND SERVICES
============================================================
[+] Running processes (top 10 CPU)
USER       PID %CPU %MEM    VSZ   RSS COMMAND
www-data  1234  2.5  1.2 123456 12345 nginx
mysql     5678  1.8  5.4 234567 23456 mysqld
...

[*] STORAGE AND FILE SYSTEM
============================================================
[+] Disk usage
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        50G   25G   23G  52% /
/dev/sdb1       100G   45G   50G  48% /data

...
```

---

## 🔧 Technical Operation

### Script Architecture

The script is organized into thematic sections:

```bash
perform_recon() {
    print_section "SYSTEM INFORMATION"
    run_command "Hostname" "hostname"
    run_command "Operating System" "cat /etc/os-release | grep PRETTY_NAME"
    ...
}
```

Each section gathers related information using native Linux commands.

### Commands Used

| Category | Commands |
|----------|----------|
| System | `hostname`, `uname`, `uptime`, `cat /etc/os-release` |
| Network | `ip`, `ss`, `cat /etc/resolv.conf` |
| Users | `whoami`, `id`, `last`, `w`, `cat /etc/passwd` |
| Permissions | `sudo -l`, `find` (SUID/SGID) |
| Processes | `ps`, `systemctl`, `crontab` |
| Software | `python3 --version`, `gcc --version`, `which` |
| Storage | `df`, `mount`, `lsblk` |
| Security | `ufw status`, `iptables`, `getenforce`, `aa-status` |
| Logs | `tail /var/log/auth.log`, `tail /var/log/syslog` |

### Error Handling

The script handles errors silently:

```bash
run_command() {
    eval "$command" 2>/dev/null || echo "(Not available)"
}
```

This allows the script to continue even if some commands fail (due to lack of permissions or because they don't exist).

---

## 📚 Use Cases

### 1. Post-Exploitation in Pentesting (Lab)

After gaining access to a system in a practice environment:

```bash
./system_recon.sh -o recon_target.txt -q
```

### 2. Security Audit

Document the security configuration of a server:

```bash
sudo ./system_recon.sh -o server_audit_$(date +%Y%m%d).txt
```

### 3. System Documentation

Generate automatic documentation of a server configuration:

```bash
./system_recon.sh -o web_server_documentation.txt
```

### 4. Troubleshooting

Gather system information for problem diagnosis:

```bash
./system_recon.sh -o troubleshooting_$(hostname).txt
```

### 5. Privilege Escalation (Lab)

Identify privilege escalation vectors on practice machines:

```bash
./system_recon.sh | grep -A 20 "SUID\|sudo"
```

---

## ⚠️ Legal Disclaimer

**IMPORTANT**: This tool is exclusively for educational purposes and authorized auditing.

- ✅ **Allowed**: Use on your own systems, practice labs, systems with explicit authorization
- ❌ **Prohibited**: Run on compromised systems without legal authorization

Gathering system information without authorization may be illegal. The author is **NOT responsible** for misuse of this tool.

**Only run on systems where you have written authorization.**

---

## 🎓 Educational Context

This project was developed as part of my training in:

- **Higher Degree in Network Systems Administration (ASIR)** - UNIR
- **eJPT v2 Certification** (Junior Penetration Tester) - INE Security
- **Ethical Pentesting Training** - Hack4u

### Demonstrated Skills

- ✅ Linux system administration
- ✅ Understanding of Linux file system structure
- ✅ Security configuration analysis
- ✅ Post-exploitation techniques
- ✅ Advanced Bash scripting
- ✅ System audit methodologies

---

## 🔄 Comparison with Other Tools

| Feature | System Recon (Bash) | LinPEAS | LinEnum |
|---------|---------------------|---------|---------|
| Language | Bash | Bash/Python | Bash |
| Size | ~8 KB | ~800 KB | ~50 KB |
| Vector detection | Basic | Advanced | Medium |
| Colors | Yes | Yes | Yes |
| Export | Text | Text/HTML | Text |
| Purpose | Educational | Professional | Professional |

**When to use this script?**
- Learning Linux system reconnaissance
- Basic configuration audits
- System documentation
- Resource-limited environments

---

## 🛠️ Future Improvements

- [ ] Automatic detection of privilege escalation vectors
- [ ] Analysis of insecure configurations (weak permissions, default passwords)
- [ ] Export to HTML and JSON formats
- [ ] Integration with vulnerability databases (CVE)
- [ ] Comparison mode between two systems
- [ ] Automatic hardening recommendations
- [ ] Docker container support

---

## 📖 Learning Resources

If you want to learn more about system reconnaissance and privilege escalation:

- **Professional tools**: LinPEAS, LinEnum, Linux Smart Enumeration
- **Practice platforms**: HackTheBox, TryHackMe (Linux machines)
- **Resources**: GTFOBins, PEASS-ng, PayloadsAllTheThings
- **Books**: "Linux Basics for Hackers" by OccupyTheWeb
- **Courses**: Hack4u, TCM Security, Offensive Security (OSCP)

---

## 🔍 Common Privilege Escalation Vectors

This script helps identify:

1. **SUID/SGID binaries**: Search on GTFOBins
2. **Sudo permissions**: Exploit weak configurations
3. **Cron jobs**: Executable files with weak permissions
4. **Vulnerable services**: Old software versions
5. **Writable files**: `/etc/passwd`, startup scripts
6. **Capabilities**: Special Linux permissions
7. **Kernel exploits**: Old kernel versions

---

## 📝 Interpreting Results

### Dangerous SUID Files

If you find binaries like these with SUID, investigate on GTFOBins:
- `find`, `vim`, `less`, `more`, `nano`
- `nmap` (old versions), `python`, `perl`
- `tar`, `zip`, `unzip`

### Interesting Sudo Permissions

Configurations like these may be exploitable:
```
(ALL) NOPASSWD: /usr/bin/vim
(ALL) NOPASSWD: /bin/bash
(root) NOPASSWD: /usr/bin/find
```

### Services on Internal Ports

Services listening only on localhost can be tunneled:
```
127.0.0.1:3306  (MySQL)
127.0.0.1:6379  (Redis)
```

---

## 📧 Contact

**Manuel Sánchez Gutiérrez**  
- Email: manoloadra2@gmail.com  
- LinkedIn: [linkedin.com/in/manuel-sanchez-gutierrez](https://www.linkedin.com/in/manuel-sánchez-gutiérrez-b534ab336/)  
- GitHub: [github.com/yourusername](https://github.com/yourusername)

---

## 📄 License

This project is under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

## 🌟 Acknowledgments

- To the pentesting community for sharing knowledge
- To the creators of LinPEAS and LinEnum for inspiring this tool
- To HackTheBox and TryHackMe for providing practice environments

---

**Remember**: System knowledge is fundamental to security. Use this tool ethically and responsibly.

*"Know your system, secure your system."*
