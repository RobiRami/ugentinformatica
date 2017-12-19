#!/opt/csw/bin/python

import sys,re

line=re.sub(r'[^A-Z]','',sys.stdin.read())
line=list(set(line))
line.sort()
print(''.join(line))
