#!/home/jk/ipython/venv/bin/python
import os
import shutil
import subprocess
import sys
import urllib
import wget
import parallel_wget
from bs4 import BeautifulSoup

import sys, os
from os import path as op
import wget
from multiprocessing import Process, Pipe


def wget_parallel(file_urls, folder):

    def wget_file(url, folder, conn):
        try:
          wget.download(url, out=f"{folder}{url.split('/')[-1]}")
          conn.send(1)
          conn.close()
          print()
        except Exception as e:
          pass

    processes = []
    parent_connections = []

    for url in file_urls:            
        parent_conn, child_conn = Pipe()
        parent_connections.append(parent_conn)
        process = Process(target=wget_file, args=(url, folder, child_conn))
        processes.append(process)

    for process in processes:
        process.start()

    for process in processes:
        process.join()


def clear_folder(folder):
    try:
        shutil.rmtree(folder)
    except:
        pass
    os.mkdir(folder)


if len(sys.argv) == 1:
    print("Expecting URL as CLI parameter.")
    exit(-1)


url = sys.argv[1]
folder = "/tmp/images/" if len(sys.argv) == 2 else sys.argv[2]
req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
html = urllib.request.urlopen(req).read()
soup = BeautifulSoup(html, features='html.parser')
thread = soup.findAll("div", {"class": "thread"})[0]

image_list = thread.findAll("a", {"class": "fileThumb"})
image_url = ["http:" + x['href'].replace("^http:", "") for x in image_list]
print("Found {} images, downloading them to: {}".format(len(image_url), folder))
clear_folder(folder)
wget_parallel(image_url, folder)
