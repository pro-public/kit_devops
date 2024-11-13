#!/bin/bash

# Cargar las variables del archivo .env
if [ -f ".env" ]; then
    source .env
else
    echo "Archivo .env no encontrado. Asegúrate de que exista en el mismo directorio que este script."
    exit 1
fi

# Verificar que las variables se hayan cargado correctamente
if [[ -z "$SERVER1" || -z "$SERVER2" || -z "$REMOTE_PATH" ]]; then
    echo "ERROR: Una o más variables no están definidas en el archivo .env."
    exit 1
fi

# Archivos temporales locales
FILE1="/tmp/file1_$(date +%Y%m%d%H%M%S)"
FILE2="/tmp/file2_$(date +%Y%m%d%H%M%S)"
LOG_FILE="diferencias_$(date +%Y%m%d%H%M%S).log"

# Descargar los archivos de los servidores
echo "Descargando archivo desde $SERVER1..."
ssh $SERVER1 "cat $REMOTE_PATH" > $FILE1

echo "Descargando archivo desde $SERVER2..."
ssh $SERVER2 "cat $REMOTE_PATH" > $FILE2

# Comparar los archivos
echo "Comparando archivos..."
if command -v colordiff &> /dev/null; then
    colordiff $FILE1 $FILE2 | tee "$LOG_FILE"  # Usar colordiff si está disponible
else
    diff $FILE1 $FILE2 | tee "$LOG_FILE"  # Usar diff si colordiff no está instalado
fi

# Limpiar archivos temporales
rm -f $FILE1 $FILE2

echo "Las diferencias se han guardado en $LOG_FILE"

