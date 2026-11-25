#!/bin/bash
_ts() { date '+%Y-%m-%d %H:%M:%S'; }

_out() {
  echo "$1"
  if [[ -n "$LOG_FILE" ]]; then
    echo "$1" >> "$LOG_FILE"
  fi
}

log_info() { _out "[$(_ts)] [INFO] $*"; }
log_warn() { _out "[$(_ts)] [WARN] $*"; }
log_error() { _out "[$(_ts)] [ERROR] $*" >&2; }
