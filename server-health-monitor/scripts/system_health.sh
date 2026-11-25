#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(dirname "$SCRIPT_DIR")"

source "$SCRIPT_DIR/lib/logger.sh"
source "$BASE_DIR/config/config.conf"
source "$SCRIPT_DIR/cpu_check.sh"
source "$SCRIPT_DIR/memory_check.sh"
source "$SCRIPT_DIR/disk_check.sh"
source "$SCRIPT_DIR/network_check.sh"
source "$SCRIPT_DIR/service_check.sh"
source "$SCRIPT_DIR/security_check.sh"

LOG_DIR_PATH="$BASE_DIR/$LOG_DIR"
mkdir -p "$LOG_DIR_PATH"
LOG_FILE="$LOG_DIR_PATH/health_$(date +%F).log"

trap 'log_error "Interrupted"; exit 3' INT TERM

usage() {
  echo "Usage: $0 [-c checks] [-h]"
  echo " -c cpu,memory,disk,network,service,security (default: all)"
  echo " -h show this help"
}
 
CHECKS="cpu,memory,disk,network,service,security"

while getopts "c:h" opt; do
  case $opt in
    c) CHECKS="$OPTARG" ;;
    h) usage; exit 0 ;;
    *) usage; exit 3 ;;
  esac
done

STATUS=0

run_check() {
  if ! declare -F "$1" > /dev/null; then
    log_error "Unkonwn check: ${1#check_}"
    STATUS=3
    return
fi
  "$1"
  local rc=$?
  if (( rc > STATUS )); then
    STATUS=$rc
  fi
}

IFS=',' read -ra LIST <<< "$CHECKS"

for name in "${LIST[@]}"; do
  run_check "check_$name"
done


case $STATUS in
  0) log_info "Overall status: HEALTHY" ;;
  1) log_warn "Overall status: WARNING" ;;
  2) log_error "Overall status: CRITICAL" ;;
  *) log_error "Overall status: ERROR" ;;
esac

exit $STATUS











