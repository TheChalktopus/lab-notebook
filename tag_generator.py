#!/usr/bin/env python

'''
tag_generator.py

Copyright 2017 Long Qian
Contact: lqian8@jhu.edu

This script creates tags for your Jekyll blog hosted by Github page.
No plugins required.
'''


import glob
import os

post_dir = '/Users/ak/roam/lab-files-org/_posts/'
projects_dir = '/Users/ak/roam/lab-files-org/_projects/'
tag_dir = './docs/_tags/'

filenames = glob.glob(post_dir + '*org')
filenames = filenames + glob.glob(projects_dir + '*org')
total_tags = []
for filename in filenames:
    f = open(filename, 'r')
    crawl = False
    for line in f:
        if crawl:
            current_tags = line.strip().split(':') 
            if current_tags[0] == 'tags':
                if (current_tags[1].strip().startswith('[')):
                    clean_tag = ''.join(c for c in current_tags[1] if c not in '[]')
                    list_tags = map(str.strip, clean_tag.split(','))
                    total_tags.extend(list_tags)
                else: 
                    list_tags = map(str.strip, current_tags[1].strip().split())
                    total_tags.extend(list_tags)
                crawl = False
                break
        if line.strip() == '---':
            if not crawl:
                crawl = True
            else:
                crawl = False
                break
    f.close()
total_tags = set(total_tags)

old_tags = glob.glob(tag_dir + '*.md')
for tag in old_tags:
    os.remove(tag)
    
if not os.path.exists(tag_dir):
    os.makedirs(tag_dir)

for tag in total_tags:
    tag_filename = tag_dir + tag.replace(' ', '_') + '.md'
    tag_filename = tag_filename.lower()
    f = open(tag_filename, 'a')
    write_str = '---\nlayout: tagpage\ntitle: \"Tag: ' + tag + '\"\ntag: ' + tag + '\nrobots: noindex\n---\n'
    f.write(write_str)
    f.close()
print("Tags generated, count", total_tags.__len__())
