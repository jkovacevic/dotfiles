#!/usr/bin/python3.6
# -*- coding: utf-8 -*-
import os
import re

def format_file_name(file_name):
	new_file_name =  file_name\
						.replace(" ", "_")\
						.replace("-", "_")\
						.replace("–", "_")\
						.replace(",", "")\
						.replace("'", "")\
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
						.lower()
	count = new_file_name.count(".") - 1 if os.path.isfile(file_name) else new_file_name.count(".")
	new_file_name = new_file_name.replace(".", "_", count)
	return re.sub('_+','_', new_file_name)

for file_name in os.listdir():
	new_file_name = format_file_name(file_name)
	os.rename(file_name, new_file_name)