#!bin/bash
check_memory() {
  local total avail usage
  total=$(free | awk '/Mem:/ {printf $2}')
  avail=$(free | awk '/Mem:/ {printf $7}')
  usage=$(echo "scale=1; ($total-$avail)*100/$total" | bc)
  log_info "Memory usage: ${usage}%"
  if (( $(echo "$usage >= $MEMORY_CRITICAL" | bc -l) )); then
    log_error "MEMORY usage CRITICAL: ${usage}%"
    return 2
  elif (( $(echo "$usage >= $MEMORY_WARNING" | bc -l) )); then
    log_warn "Memory usage WARNING: ${usage}%"
    return 1
  else
    log_info "Memory usage OK"
    return 0
  fi
}  
