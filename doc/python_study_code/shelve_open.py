#!/usr/bin/env python
# coding=utf-8
import shelve
s = shelve.open('test.data')
s['x'] = ['a', 'b', 'c']
s['x'].append('d')
print s['x']

