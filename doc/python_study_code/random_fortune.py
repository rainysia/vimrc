#!/usr/bin/env python
# coding=utf-8
import fileinput, random
fortunes = list(fileinput.input())
print random.choice(fortunes)

#python random_fortune.py /usr/dict/words 获取Unix系统中的随机单词
