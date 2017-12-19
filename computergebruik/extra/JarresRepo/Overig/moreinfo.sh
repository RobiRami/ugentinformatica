#!/bin/bash
if [ $# -ne 1 ]; then
echo "Usage: $0: uid"
exit 1
fi
if [ ! -r /etc/passwd ]; then
echo "/etc/passwd is not readable"
exit 1
fi
cat /etc/passwd | egrep "^([^:]*):[^:]*:$1:([^:]*):[^:]*:([^:]*):([^:]*)$" | sed -r "s/^([^:]*):[^:]*:$1:([^:]*):[^:]*:([^:]*):([^:]*)$/\1\n\4\n\3\n\2/"
