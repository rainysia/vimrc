#!/usr/bin/env python
# coding=utf-8
# Measure some strings:
a = ['cat', 'window', 'defenestrate']
for x in a:
    print x, len(x)

for x in a[:]:
    if len(x) > 6: a.insert(2,x)

print a

b = ['Mary','had','a','little','lamb']
for i in range(len(b)):
    print i,b[i]

print b

import sys
sys.stdout.softspace=0
for n in range(2,1000):
    for x in range(2,n):
        if  n % x == 0:
            #print n,'equals',x,'*',n/x
            break
    else:
        sys.stdout.softspace=0
        print (str(n)+","),
