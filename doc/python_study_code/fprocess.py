#!/usr/bin/env python
# coding=utf-8
def process(string):
    """docstring for process"""
    print "Processing: ",string

f = open('test3.txt')
while True:
    line = f.readline()
    if not line: break
    print line
    process(line)
print f.tell()
f.close()
print '--'*40
f = open('test3.txt')
for line in f:
    process(line)
f.close()
