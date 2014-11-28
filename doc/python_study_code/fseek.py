#!/usr/bin/env python
# coding=utf-8
f = open('test2.txt', 'w')
f.write('012345678901234567')
print f.seek(5)
print f.write('Hello, World!')
f.close()
print '--'*20
f = open('test2.txt', 'r')
print f.read()              #01234Hello, World!
print f.tell()              #18
print f.seek(2)
print f.tell()              #2
f.seek(0)
print '--'*20
print f.readline()
print f.readlines()
f = open('test2.txt', 'w')
f.writelines(['hahaha', 'Are u', 'sure'])
f.close()
print '--'*20
f = open('test2.txt', 'r')
print f.tell()
print f.readlines()
print f.tell()
print '--'*20
f = open('test3.txt', 'w')
f.write('this\n')
f.write('is no\n')
f.write('haiku.\n')
f.close()
f = open('test3.txt', 'r')
lines = f.readlines()
f.close()
print lines
lines[1] = "isn't a\n"
f = open('test3.txt', 'w')
f.writelines(lines)
f.close()
f = open('test3.txt', 'r')
print f.read()
