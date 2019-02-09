#!/usr/bin/python3
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
						.lower()
	count = new_file_name.count(".") - 1
	new_file_name = new_file_name.replace(".", "", count)
	return re.sub('_+','_', new_file_name)

for file_name in os.listdir():
	new_file_name = format_file_name(file_name)
	os.rename(file_name, new_file_name)