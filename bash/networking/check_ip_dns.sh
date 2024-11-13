#!/bin/bash
#https://github.com/pro-public/
echo "Estos son los Servidores DNS para el dominio XXX.xx"
dig NS google.com +short

echo "Preguntando que DNS asignada tiene la ip sgte..."
dig -x 192.168.0.22

dig @8.8.8.8 XXX.xx
dig @thisdccontroler 192.168.0.22
