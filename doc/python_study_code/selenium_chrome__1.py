#!/usr/bin/env python
# coding=utf-8
#chrome
'''
import os
from selenium import webdriver
chromedriver = "/home/softs/selenium/chromedriver"
os.environ["webdriver.chrome.driver"] = chromedriver
driver = webdriver.Chrome(chromedriver)
driver.get("http://baidu.com")
driver.quit()
'''

#firefox(iceweasel)
'''
import os
from selenium import webdriver
browser = webdriver.Firefox()
browser.get('http://www.baidu.com')
browser.save_screenshot('screen.png')
browser.quit()
'''

#remote IE
import os
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities

desired_cap = {'os': 'Windows', 'os_version': '2008', 'browser': 'IE', 'browser_version': '9.0', 'resolution' : '1024x768'}

# command_executor = 'http://USERNAME:ACCESS_KEY@hub.xxx:80/wd/hub'
driver = webdriver.Remote(
    command_executor='http://192.168.87.72:4444/wd/hub',
    desired_capabilities=desired_cap)

driver.get("httpp://www.google.com")
if not "Google" in driver.title:
    raise Exception("Unable to load google page!")

elem = driver.find_element_by_name("q")
elem.send_keys("synnex")
elem.submit()
print driver.title
driver.quit()
