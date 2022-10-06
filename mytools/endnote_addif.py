#!/usr/bin/python3

import sys



                 

def output_file(data, out_file):
    f_o=open(out_file,'w')
    num=0
    for i in data:
        out_str=",".join(i)
        out_str=out_str.rstrip()+"\n"
        f_o.write(out_str)
        num+=1

    print("output num:%d" % num)    
    f_o.close()
    
def input_endnote():
    f=open(file_name,'r')
    num=0
    while True:
        line = f.readline()
        if not line: break
        a=list(line.split(','))
        endnote.append(a)
        num+=1
    print("endnote num:%d"%num)
        
def input_if():
    f=open(if_file,'r')
    num=0
    while True:
        line = f.readline()
        if not line: break
        a=list(line.split(','))
        ifinfo.append(a)
        num+=1
    print("ifinfo num:%d"%num)

def endnote_if_connect():
    num=0
    for i in endnote:
        for j in ifinfo:
            if i[0].upper()==j[0].upper() or i[1].upper()==j[1].upper() or i[2].upper()==j[1].upper():
                i[3]=i[3].rstrip()+" "+year+":"+j[2]
                num+=1
                break

    print("connect num:%d"%num)

file_name=sys.argv[1]
out_file=sys.argv[2]
if_file=sys.argv[3]
year= sys.argv[4]

f=open(file_name,'r')
num=0
endnote=[]
ifinfo=[]
              
input_endnote()
input_if()
endnote_if_connect()
output_file(endnote, out_file)
