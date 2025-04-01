#!/bin/zsh
cd ~/Sites/lab-notebook/
python3.13 tag_generator.py
emacs -Q --script ~/Sites/lab-notebook/build-site.el
python3.13 todo_generator.py
git pull
git add -A
git commit -m "building the site again"
git push origin main
