#!/usr/bin/env python
# coding=utf-8
for i,v in enumerate(range(2,10)):
    print(i,v)

print '--'*40
ques = ['name','quest','favorite color']
ans = ['lancelot', 'the holy grail', 'blue']
for q,a in zip(ques,ans):
    print 'what is your {0}? It is {1}.'.format(q,a)
