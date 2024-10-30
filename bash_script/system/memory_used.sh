#!/bin/bash
#https://github.com/pro-public/
free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }'