#!/opt/csw/bin/python

import sys
from max import maxlen

def opmaak(strings):
  max = maxlen(strings)

  print (" %" + str(max) + "s") % strings[0]
  print ("+%" + str(max) + "s") % strings[1]
  print "-" * (max+1)
  print ("=%" + str(max) + "s") % strings[2]


if __name__ == "__main__":
  opmaak(sys.argv[1:])
