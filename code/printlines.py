#!/usr/bin/env python
import sys

filename = "welcome.pl"
try:
    with open(filename, "r") as f:
        lines = f.readlines()
        [print(line, end="") for line in lines]
except:
    print("can't open %s: %s %s".format(filename, sys.exc_type, sys.exc_value), file=sys.stderr)
