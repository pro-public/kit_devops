#!/bin/bash

# Cargar las variables de los servidores y rutas desde un archivo .env
if [ -f ".env" ]; then
    source .env
else
    echo "Archivo .env no encontrado. Asegúrate de que exista en el mismo directorio que este script."
    exit 1
fi

# Verificar que las variables se hayan cargado correctamente
if [[ -z "$SERVER1" || -z "$SERVER2" || -z "$REMOTE_DIR" ]]; then
    echo "ERROR: Una o más variables no están definidas en el archivo .env."
    exit 1
fi

# Archivos temporales para almacenar la estructura de los directorios
DIR1="/tmp/estructura_server1_$(date +%Y%m%d%H%M%S)_dirs.txt"
DIR2="/tmp/estructura_server2_$(date +%Y%m%d%H%M%S)_dirs.txt"
LOG_FILE="logs/comparacion_estructura_directorios_$(date +%Y%m%d%H%M%S).log"

# Obtener la estructura de los directorios (solo directorios) en ambos servidores
echo "Obteniendo estructura de directorios desde $SERVER1..."
ssh $SERVER1 "find $REMOTE_DIR -type d | sort" > $DIR1

echo "Obteniendo estructura de directorios desde $SERVER2..."
ssh $SERVER2 "find $REMOTE_DIR -type d | sort" > $DIR2

# Comparar las estructuras de los directorios
echo "Comparando estructuras de los directorios..."

echo "Directorios que están en $SERVER1 pero no en $SERVER2:" | tee -a $LOG_FILE
comm -23 $DIR1 $DIR2 | tee -a $LOG_FILE

echo "" | tee -a $LOG_FILE
echo "Directorios que están en $SERVER2 pero no en $SERVER1:" | tee -a $LOG_FILE
comm -13 $DIR1 $DIR2 | tee -a $LOG_FILE

# Contar las diferencias
DIFF_COUNT=$(comm -3 $DIR1 $DIR2 | wc -l)

echo "" | tee -a $LOG_FILE
echo "Cantidad total de diferencias entre los dos servidores: $DIFF_COUNT" | tee -a $LOG_FILE

# Limpiar archivos temporales
rm -f $DIR1 $DIR2

echo "La comparación se ha completado. Los resultados están en pantalla y en $LOG_FILE."

