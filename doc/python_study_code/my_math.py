#!/usr/bin/env python
# coding=utf-8
def square(x):
    '''
    Squares a number and returns the result.

    >>> square(2)
    4
    >>> square(3)
    9
    '''
    return x*x

if __name__=='__main__':
    import doctest, my_math
    doctest.testmod(my_math)
