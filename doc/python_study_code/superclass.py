#!/usr/bin/env python
# coding=utf-8
class Calculator:
    def calculate(self, expression):
        self.value = eval(expression)

class Talker:
    def talk(self):
        print 'Hi, my value is', self.value

class TalkingCalculator(Calculator, Talker):
    pass

tc = TalkingCalculator()
tc.calculate('1+20*20')
tc.talk()


