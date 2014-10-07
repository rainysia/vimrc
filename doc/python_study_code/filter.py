#!/usr/bin/env python
# coding=utf-8
def f(x): return x % 2 != 0 and x % 3 !=0

a = filter(f, range(2,23))

print a

def cube(x): return x*x*x

b = map(cube, range(2,11))

print b

seq = range(10)
def addi(x,y):
    #print x,y
    #print '--'*20
    return (x+y)

c = map(addi, seq, seq)

#print c

d = reduce(addi, range(1,11))

print d

print '--'*40
m = []

def subtration(x,y):
    global m
    print x,y
    if x > y:
        print "dayu"
        return (x-y)
    elif x < y:
        print 'xiaoyu',x,y
        m.append(y-x)
        return (y-x)
    else:
        print 'dengyu'
        return 0
        pass

e = reduce(subtration, range(10,20))

print e
print '--'*40
print m


def sum(seq):
    def add(x,y): return x+y
    return reduce(add, seq, 0)

g = sum(range(1,29))

print g
