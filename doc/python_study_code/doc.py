#!/usr/bin/env python
# coding=utf-8
def sf(x):
    'It\'s a test function doc string for your, your input number is x'
    return x*x

print sf.__doc__

print help(sf)
