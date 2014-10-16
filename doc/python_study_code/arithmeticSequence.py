#!/usr/bin/env python
# coding=utf-8
def checkIndex(key):
    if not isinstance(key, (int, long)): raise TypeError
    if key<0: raise IndexError

class ArithmeticSequence:
    """docstring for ArithmeticSequence"""
    def __init__(self, start=0, step=1):
        self.start = start
        self.step = step
        self.changed = {}

    def __getitem__(self, key):
        """docstring for __getitem__"""
        checkIndex(key)

        try: return self.changed[key]
        except KeyError:
            return self.start + key*self.step

    def _setitem__(self, key, value):
        checkIndex(key)
        self.changed[key] = value

s = ArithmeticSequence(1,2)
print s
print s[4]
print s[5]
s["four"]
