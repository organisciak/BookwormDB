#!/bin/bash

cd STATIC
make
cd ..
echo "enter commit message"
read commitMessage
git pull
git add .
git commit -m "$commitMessage"
git push




