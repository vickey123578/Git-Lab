#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(dirname "$SCRIPT_DIR")"

source "$SCRIPT_DIR/lib/logger.sh"
source "$BASE_DIR/config/config.conf"
source "$SCRIPT_DIR/cpu_check.sh"
source "$SCRIPT_DIR/memory_check.sh"
source "$SCRIPT_DIR/disk_check.sh"

STATUS=0

run_check() {
  "$1"
  local rc=$?
  if (( rc > STATUS )); then
    STATUS=$rc
  fi
}

run_check check_cpu
run_check check_memory
run_check check_disk

exit $STATUS
