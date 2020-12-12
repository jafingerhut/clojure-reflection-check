#! /bin/bash

LOGF="$1"

echo ""
echo "----------------------------------------------------------------------"
echo "'Recompile with' messages"
echo "----------------------------------------------------------------------"
grep 'Recompile with ' "${LOGF}"

echo ""
echo "----------------------------------------------------------------------"
echo "WARNINGS:"
echo "----------------------------------------------------------------------"
grep 'WARNING: ' "${LOGF}"

echo ""
echo "----------------------------------------------------------------------"
echo "[WARNING]"
echo "----------------------------------------------------------------------"
grep '\[WARNING\]' "${LOGF}" | sort

echo ""
echo "----------------------------------------------------------------------"
echo "Reflection warnings"
echo "----------------------------------------------------------------------"
grep 'Reflection warning,' "${LOGF}" | sort
