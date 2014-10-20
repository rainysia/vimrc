#!/usr/bin/env python                    #  1
# coding=utf-8                           #  2
import  fileinput                        #  3
                                         #  4
a = dir(fileinput)                       #  5
print a                                  #  6
                                         #  7
for line in fileinput.input(inplace=True): #  8
    line = line.rstrip()                 #  9
    num = fileinput.lineno()             # 10
    print '%-40s # %2i' % (line, num)    # 11
