#!/usr/bin/env python

'''
based on tag_generator.py
Copyright 2017 Long Qian
Contact: lqian8@jhu.edu
'''


import glob
import os

projects_dir = '/Users/ak/roam/lab-files-org/_projects/'
tag_dir = './docs/_tags/'

filenames = glob.glob('/Users/ak/roam/lab-files-org/todo.org')
f = open(filename, 'r')
todos = [line for line in f]
f.close()

todo_filename = 'todo.md'
f = open(tag_filename, 'a')
write_str = '---\nlayout: tagpage\ntitle: \"Tag: ' + tag + '\"\ntag: [tasks]' + tag + '\nrobots: noindex\n---\n\n\n'
for line in todos :
    write_str.append(line+"\n")
f.write(write_str)
f.close()
print("", total_tags.__len__())
