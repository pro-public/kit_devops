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
# Check si el argumento pasado tiene valor.
proceso=$1 ; lsof -f | grep $proceso