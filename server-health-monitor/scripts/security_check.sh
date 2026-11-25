#!bin/bash
check_security() {
  local rc=0 fails root
  if [[ ! -r /var/log/secure ]]; then
    log_warn "Cannot read /var/log/secure"
    return 1
  fi
  fails=$(grep -c "Failed password" /var/log/secure)
  log_info "Failed SSH logins: $fails"
  if (( fails >= FAILED_LOGINS_CRITICAL )); then
    log_error "Failed logins CRITICAL: $fails"
    rc=2
  elif (( fails >= FAILED_LOGINS_WARNING )); then
    log_warn "Failed logins WARNING: $fails"
    rc=1
  fi
  root=$(sshd -T 2>/dev/null | grep -i permitroot)
  root=${root##* }
  if [[ "$root" == "yes" ]]; then
    log_warn "SSH root login is enabled"
    if (( rc < 1 )); then
      rc=1
    fi
  else
    log_info "SSH root login OK ($root)"
  fi
  return $rc
}






