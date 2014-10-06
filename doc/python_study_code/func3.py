#!/usr/bin/env python
# coding=utf-8
def parrot(voltage, state ="a stiff", action='voom'):
    print "-- This parrot would'n t", action,
    print "if you put", voltage, "volts through it.",
    print "E's", state, "!"
    

d = {"voltage": "four million", "state": "bleedin' demised", "action": "VOOM"}
parrot(**d)
