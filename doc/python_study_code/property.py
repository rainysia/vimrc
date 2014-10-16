#!/usr/bin/env python
# coding=utf-8
__metaclass__ = type
class Rectangle:
    """docstring for Rectangle"""
    def __init__(self):
        self.width = 0
        self.height = 0
    def setSize(self, size):
        """docstring for setSize"""
        self.width, self.height = size
    def getSize(self):
        """docstring for getSize"""
        size = propery(getSize, setSize)

r = Rectangle()
r.width = 10
r.height = 15
print r.getSize()
r.setSize((150,100))
print r.width

