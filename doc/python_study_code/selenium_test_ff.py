#!/usr/bin/env python
# coding=utf-8
import os,sys
reload(sys)
sys.setdefaultencoding('utf-8')

from selenium import webdriver
browser = webdriver.Firefox()
browser.get('http://www.baidu.com')
browser.find_element_by_css_selector("#u1 > a[name=\"tj_login\"]").click()
browser.find_element_by_id("TANGRAM__PSP_8__userName").clear()
browser.find_element_by_id("TANGRAM__PSP_8__userName").send_keys("rainysia")
browser.find_element_by_id("TANGRAM__PSP_8__password").clear()
browser.find_element_by_id("TANGRAM__PSP_8__password").send_keys("Xyl1415926")
browser.find_element_by_id("TANGRAM__PSP_8__submit").click()
#browser.quit()

