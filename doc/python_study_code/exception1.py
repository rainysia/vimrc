#!/usr/bin/env python
# coding=utf-8
class MuffledCalc:
    muffled = False
    def calc(self, expr):
        try:
            return eval(expr)
        except ZeroDivisionError:
            if  self.muffled:
                print 'Division by zero is illegal!'
            else:
                raise

ca = MuffledCalc()
ca.calc('10/2')
#ca.calc('10/0')
ca.muffled = True
ca.calc('10/0')
