#!/bin/bash
#https://github.com/pro-public/
clear
echo "Proocesos de mayor consumo de CPU"
echo " "
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head
echo " "
echo "Segundo listado (incluyen path)..."
echo " "
ps -eo pcpu,pid,user,args | tail -n +2 | sort -k1 -r -n | head -10