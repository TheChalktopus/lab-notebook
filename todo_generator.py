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

filename = '/Users/ak/roam/lab-files-org/todo.org'
f = open(filename, 'r')
todos = [line for line in f]
f.close()

todo_filename = './docs/todo.md'
f = open(todo_filename, 'a')
write_str = '---\nlayout: tagpage\ntitle: Tasks \ntag: [tasks]\nrobots: noindex\n---\n\n\n'
for line in todos :
    write_str += line+"\n"
f.write(write_str)
f.close()
