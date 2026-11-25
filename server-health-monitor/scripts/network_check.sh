#!/bin/bash
check_network() {
  local rc=0
  if ping -c 1 -W 2 "$PING_TARGET" > /dev/null 2>&1; then
    log_info "Ping $PING_TARGET OK"
  else
    log_error "Ping $PING_TARGET FAILED"
    rc=2
  fi
  if getent hosts "$DNS_TARGET" > /dev/null; then
     log_info "DNS lookup $DNS_TARGET OK"
  else
     log_error "DNS lookup $DNS_TARGET FAILED"
     rc=2
  fi 
  return $rc
}
