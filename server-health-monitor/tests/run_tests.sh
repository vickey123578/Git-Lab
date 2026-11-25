#!/bin/bash
BASE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT="$BASE/scripts/system_health.sh"
PASS=0
FAIL=0


assert_exit() {
  local expected=$1 desc=$2
  shift 2 
  "$@" > /dev/null 2>&1
  local got=$?
  if (( got == expected )); then
    echo "PASS: $desc"
    PASS=$((PASS + 1))
  else
    echo "FAIL: $desc (got $got)"
    FAIL=$((FAIL + 1))
  fi
} 


assert_exit 0 "help exits 0" "$SCRIPT" -h
assert_exit 3 "Unknown check gives 3" "$SCRIPT" -c foo
assert_exit 3 "bad flag gives 3" "$SCRIPT" -z


echo "Passed: $PASS, Failed: $FAIL"
 
exit "$FAIL"

