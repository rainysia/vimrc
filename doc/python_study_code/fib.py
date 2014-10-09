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
#print fib

fibs = [0, 1]

num = int(raw_input('How many Fibonacci numbers do you want?'))
for i in range(num-2):
    fibs.append(fibs[-2]+fibs[-1])

print fibs
