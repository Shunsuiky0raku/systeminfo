#! /bin/bash

display_menu() {
    echo "Select an option to view system specifications:"
    echo "1. Basic System Information"
    echo "2. CPU Information"
    echo "3. Memory (RAM) Information"
    echo "4. Storage Information"
    echo "5. GPU Information"
    echo "6. Network Information"
    echo "7. Motherboard and BIOS Information"
    echo "8. All Hardware Overview"
    echo "9. Installed Drivers"
    echo "10. Temperature Sensors"
    echo "0. Exit"  
}

while true; do 
  display_menu
  read -p "Enter your choice [0-10]: " choice
  echo

  case $choice in 
        1)
            echo "Basic System Information:"
            uname -a
            hostnamectl
            ;;
        2)
            echo "CPU Information:"
            lscpu
            ;;
        3)
            echo "Memory (RAM) Information:"
            free -h
            echo
            cat /proc/meminfo
            ;;
        4)
            echo "Storage Information:"
            lsblk
            echo
            df -h
            ;;
        5)
            echo "GPU Information:"
            lspci | grep -i vga
            if command -v glxinfo &> /dev/null; then
                echo
                glxinfo | grep "OpenGL renderer"
            else
                echo "Install mesa-utils for more GPU details (sudo pacman -S mesa-utils)."
            fi
            ;;
        6)
            echo "Network Information:"
            ip link
            ;;
        7)
            echo "Motherboard and BIOS Information:"
            sudo dmidecode -t system
            echo
            sudo dmidecode -t bios
            ;;
        8)
            echo "All Hardware Overview:"
            if command -v lshw &> /dev/null; then
                sudo lshw -short
            else
                echo "Install lshw for detailed hardware information (sudo pacman -S lshw)."
            fi
            ;;
        9)
            echo "Installed Drivers:"
            lsmod
            echo
            lspci -k
            ;;
        10)
            echo "Temperature Sensors:"
            if command -v sensors &> /dev/null; then
                sensors
            else
                echo "Install lm_sensors for temperature readings (sudo pacman -S lm_sensors)."
            fi
            ;;
        0)
            echo "Exiting... Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid choice! Please select a valid option."
            ;;
    esac
    echo
done

