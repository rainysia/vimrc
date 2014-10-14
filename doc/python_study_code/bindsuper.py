#!/usr/bin/env python
# coding=utf-8
class Bird:
    """docstring for Bird"""
    def __init__(self):
        self.hungry = True
    def eat(self):
        if  self.hungry:
            print 'Aaaah...'
            self.hungry = False
        else:
            print 'No, Thanks!'

b = Bird()
b.eat()
b.eat()

class SongBird(Bird):
    def __init__(self):
        Bird.__init__(self)
        self.sound = 'Squawk!'
    def sing(self):
        print self.sound

sb = SongBird()
sb.sing()

sb.eat()
