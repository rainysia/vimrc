#!/usr/bin/env python
# coding=utf-8
import re
some_text = 'alpha, beta,,,,gamma delta'
a = re.split('[, ]+', some_text)
print a

