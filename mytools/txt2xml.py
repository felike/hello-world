#!/usr/bin/python3

import sys


def insert_line(line, line2):
    a=list(line.split('"'))
    person={}
    person['title'] = a[0]
    person['author'] = a[0]
    if len(a) > 1:
        person['title'] = a[1]
    if len(a) > 2:
            person['journal'] = a[2]

    person['abstract']=line2
    #print(line, a, person)       
    if not data.get(person['title']):
        data[person['title']]=[]
    data[person['title']].append(person)
                 

def output_file(data, out_file):
    f_o=open(out_file,'w', encoding='utf-8')
    f_o.write('<records>\n')
    
    for i in data:
        out_str = '<record>'
        for j in data[i]:
            if j.get('author'):
                out_str += '<authors><author>'+j['author']+'</author></authors>'
            if j.get('title'):
                 out_str += '<title>'+j['title']+'</title>'
            if j.get('journal'):
                out_str += '<secondary-title>'+j['journal']+'</secondary-title>'
            if j.get('abstract'):
                 out_str += '<abstract>'+j['abstract']+'</abstract>'
        out_str += '</record>'
        f_o.write(out_str)
    f_o.write('\n</records>')    
    f_o.close()

file_name=sys.argv[1]
out_file=sys.argv[2]

f=open(file_name,'r',encoding='utf-8')
num=0
data={}
while True:
    line = f.readline()
    if not line: break
    if line == '\n':
        line = f.readline()
        if not line: break

    line2 = f.readline()
    if not line2: break
    insert_line(line, line2)
    num+=1

output_file(data, out_file)
