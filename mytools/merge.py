#!/usr/bin/env python
def merge(files):
    f2 = open("all","w")
    f = open(files[0].strip())
    
    str = f.read()
    start = str.find("<record>")
    startstr = str[:start]
    
    end = str.find("</records>")
    endstr = str[end:]
    
    str = str[start:end]
    
    files = files[1:]

    for i in files:
        ff = open(i.strip())
        ss = ff.read()
        end = str.find("</records>")
        str += ss[start:end]
        print("merge",i,"len ",len(str))
        ff.close()

    f2.write(startstr)
    f2.write(str)
    f2.write(endstr)

    f2.close()
    f.close()
import sys
import os

file2 = sys.argv[1]
filters = open(file2).read()
words=filters.split('\r\n')

print(words)
merge(words[:-1])
