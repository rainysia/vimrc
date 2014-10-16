#!/usr/bin/env python
# coding=utf-8
__metaclass__ = type

class MyClass(object):
    """docstring for ClassName"""
    def smeth():
        """docstring for smeth"""
        print 'this is a static method'
    smeth = staticmethod(smeth)

    def cmeth(cls):
        """docstring for cmeth"""
        print 'This is a class method of:', cls
    cmeth = classmethod(cmeth)
        
class MyClass2:
    """docstring for MyClass2"""
    @staticmethod
    def meth():
        print 'This is s static method'

    @classmethod
    def cmeth(cls):
        """docstring for cm"""
        print 'This is a class method of', cls

a = MyClass()
a.smeth()
a.cmeth()
