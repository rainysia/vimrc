#!/usr/bin/env python
# coding=utf-8
__metaclass__ = type

class Fibs:
    """docstring for Fibc"""
    def __init__(self):
        self.a = 0
        self.b = 1
    def next(self):
        self.a, self.b = self.b, self.a+self.b
        return self.a
    def __iter__(self):
        return self

fibs = Fibs()
for f in fibs:
    if f > 9999999999999999999999999L:
        print 'End Numbers is:',f
        break
    else:
        print f
