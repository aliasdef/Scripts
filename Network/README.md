# NET-HUNTER v3.0

`NET-HUNTER` is a lightweight, interactive Bash script designed to automate network reconnaissance using `nmap` and deliver scan reports instantly to your Telegram chat. Built specifically for CTFs, TryHackMe/HackTheBox grinding, and fast-paced pentest engagements.

Pure Bash, clean `case`-driven logic.

## Key Features

* **6 Scan Modes:** From rapid vulnerability checks to aggressive OS/UDP detection and stealthy `T1` evasion.
* **Auto-Logging:** Automatically saves every scan output into structured, timestamped `.txt` files.
* **Telegram Integration:** Instantly ships the final `.txt` report directly to your private TG bot/channel via `curl` right after the scan finishes.
* **Best Run as Root:** Best executed under root privileges:
```bash
sudo ./net-hunter.sh
```

## Prerequisites

Make sure you have these ready before running the script:
* `nmap` — the scanning engine.
* `curl` — to talk to the Telegram API.
* `root` privileges (required by nmap for raw packet operations like `-sS`, `-O`, etc.).

## Quick Start

1. Clone the repo:
```bash
git clone https://github.com/aliasdef/Scripts/blob/main/Network/
cd Network
```

2. Open the script and paste your Telegram bot credentials:
```bash
BOT_TOKEN="YOUR_BOT_TOKEN_HERE"
CHAT_ID="YOUR_CHAT_ID_HERE"
```

3. Make it executable:
```bash
chmod +x net_hunter.sh
```

4. Fire it up with `sudo`:
```bash
sudo ./net_hunter.sh
```

## Scan Menu Breakdowns

1. **Search vulnerability** — Fires up `nmap --script vuln` at maximum speed (`-T5`) to hunt for low-hanging fruits.
2. **Aggressive mode** — Full OS detection, service versioning, and traceroute (`-A`) pushed via high packet-rate.
3. **Slow and Silent** — Stealth SYN scan (`-sS`) clocked down to `-T1` with packet fragmentation (`-f`) to slip past basic IDS/WAF.
4. **Top 1000 Ports** — Standard recon across the 1000 most common ports.
5. **Top 100 Ports** — Fast-track check on the top 100 most critical entry points.
6. **OS/UDP Detect** — Targeted OS fingerprinting matched with a deep UDP service scan.

## Disclaimer
This tool is built for educational purposes and authorized security auditing only. Do not scan hosts you do not own or have explicit written permission to test. Use responsibly.
