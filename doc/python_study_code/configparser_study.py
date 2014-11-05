#!/usr/bin/env python
# coding=utf-8
'''
#python.txt
[numbers]
pi:3.14159265358979324
[messages]
greeting: Welcome to the area calculation program!
question: Please enter the radius:
result_message: The area is


'''
from ConfigParser import ConfigParser
CONFIGFILE = "python.txt"
config.read(CONFIGFILE)
print config.get('message', 'greeting')
radius = input(config.get('messages', 'question') + ' ')
print config.get('messages', 'result_message')
print config.getfloat('numbers', 'pi') * radius**2
