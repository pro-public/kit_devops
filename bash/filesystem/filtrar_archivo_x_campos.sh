#!/bin/bash
#https://github.com/pro-public/
if [ $# -eq 0 ]
  then
        echo "Sin argumentos, debe pasar el nombre del proceso como parámetro."
        exit
    else
        if [ -z "$1" ]
          then
            echo "El argumento proporcionado no tiene un valor correcto"
            exit
        fi
fi
in_file=$1
echo "Parsea la primer columna, colocando como delimintar a " ""
cut -f1 -d" " $in_file
echo "Cuenta la cantidad de lineas que figuran por cada match y lo ordena"
cut -f1 -d" " $in_file | sort | uniq -c | sort
echo " Lo mismo, pero solo con la ultima linea sin duplicar la salida "
cut -f1 -d" " $in_file | sort | uniq -c | sort | tail -n1
