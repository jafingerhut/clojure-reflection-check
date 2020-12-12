#! /bin/bash

LOGF="$1"

echo ""
echo "----------------------------------------------------------------------"
echo "Software version info"
echo "----------------------------------------------------------------------"
sed -n '/^VERSION INFO BEGIN/,/^VERSION INFO END/p' "${LOGF}"

echo ""
echo "----------------------------------------------------------------------"
echo "BUILD FAILURE"
echo "----------------------------------------------------------------------"
grep "BUILD FAILURE" "${LOGF}"

echo ""
echo "----------------------------------------------------------------------"
echo "[ERROR]"
echo "----------------------------------------------------------------------"
# Note: There are special terminal escape codes for bold or
# colorization or something like that, matched by the .* occurrences
# in the grep regex below.
grep "\[.*ERROR.*\] " "${LOGF}"

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
# Note: There are special terminal escape codes for bold or
# colorization or something like that, matched by the .* occurrences
# in the grep regex below.
grep "\[.*WARNING.*\] " "${LOGF}" | sort

echo ""
echo "----------------------------------------------------------------------"
echo "Reflection warnings"
echo "----------------------------------------------------------------------"
grep 'Reflection warning,' "${LOGF}" | sort
