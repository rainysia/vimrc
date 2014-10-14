#!/usr/bin/env python
# coding=utf-8
def concat(*args, sep = "/"):
    return sep.join(args)

concat("earth","mars","venus")

concat("earth","mars","venus", sep=".")
