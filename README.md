# Port Scanner - TCP Port Scanning Tool

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Bash](https://img.shields.io/badge/Bash-4.0%2B-green.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Linux-blue.svg)](https://www.linux.org/)

**Author**: Manuel Sánchez Gutiérrez  
**Date**: October 2024  
**Purpose**: Educational pentesting tool for TCP port scanning

---

## 📋 Description

**Port Scanner** is a command-line tool written in Bash for scanning TCP ports on remote hosts. Developed as part of my training in **Network Systems Administration (ASIR)** and my specialization in **cybersecurity**.

This tool allows you to quickly identify which ports are open on a target system, as well as the services running on those ports.

---

## ✨ Features

- ✅ **Fast scanning** using Bash's native `/dev/tcp`
- ✅ **Automatic service identification** via `/etc/services`
- ✅ **Concurrent processing** (up to 100 simultaneous threads)
- ✅ **Results export** to CSV format
- ✅ **Colorful interface** for better terminal visualization
- ✅ **Customizable port ranges**
- ✅ **Robust error handling**
- ✅ **No external dependencies** (Bash only)

---

## 🚀 Installation

### Requirements

- Operating system: Linux (Ubuntu, Debian, Kali Linux, etc.)
- Bash 4.0 or higher
- Execution permissions

### Steps

1. Clone the repository:
```bash
git clone https://github.com/Elabdera/port-scanner.git
cd port-scanner
```

2. Grant execution permissions:
```bash
chmod +x port_scanner.sh
```

3. Ready to use!

---

## 💻 Usage

### Basic Syntax

```bash
./port_scanner.sh -t <IP> -p <port_range>
```

### Options

| Option | Description | Example |
|--------|-------------|---------|
| `-t, --target IP` | Target host (required) | `-t 192.168.1.1` |
| `-p, --ports RANGE` | Port range (default: 1-1024) | `-p 1-1000` |
| `-o, --output FILE` | Save results to file | `-o results.txt` |
| `-h, --help` | Show help | `-h` |

### Usage Examples

**Scan common ports on a host:**
```bash
./port_scanner.sh -t 192.168.1.1 -p 1-1024
```

**Scan specific ports:**
```bash
./port_scanner.sh -t scanme.nmap.org -p 20-100
```

**Scan and save results:**
```bash
./port_scanner.sh -t 10.0.0.1 -p 1-65535 -o scan_results.csv
```

**Scan common web ports:**
```bash
./port_scanner.sh -t example.com -p 80-443
```

---

## 📊 Example Output

```
╔═══════════════════════════════════════════════════════════╗
║           PORT SCANNER - Pentesting Tool                  ║
║                   Ethical Use Only                        ║
╚═══════════════════════════════════════════════════════════╝

[*] Target: scanme.nmap.org (45.33.32.156)
[*] Port range: 1-1000 (1000 ports)
[*] Scan started: 2024-10-28 15:30:45
============================================================
[*] Scanning 1000 ports on 45.33.32.156...
[*] Using 100 concurrent threads

[+] Port 22/tcp OPEN - Service: ssh
[+] Port 80/tcp OPEN - Service: http
[+] Port 443/tcp OPEN - Service: https

============================================================
[*] Scan completed in 12.34 seconds
[*] Open ports found: 3/1000
[*] Results saved to: scan_results.csv

[!] Disclaimer: This tool is for educational and ethical use only.
[!] Obtain authorization before scanning any system.
```

---

## 🔧 Technical Operation

### Scanning Method

The script uses Bash's `/dev/tcp` feature to make TCP connections:

```bash
timeout 1 bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null
```

If the connection succeeds (exit code 0), the port is open.

### Concurrent Processing

To speed up scanning, the script runs multiple checks in parallel:

```bash
check_port "$target" "$port" &

if [ $(jobs -r | wc -l) -ge 100 ]; then
    wait -n
fi
```

This allows scanning up to 100 ports simultaneously, significantly reducing total time.

### Service Identification

Services are identified by querying `/etc/services`:

```bash
service=$(grep -w "$port/tcp" /etc/services | awk '{print $1}' | head -n1)
```

---

## 📚 Use Cases

### 1. Local Network Security Audit

Identify exposed services on devices in your network:

```bash
./port_scanner.sh -t 192.168.1.1 -p 1-1024 -o router_scan.csv
```

### 2. Firewall Verification

Check if a firewall is correctly blocking certain ports:

```bash
./port_scanner.sh -t server.example.com -p 1-65535
```

### 3. Pentesting Reconnaissance (Lab)

Reconnaissance phase on practice virtual machines:

```bash
./port_scanner.sh -t 10.10.10.5 -p 1-10000 -o target_recon.csv
```

---

## ⚠️ Legal Disclaimer

**IMPORTANT**: This tool is exclusively for educational purposes and ethical pentesting.

- ✅ **Allowed**: Use on your own systems, practice labs (HackTheBox, TryHackMe), virtual machines with explicit permission
- ❌ **Prohibited**: Use against third-party systems without written authorization

Unauthorized port scanning may be illegal in many jurisdictions. The author is **NOT responsible** for misuse of this tool.

**Always obtain written authorization before scanning systems you don't own.**

---

## 🎓 Educational Context

This project was developed as part of my training in:

- **Higher Degree in Network Systems Administration (ASIR)** - UNIR
- **eJPT v2 Certification** (Junior Penetration Tester) - INE Security
- **Ethical Pentesting Training** - Hack4u

### Demonstrated Skills

- ✅ Advanced Bash scripting
- ✅ Understanding of TCP/IP protocols
- ✅ Sockets and network connections
- ✅ Concurrent processing in shell
- ✅ Error handling and input validation
- ✅ Professional technical documentation

---

## 🔄 Comparison with Nmap

| Feature | Port Scanner (Bash) | Nmap |
|---------|---------------------|------|
| Speed | Medium (100 threads) | Very fast |
| Scan types | TCP Connect only | TCP SYN, UDP, etc. |
| OS detection | No | Yes |
| Version detection | No | Yes |
| Dependencies | None | Requires installation |
| Size | ~5 KB | ~30 MB |
| Purpose | Educational | Professional |

**When to use this script?**
- Environments where you can't install Nmap
- Learning port scanning concepts
- Custom scripts that need simple scanning
- Embedded systems with only Bash available

---

## 🛠️ Future Improvements

- [ ] UDP scanning support
- [ ] Service version detection
- [ ] IP range scanning (CIDR)
- [ ] Export to JSON and XML formats
- [ ] Integration with vulnerability APIs (CVE)
- [ ] Quiet mode for automation

---

## 📖 Learning Resources

If you want to learn more about port scanning and pentesting:

- **Professional tools**: Nmap, Masscan, Unicornscan
- **Practice platforms**: HackTheBox, TryHackMe, PentesterLab
- **Books**: "Nmap Network Scanning" by Gordon Lyon
- **Courses**: Hack4u, INE Security, Offensive Security

---

## 📧 Contact

**Manuel Sánchez Gutiérrez**  
- Email: manoloadra2@gmail.com  
- LinkedIn: [linkedin.com/in/manuel-sanchez-gutierrez](https://www.linkedin.com/in/manuel-sanchez-gutierrez-b534ab336/)  
- GitHub: [github.com/Elabdera](https://github.com/Elabdera)

---

## 📄 License

This project is under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

## 🌟 Acknowledgments

- To the Bash scripting community for their resources
- To the creators of Nmap for inspiring this educational tool
- To Hack4u for ethical pentesting training

---

**Remember**: Knowledge is power, but with great power comes great responsibility. Use this tool ethically and legally.

*"Hack the planet, but do it ethically."*
