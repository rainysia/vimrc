#!/usr/bin/env python
# coding=utf-8
f1 = open('test.txt', 'w')
print f1.write("Hello!")
print f1.write(", World!")
f1.close()

f2 = open('test.txt', 'r')
print f2.read(4)
print f2.read()

