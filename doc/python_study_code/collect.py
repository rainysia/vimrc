#!/usr/bin/env python
# coding=utf-8
def print_params(*params):
    print params

print_params(1,2,3)
print_params('Testing')

def print_params_2(title, *params):
    print title
    print params

print_params_2('CEO','Tom','Nico','Deb')

print_params_2('CEO')

#print_params_2(test='CEO', 'Tom')
print '--'*40
def print_p(x,y,z=3, *pops, **keypars):
    print x,y,z
    print pops
    print keypars
    print 'end' + '--'*10

print_p(1,2,3,4,5,67,a='12',b='hel',c=3)

print_p(1,2)
