#!/bin/bash

    local archivo=$1
    
    if [ ! -f "$archivo" ]; then
        echo "Error: El archivo no existe"
        return 1
    fi
    
    while IFS=: read -r nombre apellido1 apellido2 login; do
        if id "$login" >/dev/null 2>&1; then
            local dir_trabajo="/home/$login/trabajo"
            if [ -d "$dir_trabajo" ]; then
                local dir_destino="/home/proyecto/$login"
                mkdir -p "$dir_destino"
                mv "$dir_trabajo"/* "$dir_destino"/ 2>/dev/null
                chown -R root:root "$dir_destino"
                
                local cantidad=$(ls -1 "$dir_destino" | wc -l)
                echo "$(date +%d/%m/%Y-%H:%M:%S)-$login-$dir_destino" >> bajas.log
                ls -1 "$dir_destino" | nl >> bajas.log
                echo "Total de archivos movidos: $cantidad" >> bajas.log
                
                userdel -r "$login"
            else
                echo "$(date +%d/%m/%Y-%H:%M:%S)-$login-$nombre-$apellido1-$apellido2-ERROR:No existe directorio trabajo" >> bajaserror.log
            fi
        else
            echo "$(date +%d/%m/%Y-%H:%M:%S)-$login-$nombre-$apellido1-$apellido2-ERROR:El usuario no existe" >> bajaserror.log
        fi
    done < "$archivo"
