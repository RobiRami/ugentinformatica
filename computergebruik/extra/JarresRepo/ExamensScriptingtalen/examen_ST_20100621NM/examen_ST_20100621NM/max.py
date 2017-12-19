#!/opt/csw/bin/python

import sys

def maxlen(strings):
  max = 0
  for string in strings:
    if len(string) > max:
      max = len(string)
  return max


if __name__ == "__main__":
  print maxlen(sys.argv[1:])
