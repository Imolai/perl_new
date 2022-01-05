#!/usr/bin/env python
import os
import stat
import string

for d in os.environ['PATH'].split(':'):
    try:
        for f in os.listdir(d):
            mode = os.lstat(d + '/' + f)[stat.ST_MODE]
            if not stat.S_ISDIR(mode):
                print(f)
    except FileNotFoundError:
        print(f"Can't open dir {d}: No such file or directory")
