#!/usr/bin/env python
# coding=utf-8
__metaclass__ = type 

class TestIterator:
    """docstring for Test"""
    value = 0
    def next(self):
        self.value += 1
        if self.value > 10: raise StopIteration
        return self.value
    def __iter__(self):
        return self

ti = TestIterator()
a = list(ti)
print a 
