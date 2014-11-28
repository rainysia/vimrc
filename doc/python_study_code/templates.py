#!/usr/bin/env python
# coding=utf-8
import fileinput, re
# 匹配中括号中的字段
filed_pat = re.compile(r'\[(.+?)\]')


