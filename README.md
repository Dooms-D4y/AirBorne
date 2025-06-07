# BunkX - Professional Deauthentication Tool
 
<img src="https://github.com/Dooms-D4y/BunkX/blob/main/banner.png" alt="BunkX Banner" style="width:100%; max-width:800px;"/>
<p align="center">
  <img src="https://img.shields.io/badge/License-MIT-blue.svg" />
  <img src="https://img.shields.io/github/stars/Dooms-D4y/BunkX?style=social" />
  <img src="https://img.shields.io/github/forks/Dooms-D4y/BunkX?style=social" />
  <img src="https://img.shields.io/github/last-commit/Dooms-D4y/BunkX" />
  <img src="https://img.shields.io/github/issues/Dooms-D4y/BunkX" />
  <img src="https://img.shields.io/github/issues-pr/Dooms-D4y/BunkX" />
  <img src="https://img.shields.io/github/repo-size/Dooms-D4y/BunkX" />
  <img src="https://img.shields.io/github/languages/top/Dooms-D4y/BunkX" />
  <img src="https://img.shields.io/badge/Platform-Linux-blue" />
  <img src="https://img.shields.io/badge/Security-Tested-success?logo=hackaday" />
</p>



## Overview
BunkX is an advanced deauthentication tool designed for security professionals to test wireless network resilience. This powerful bash script leverages the aircrack-ng suite to perform targeted deauthentication attacks, helping identify vulnerabilities in WiFi networks.

**Developed by**: DoomsDay  
**Contact**: [d00mzd4y@proton.me](mailto:d00mzd4y@proton.me)  
**GitHub**: [https://github.com/Dooms-D4y/BunkX](https://github.com/Dooms-D4ySec/BunkX)

+ Legal Use Only - Always obtain proper authorization before testing any network

# Key Features
- 🕵️‍♂️ Automatic MAC Address Spoofing
- 📡 Automatic monitor mode configuration
- 🔍 Network scanning with BSSID/channel detection
- 🎯 Targeted deauthentication attacks
- 📊 Real-time attack monitoring
- 🛡️ Graceful cleanup and network restoration
- 🚦 Ctrl+C interrupt handling
- 🎨 Color-coded interface for intuitive operation

## Prerequisites
- Linux OS (Parrotsec Os or Kali Linux recommended)
- Wireless adapter supporting monitor mode
- Root privileges
- Aircrack-ng suite (sudo apt install aircrack-ng)
- iw utility (`sudo apt install iw`)
- [Aircrack-ng suite](https://www.aircrack-ng.org/)
- [iw utility](https://wiki.archlinux.org/title/Iw)


## Installation

1. sudo apt update
   
2. sudo apt upgrade
   
3. git clone https://github.com/Dooms-D4y/BunkX.git

4. cd BunkX
   
5. chmod +x bunkx.sh


## Usage

sudo ./bunkx.sh

1. Enter your wireless interface (e.g., wlan0)
2. Select target network from the scanned list
3. Attack runs until stopped with Ctrl+C
4. Automatic cleanup restores network settings

## Screenshots

<img src="https://github.com/Dooms-D4y/BunkX/blob/main/scanning.png" alt="Scanning Screenshot" style="width:100%; max-width:800px;"/>

*Network scanning and selection interface*

<img src="https://github.com/Dooms-D4y/BunkX/blob/main/attack.png" alt="BunkX Banner" style="width:100%; max-width:800px;"/>


*Deauthentication attack execution*

# Legal Disclaimer
> ⚠️ # WARNING: BunkX is intended solely for authorized security testing and educational purposes. Unauthorized use against networks without explicit permission is illegal and violates:
> - Computer Fraud and Abuse Act (CFAA)
> - Wireless Telegraphy Act
> - Various international computer misuse laws
> The developer assumes no liability for misuse of this tool. Always obtain written permission before testing any network.

## Protection Measures
BunkX demonstrates vulnerabilities in WPA/WPA2 networks. Protect your networks with:
- WPA3 encryption
- 802.11w (Management Frame Protection)
- Wireless Intrusion Detection Systems (WIDS)
- Network segmentation

## Contributing
Contributions are welcome! Please follow these steps:
1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a pull request

# License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support
For support, bug reports, or feature requests:
- Open a GitHub issue
- Contact [d00mzd4y@proton.me]


Important: This tool demonstrates security vulnerabilities that exist in the 802.11 standard. 
Use responsibly and only on networks you own or have explicit permission to test.
