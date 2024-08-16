#!/bin/bash
#https://github.com/pro-public/
top -bn1 | grep load | awk '{printf "%.2f%%\t\t\n", $(NF-2)}'
echo " "
top -bn1 | grep load