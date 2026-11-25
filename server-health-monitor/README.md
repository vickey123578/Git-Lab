




# Server Health Monitor




A modular Bash tool that checks the health of a Linux server 
(tested on CentOS) and reports Healthy, Warning or Critical.


## What it checks


 - CPU usage
 - Memory usage
 - Disk usage (/)
 - Network (ping and DNS lookup)
 - Services (sshd, crond)
 - Security (failed SSH logins, root login)



## Project structure




    server-health-monitor/
      config/config.conf         thresholds and settings
      scripts/system_health.sh   main script, runs the checks
      scripts/*_check.sh         one file per check
      scripts/lib/logger.sh      logging helper
      logs/                      daily log files


## Usage




     ./scripts/system_health.sh              run all checks
     ./scripts/system_health.sh -c cpu,disk  run selected checks
     ./scripts/system_health.sh -h           show help



## Exit codes



 - 0 = healthy
 - 1 = warning
 - 2 = critical
 - 3 = script error (for example, unknown check name)



## Configuration


Thresholds live in 'config/config.conf':


    CPU_WARNING=70
    CPU_CRITICAL=90
    MEMORY_WARNING=75
    MEMORY_CRITICAL=90
    DISK_WARNING=80
    DISK_CRITICAL=90


Ping and DNS targets, the service list and the failed login
limits are in the same file.



## Logs


Every run is also saved to 'logs/health_YYYY-MM-DD.log'.


## Requirements

bash, bc, systemd
