#!/bin/zsh
cd ~/Sites/lab-notebook/
python3.13 tag_generator.py
emacs -Q --script ~/Sites/lab-notebook/build-site.el
git pull
git add -A
git commit -m "building the site again"
git push origin main
