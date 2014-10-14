#!/usr/bin/env python # coding=utf-8
def checkIndex(key):
    """docstring for checkIndex"""
    if not instance(key, (int, long)): raise TypeError
    if key < 0: raise IndexError

class AirthmeticSequence:
    """docstring for AirthmeticSequence"""
    def __init__(self, start=0, step=1):
        self.start = start
        self.step = step
        self.changed = {}

    def __getitem__(self, key):
        """docstring for __getitem__"""
        checkIndex(key)

        try: return self.changed[key]
        except KeyError:
            return self.start + key*self.tep

    def __setitem__(self, key, value):
        checkIndex(key)
        self.changed(key) = value
