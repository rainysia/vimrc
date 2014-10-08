#!/usr/bin/env python
# coding=utf-8
x = {}
y = x
x['key'] = 'value'
print y
x = {}
print y
print x

print '-'*50
a = {}
b = a
a['key'] = 'value'
print b
a.clear()
print b
