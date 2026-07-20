#!/bin/bash


clear
echo "==================================================="
echo "          "SERVER HEALTH CHECK REPORT"
echo "==================================================="
echo


echo "[1] Hostname"
hostname
echo


echo "[2] Operating system"
cat /etc/os-release | grep pretty_name
echo


echo "[3] Kernel Version"
uname -r
echo


echo "[4] Uptime"
uptime -p
echo


echo "[5] IP Address"
hostname -I
echo


echo "[6] Disk Usage"
df -h
echo


echo "[7] Memory Usage"
free -h
echo


echo "[8] CPU Load"
uptime
echo

