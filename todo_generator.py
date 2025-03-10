#!/usr/bin/env python

'''
based on tag_generator.py
Copyright 2017 Long Qian
Contact: lqian8@jhu.edu
'''


import glob
import os


todo_html_filename = './docs/todo.html'
f = open(todo_html_filename, 'r')
todos = [line for line in f]
f.close()
try :
    os.remove(todo_html_filename)
except:
    pass
f = open(todo_html_filename, 'a')
write_str = '---\nlayout: default\ntitle: Tasks \n---\n\n\n'
for line in todos :
    write_str += line+"\n"
f.write(write_str)
f.close()
