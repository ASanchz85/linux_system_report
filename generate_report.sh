#!/bin/bash

OUTPUT="system_report.txt"

echo "Generating system report to $OUTPUT..."

echo "=== Running Processes ===" > "$OUTPUT"
ps aux >> "$OUTPUT"

echo -e "\n=== Running Services ===" >> "$OUTPUT"
systemctl list-units --type=service --state=running >> "$OUTPUT"

echo -e "\n=== All Services (Systemd) ===" >> "$OUTPUT"
systemctl list-units --type=service >> "$OUTPUT"

echo -e "\n=== Running Sockets ===" >> "$OUTPUT"
systemctl list-units --type=socket --state=running >> "$OUTPUT"

echo -e "\n=== Running Timers ===" >> "$OUTPUT"
systemctl list-units --type=timer --state=running >> "$OUTPUT"

echo -e "\n=== Top Snapshot ===" >> "$OUTPUT"
top -b -n1 | head -n 30 >> "$OUTPUT"

echo -e "\n=== Listening Network Services (TCP/UDP) ===" >> "$OUTPUT"
ss -tuln >> "$OUTPUT"

echo -e "\n=== Programs Using Open Ports ===" >> "$OUTPUT"
sudo lsof -i -P -n | grep LISTEN >> "$OUTPUT"

echo -e "\n=== Logged-In Users / Sessions ===" >> "$OUTPUT"
who >> "$OUTPUT"

echo -e "\n=== Last Logged-In Users ===" >> "$OUTPUT"
last -n 10 >> "$OUTPUT"

echo -e "\n=== Network Interfaces and IPs ===" >> "$OUTPUT"
ip address show >> "$OUTPUT"

echo "Report generation completed: $OUTPUT"
