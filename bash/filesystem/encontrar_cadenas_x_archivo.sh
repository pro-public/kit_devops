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
in_search=$1
grep $in_search *.txt
echo "Cantidad de lineas con la ocurrencia"
grep $in_search *.txt | wc -l
echo "Cantidad de veces que se repite la ocurrencia en la totalidad de los archivos encontrados, x archivo"
grep $in_search *.txt | cut -f1 -d"." | sort | uniq -c
echo "mostra una linea despues de lo encontrado..:"