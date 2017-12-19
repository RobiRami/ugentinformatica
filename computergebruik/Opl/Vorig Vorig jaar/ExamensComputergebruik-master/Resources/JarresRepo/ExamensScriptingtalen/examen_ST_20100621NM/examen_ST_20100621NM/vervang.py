#!/opt/csw/bin/python

import sys

tfd=dict()
tf=sys.stdin.readline()
for i in range(0,len(tf)-2,2):
        tfd[tf[i]]=tf[i+1]
for line in sys.stdin.readlines():
        print(''.join([(tfd[c] if c in tfd else c) for c in line])),
