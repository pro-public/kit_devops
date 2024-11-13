#!/bin/bash
#https://github.com/pro-public/
df -h | awk '$NF=="/"{printf "%s\t\t", $5}'