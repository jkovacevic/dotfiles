#!/home/jk/ipython/venv/bin/python
from bs4 import BeautifulSoup
from multiprocessing import Process, Pipe
from os import path as op
import parallel_wget
import shutil
import subprocess
import sys, os
import urllib
import wget
import re

def format_string(file_name):
    new_file_name =  file_name\
                        .replace(" ", "_")\
                        .replace("-", "_")\
                        .replace("–", "_")\
                        .replace(",", "")\
                        .replace("'", "")\
                        .replace("’", "")\
                        .replace("#", "")\
                        .replace("!", "")\
                        .replace("?", "")\
                        .replace("(", "")\
                        .replace(")", "")\
                        .replace("[", "")\
                        .replace("]", "")\
                        .replace("{", "")\
                        .replace("}", "")\
                        .replace("@", "")\
                        .replace("&", "")\
                        .replace("$", "")\
                        .replace("€", "")\
                        .replace("🔴", "")\
                        .lstrip("_")\
                        .lower()
    return new_file_name

thread_url = sys.argv[1]
thread_name = input("Thread name? ")
thread_name = format_string(thread_name)
image_folder = f"{thread_name}/images"

subprocess.call(f"wget -e robots=off -E -H -k -nd -p -P {thread_name} {thread_url}", shell=True)

req = urllib.request.Request(thread_url, headers={'User-Agent': 'Mozilla/5.0'})
html = urllib.request.urlopen(req).read()
soup = BeautifulSoup(html, features='html.parser')
thread = soup.findAll("div", {"class": "thread"})[0]

image_list = thread.findAll("a", {"class": "fileThumb"})
image_url = ["http:" + x['href'].replace("^http:", "") for x in image_list]

print("Found {} images, downloading them to: {}".format(len(image_url), image_folder))
os.makedirs(image_folder, exist_ok=True)
for url in image_url:
    wget.download(url, out=f"{image_folder}/{url.split('/')[-1]}")
