#!/bin/zsh
emacs -Q --script ~/Sites/lab-notebook/build-site.el
cd ~/Sites/lab-notebook/
python3.13 -i tag_generator.py
git pull
git add -A
git commit -m "building the site again"
git push origin main
