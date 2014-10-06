#!/usr/bin/env python
# coding=utf-8
def cheeseshop(*args, **kws):
    for arg in args:
        print arg
    print "_" * 40
    keys = sorted(kws.keys())
    for kw in keys:
        print kw,":",kws[kw]

cheeseshop("haha1", "haha2", "haha444", "haha3",
        ks1="rainysia",
        kee="tommyx",
        ge3="susen")
