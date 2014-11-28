#!/usr/bin/env python
# coding=utf-8
import sys
text = sys.stdin.read()
words = text.split()
wordcount = len(words)
print 'WordCount:', wordcount

#cat test.txt | python fcountword.py | sort
