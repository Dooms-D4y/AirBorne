# BunkerX - Professional Deauthentication Tool

![BunkerX Banner](https://raw.githubusercontent.com/DoomsDaySec/BunkerX/main/assets/banner.png)

## Overview
BunkerX is an advanced deauthentication tool designed for security professionals to test wireless network resilience. This powerful bash script leverages the aircrack-ng suite to perform targeted deauthentication attacks, helping identify vulnerabilities in WiFi networks.

**Developed by**: DoomsDay  
**Contact**: [d00mzd4y@proton.me](mailto:d00mzd4y@proton.me)  
**GitHub**: [https://github.com/DoomsDaySec/BunkerX](https://github.com/DoomsDaySec/BunkerX)

# Key Features
- 📡 Automatic monitor mode configuration
- 🔍 Network scanning with BSSID/channel detection
- 🎯 Targeted deauthentication attacks
- 📊 Real-time attack monitoring
- 🛡️ Graceful cleanup and network restoration
- 🚦 Ctrl+C interrupt handling
- 🎨 Color-coded interface for intuitive operation

## Prerequisites
- Linux OS (Kali Linux recommended)
- Wireless adapter supporting monitor mode
- Root privileges
- Aircrack-ng suite (sudo apt install aircrack-ng)
- iw utility (`sudo apt install iw`)

## Installation

1. sudo apt update
   
2. sudo apt upgrade
   
3. git clone https://github.com/DoomsDaySec/BunkX.git

4. cd BunkX
   
5. chmod +x Bunkx.sh


## Usage

sudo ./bunkerx.sh

1. Enter your wireless interface (e.g., wlan0)
2. Select target network from the scanned list
3. Attack runs until stopped with Ctrl+C
4. Automatic cleanup restores network settings

## Screenshots
![Network Scanning](https://raw.githubusercontent.com/DoomsDaySec/BunkerX/main/assets/scan.png)
*Network scanning and selection interface*

![Attack in Progress](https://raw.githubusercontent.com/DoomsDaySec/BunkerX/main/assets/attack.png)
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

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support
For support, bug reports, or feature requests:
- Open a GitHub issue
- Contact [d00mzd4y@proton.me]


Important: This tool demonstrates security vulnerabilities that exist in the 802.11 standard. 
Use responsibly and only on networks you own or have explicit permission to test.
