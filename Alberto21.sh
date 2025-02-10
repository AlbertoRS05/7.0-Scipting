#!/bin/bash

# Función para registrar archivo descartado
registrar_descartado() {
    local propietario=$1
    local grupo=$2
    local archivo=$3
    echo "$propietario,$grupo,$(date +%d.%m.%Y),$archivo" >> descartados.log
}

# Función para verificar formato de archivo
verificar_formato() {
    local archivo=$1
    local extension="${archivo##*.}"
    local tipo=$(file -i "$archivo" | cut -d";" -f1)

    # Verificar si es una imagen válida
    case $tipo in
        *"image/jpeg"*)
            if [ "$extension" != "jpg" ]; then
                mv "$archivo" "${archivo%.*}.jpg"
            fi
            return 0
            ;;
        *"image/png"*)
            if [ "$extension" != "png" ]; then
                mv "$archivo" "${archivo%.*}.png"
            fi
            return 0
            ;;
        *"image/gif"*)
            if [ "$extension" != "gif" ]; then
                mv "$archivo" "${archivo%.*}.gif"
            fi
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Directorios a procesar
DIRECTORIOS=("Fotografia" "Dibujo" "Imagenes")
ARCHIVOS_ELIMINADOS=0

# Si se proporciona un parámetro (nombre de alumno), activar modo de consulta
if [ $# -eq 1 ]; then
    echo "Consultando archivos eliminados para el alumno: $1"
    grep "^$1" descartados.log | while IFS=',' read -r prop grupo fecha archivo; do
        echo "Archivo: $archivo - Eliminado: $fecha"
        ((ARCHIVOS_ELIMINADOS++))
    done
    echo "Total de archivos eliminados para $1: $ARCHIVOS_ELIMINADOS"
    exit 0
fi

# Procesar cada directorio
for dir in "${DIRECTORIOS[@]}"; do
    echo "Procesando directorio: $dir"

    # Buscar archivos de imagen
    find "$dir" -type f -name "*.jpg" -o -name "*.png" -o -name "*.gif" | while read -r archivo; do
        if ! verificar_formato "$archivo"; then
            propietario=$(stat -c "%U" "$archivo")
            grupo=$(stat -c "%G" "$archivo")
            echo "Eliminando archivo con formato inválido: $archivo"
            registrar_descartado "$propietario" "$grupo" "$archivo"
            rm "$archivo"
        fi
    done
done

exit 0
