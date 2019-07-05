#!/usr/bin/python3
import requests


webpages = ['https://news.ycombinator.com/']
response = requests.get(webpages[0])
print()