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

#remote chrome



#remote IE
import os
# For Chinese
import sys
reload(sys)
sys.setdefaultencoding('utf-8')

from time import sleep
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities

ie_desired_cap = {'os': 'Windows', 'os_version': '2008', 'browser': 'IE', 'browser_version': '9.0', 'resolution' : '1024x768'}
tommy_remote_url = 'http://192.168.85.123:4444/wd/hub'
derek_remote_url = 'http://192.168.87.72:18181/wd/hub'


# command_executor = 'http://USERNAME:ACCESS_KEY@hub.xxx:80/wd/hub'
driver = webdriver.Remote(
    command_executor=derek_remote_url,
    desired_capabilities=ie_desired_cap)

#google, name=q
driver.get("http://www.baidu.com")
eg_title = "百度"   #有中文,需要import sys   reload(sys)   sys.setdefaultencoding('utf-8')
print driver.title
#print help(driver)

try:
    if not eg_title in driver.title:
        raise Exception("Unable to load ",eg_title," page!")

    elem = driver.find_element_by_name("wd")
    elem.send_keys("synnex")
    elem.submit()
    #two ways to wait, explict & implicit
    #WebDriverWait.until(condition-that-finds-the-element)  #explict
    #driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS)    #implicit
    print driver.title
    sleep(10)
    print '12345\n'
except Exception, e:
    raise e
finally:
    #driver.implicitly_wait(10)
    #driver.set_script_timeout(10)
    driver.quit()
