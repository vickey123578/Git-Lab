echo "Hostname: $(hostname)"
echo "IP Address: $(hostname -I)"
echo "Kernel: $(uname -r)"
echo "Disk usage:"
df -h
echo "Memory:"
free -h

