#!/usr/bin/env python
# coding=utf-8
x=int(raw_input("please enter an integer: "))
if x<0:
    x=0
    print "negative"
elif x>0:
    x=1
    print "single"

print x
