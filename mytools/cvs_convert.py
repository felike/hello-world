#!/usr/bin/python3

import sys


def insert_line(line):
    a=list(line.split(','))
    person={}
    person['name']=a[1]
    person['id']=a[11]
    person['med']=a[3]
    person['med_num']=a[4]
    person['med_money']=a[5]
    person['time']=a[6]
    person['year']=a[12]
           
    if not data.get(person['id']):
        data[person['id']]=[]
    data[person['id']].append(person)
                 

def output_file(data, out_file):
    f_o=open(out_file,'w')
    
    for i in data:
        end_str=''
        years=[]
        for j in data[i]:
            end_str += ','.join([j['time'],j['med'],j['med_num'],j['med_money']])
            end_str += ','
            years.append(j['year'].strip())

        year_str='-'.join(years)
        out_str=i+','+data[i][0]['name']+','+str(len(data[i]))+','+year_str+','+end_str+'\n'
        f_o.write(out_str)
        
    f_o.close()

file_name=sys.argv[1]
out_file=sys.argv[2]

f=open(file_name,'r')
num=0
data={}
while True:
    line = f.readline()
    if not line: break
    insert_line(line)
    num+=1

output_file(data, out_file)
