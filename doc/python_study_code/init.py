#!/usr/bin/env python
# coding=utf-8
class FooBar():
    """docstring for FooBar"""
    def __init__(self):
        self.somevar = 42

a = FooBar()
print a.somevar

class FooBar2():
    """docstring for FooBar2"""
    def __init__(self, arg = 42):
        self.somevar = arg

b = FooBar2(20)
print b.somevar
