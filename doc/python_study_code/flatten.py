#!/usr/bin/env python
# coding=utf-8
nested = [[1,2],[3,4],[5,6],[7]]

def flattern(nested):
    """docstring for flattern"""
    for sublist in nested:
        # code...
        for element in sublist:
            yield element

for num in flattern(nested):
    print num

b = list(flattern(nested))
print b

