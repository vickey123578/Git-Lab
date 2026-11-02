#!/bin/bash
_ts() { date '+%Y-%m-%d %H:%M:%S'; }
log_info() { echo "[$(_ts)] [INFO] $*"; }
log_warn() { echo "[$(_ts)] [WARN] $*"; }
log_error() { echo "[$(_ts)] [ERROR] $*" >&2; }

