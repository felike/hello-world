#!/usr/bin/env python

def filterWord(filename, word):
    f = open(filename)
    f2 = open("result",'w')
    f3 = open(word.strip(),'w')
    
    str = f.read()
    start = str.find("<record>")
    startstr = str[:start]
    
    end = str.find("</records>")
    endstr = str[end:]
    
    str = str[start:end]
    
    res = ""
    fstr = ""
    ne= 0
    begin = 0
    flen = len(str)
    while flen > ne:
        begin = ne
        ne= str.find("<record>",ne+1)
        if ne== -1: ne= flen 
        record = str[begin:ne]
        if record.find(word) == -1:
            res += record
        else :
            fstr += record

        
    f2.write(startstr)
    f2.write(res)
    f2.write(endstr)
    
    f3.write(startstr)
    f3.write(fstr)
    f3.write(endstr)
    print("finish ",word)
    f3.close()
    f2.close()
    f.close()


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

filename = sys.argv[1]
file2 = sys.argv[2]

filters = open(file2).read()
words=filters.split('\r\n')

print(words)
filterWord(filename, words[0])

words2 = words[1:-1]
print(words2)

for i in words2:
    os.rename("result","result1")
    filterWord("result1",i)
merge(words[:-1])
