#!/bin/bash
if [ $# -ne 1 ]; then
echo "Usage: $0: uid"
exit 1
fi
getent passwd $1 | sed -r 's/^[^:]*:[^:]*:[^:]*:([^:]*):([^:]*):([^:]*):([^:]*)/\2\n\3\n\4\n\1/'
