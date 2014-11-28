#!/usr/bin/env python
# coding=utf-8
import ConfigParser

configSelenium = ConfigParser.ConfigParser()
configSelenium.read("configParser.conf")
section     = {'Basic' : 'selenium_basic', 'Remote' : 'selenium_remote', 'Local' : 'selenium_local_driver'}
confBasicTestUrl = configSelenium.get(section['Basic'], "test_url")
confBasicRemote  = configSelenium.get(section['Basic'], "remote")
confBasicBrowser = configSelenium.get(section['Basic'], "browser")
confBasicLog     = configSelenium.get(section['Basic'], "log")

confRemote = {'derek' : configSelenium.get(section['Remote'], "derek"), 'tommy' : configSelenium.get(section['Remote'], "tommy")}

confLocalBrowser = {'chrome' : configSelenium.get(section['Local'], "chrome"), 'firefox' : configSelenium.get(section['Local'], "firefox"), 'opera' : configSelenium.get(section['Local'], "opera"), 'ie' : configSelenium.get(section['Local'], "ie")}

print confLocalBrowser['ie']
