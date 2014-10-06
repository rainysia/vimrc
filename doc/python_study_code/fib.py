#!/usr/bin/env python
# coding=utf-8
def fib2(n):
    """Return a list containing the Fibonacci series up to n."""
    result = []
    a, b = 0, 1
    while a < n:
        result.append(a)
        a, b = b, a+b
    return str(result).strip()

fib = fib2(200)
print fib
