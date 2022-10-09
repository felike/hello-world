#! /usr/bin/python3
import datetime
print(datetime.datetime.now())
sum = 0
for i in range(1,100000000):
    sum +=i
print(sum)
print(datetime.datetime.now())
