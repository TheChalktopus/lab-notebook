#!/bin/zsh

emacs -Q --script ~/Sites/math-site/build-site.el
cd ~/Sites/math-site/
git pull origin main
git add -A
git commit -m "building the site again"
git push origin main
