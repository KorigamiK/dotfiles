#!/bin/bash

# Check if the script is being run with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Use sudo to run it."
   exit 1
fi

# Run systemd-inhibit to take an inhibitor lock on the lid switch
systemd-inhibit --what=handle-lid-switch --why="Preventing suspend on lid close" sleep infinity &

echo "Inhibitor lock taken. The system will no longer suspend on lid close. Run this to go back"
echo 'sudo pkill -f "systemd-inhibit --what=handle-lid-switch"'
