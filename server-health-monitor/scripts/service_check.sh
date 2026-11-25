#!/bin/bash
check_service() {
  local rc=0 svc
  for svc in $SERVICES; do 
    if systemctl is-active --quiet "$svc"; then
      log_info "Service $svc running"
    else
      log_error "Service $svc NOT running"
      rc=2
    fi
  done
  return $rc
}
