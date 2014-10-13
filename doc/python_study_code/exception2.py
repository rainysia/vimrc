#!/usr/bin/env python
# coding=utf-8
while True:
    try:
        x = input('Enter the first number: ')
        y = input('Enter the second number: ')
        value = x/y
        print 'x/y is', value
    except:
        print 'Invalid input, pls try agin!'
    else:
        break


