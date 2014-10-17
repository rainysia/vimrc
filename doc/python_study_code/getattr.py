#!/usr/bin/env python
# coding=utf-8
__metaclass__ = type

class Rectangle:
    """docstring for Rectangle"""
    def __init__(self):
        self.width = 0
        self.height = 0
    def __setattr__(self, name, value):
        if name == 'size':
            self.width, self.height = value
        else:
            self.__dict__[name] = value

    def _getattr__(self, name):
        if name == 'size':
            return self.width, self.height
        else:
            raise AttributeError

r = Rectangle()
r.width = 10
r.height = 15
print r.size()
r.size((150,100))
print r.width
