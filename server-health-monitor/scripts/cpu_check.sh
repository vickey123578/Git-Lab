#!/bin/bash
check_cpu() {
  local line idle usage
  line=$(top -bn1 | grep "Cpu(s)")
  idle=$(echo "$line" | sed 's/.*, *\([0-9.]*\)%* id.*/\1/')
  usage=$(echo "100 - $idle" | bc)
  log_info "CPU usage: ${usage}%"
  if(( $(echo "$usage >= $CPU_CRITICAL" | bc -l) )); then
    log_error "CPU usage CRITICAL: ${usage}%"
    return 2
  elif (( $(echo "$usage >= $CPU_WARNING" | bc -l) )); then
    log_warn "CPU usage WARNING: ${usage}%"
    return 1
  else
    log_info "CPU usage OK"
    return 0
  fi
} 
