#!bin/bash
check_disk() {
  local usage
  usage=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
  log_info "Disk usage (/): ${usage}%"
  if (( usage >= DISK_CRITICAL )); then
    log_error "Disk usage CRITICAL: ${usage}%"
    return 2
  elif (( usage >= DISK_WARNING )); then
    log_warn "Disk usage WARNING: ${usage}$"
    return 1
  else
    log_info "Disk usage OK"
    return 0
  fi
}
