#!/usr/bin/python3.7
from lxml import html
import requests
response = requests.get("https://pypi.org/simple/")
tree = html.fromstring(response.content)
package_list = [package for package in tree.xpath('//a/text()')]
for package in package_list:
	print(package)