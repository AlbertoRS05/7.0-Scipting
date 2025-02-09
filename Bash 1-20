#!/bin/bash
#Alberto Romero 2 ºASIR
clear
#Declaramos las funciones uno, por uno, empezando por factorial
factorial(){
#El factorial hará una secuencia guiada por un for, que luego se multiplicará y resultará en el factorial
fac=1
for i in $(seq 1 1 $1)
do
        fac=$((fac*i))
done
        echo "El factorial de $1 es $fac"

}
#Funcion del bisiesto
bisiesto(){
#Crearemos una serie de condiciones, que hagan el resultado de los restos de 4, 100 y 400, si pasa por esos 4 filtros, dirá si es bisiesto o no
an=$1
        if [ $((an % 4)) -eq 0 ] && [ $((an % 100)) -ne 0 ] || [ $((an % 400)) -eq 0 ]
        then
                echo "$1 es un año bisiesto"
        else
                echo "$1 no es un año bisiesto"
        fi
}
#Funcion que coge el modelo del netplan e introduce las redes recogidas en un string
red(){


        if [ $# -ne 5 ]
                then
                echo "Error: Introduce una IP, MASCARA(24), GATEWAY, DNS1 y DNS2 como parámetros"
                return 1
        fi

redc="network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3:
      dhcp4: false
      addresses: [$1/$2]
      routes:
      - to: default
        via: $3
      nameservers:
          addresses: [$4,$5]"

echo "$redc" > /etc/netplan/01-network-manager-all.yaml

echo "Aplicando la configuracion de red..."

netplan apply /etc/netplan/01-network-manager-all.yaml
}
#Funcion de adivina, que admitirá al objeto random y tendrá una serie de intentos, con un bucle e incondicionales
adivina(){

        ale=$(( RANDOM% 100 + 1 ))
        num_usu=0
        intentos=0

        echo $ale

                while [ $num_usu -ne $ale ] && [ $intentos -lt 10 ]
                do
                        read -p "Introduce un numero a introducir " num_usu
                        ((intentos++))

                        if [ $num_usu -gt $ale ]
                        then

                                echo "El numero a adivinar es menor, te quedan $((10 - $intentos)) intentos "

                        elif [ $num_usu -lt $ale ]
                        then
                                echo "El numero a adivinar es mayor, te quedan $((10 - $intentos)) intentos "
                        else
                                echo ""
                        fi
                done

                        if [ $num_usu -eq $ale ]
                                then
                                        echo "GANASTE, EN $intentos INTENTOS "
                        else
                                echo "Lo siento, has perdido en $intentos intentos "
                        fi

}
#Funcion de edad, que según el parámetro que se introduzca, devolverá un valor según el numero introducido, jugando con los condicionales
edad(){

        eda=$1
        if [ $1 -ge 65 ]
                then
                        echo "Estás en la vejez "
        elif [ $1 -ge 40  ]
                then
                        echo "Estás en la Madurez "
        elif [ $1 -ge 18 ]
                then
                        echo "Estás en la juventud "
        elif [ $1 -gt 10 ]
                then
echo "Estás en la infancia"
        else
                echo "Estás en la niñez"
        fi
}
#Funcion que analiza mediante stat, al información completa del fichero pasado por el
fichero(){

        if [ $# -ne 1 ]; then
                echo "Error: Proporcione un nombre de fichero como parámetro"
                return 1
        fi

        arch=$1

        info=$(stat -c "Tamaño: %s bytes%nTipo: %F%nNúmero de inodo: %i%nPunto de montaje: %m" "$arch")
        echo "Información del archivo $arch: $info"

}
#Script que busca el nombre de un fichero, mediante un filtrado, si no existe dará error, si no, lo ubicará y contará las vocales
buscar(){

        file_path=$(find / -type f -name "$1" 2>/dev/null)

        if [ -n "$file_path" ]; then
        # Mostrar directorio y contar vocales
        dir=$(dirname "$(realpath "$file_path")")
        vowels_count=$(tr -cd 'aeiouAEIOU' < "$file_path" | wc -c)

        echo "El fichero $1 se encuentra en el directorio: $dir"
        echo "Número de vocales en el archivo: $vowels_count"
        else
        # Mostrar mensaje de error si el fichero no existe
        echo "Error: El fichero $1 no existe."
        fi

}
# Script que mediante un filtrado, nos contará cuantos ficheros se ubican en el directorio a introducir con ruta completa
contar(){

        if [ ! -d "$1" ]; then

        echo "Error: El directorio no existe."

        return 1

        fi

        cant=$(find "$1" -maxdepth 1 -type f | wc -l)

        echo "En el directorio $1 hay $cant ficheros."

}
#función que indica con el usuario actual, mediante whoami, si existe en /sudoers, siendo la forma más efectiva de filtrarlo con grep
privilegios(){

        usuario=$(whoami)

        if grep -q "^$usuario" /etc/sudoers
        then
                echo "El usuario $usuario tiene permisos administrativos"
        else
                echo "El usuario $usuario no tiene permisos administrativos"
        fi

}
#Funcion que si no encuentra al objeto, nos mostrará que no existe y en caso de ser así, nos dirá los permisos de forma octal
permisoctal(){

        nombre_object=$1

        if [ ! -e "$nombre_object" ]
                then
                        echo "El objecto '$nombre_object' no existe."
                return 1
        fi
        permisos=$(stat $nombre_object | grep Acceso | grep -v 20* | awk ' {print $2} ')
        echo "Los permisos octales de '$nombre_object' son: $permisos "

}
#funcion que encierra otra funcion que restará los parámetros y se dedicará a traducir los numeros romanos desde el numero 1 al 200, todo manteniendose con un bucle while
romano() {
        numrom=""
        read -p "Introduce un número entre 1 y 200: " numdec

        valor(){
        numdec=$(($numdec - $1))
        numrom="${numrom}$2"
        }
        if [ $numdec -gt 200 ] || [ $numdec -lt 1 ]
                then
                        echo "Número incorrecto. Debe estar entre 1 y 200. "
        else
                while [ $numdec -gt 0 ]
                        do
                                if [ $numdec -ge 100 ]
                                then
                                        valor 100 "C"
                                elif [ $numdec -ge 90 ]
                                then
                                        valor 90 "XC"
                                elif [ $numdec -ge 50 ]
                                then
                                        valor 50 "L"
                                        elif [ $numdec -ge 40 ]
                                then
                                        valor 40 "XL"
                                elif [ $numdec -ge 10 ]
                                then
                                        valor 10 "X"
                                elif [ $numdec -ge 9 ]
                                then
                                        valor 9 "IX"
                                elif [ $numdec -ge 5 ]
                                then
                                        valor 5 "V"
                                elif [ $numdec -ge 4 ]
                                then
                                        valor 4 "IV"
                                else
                                        valor 1 "I"
                                fi
                        done

                                echo "El número romano es: $numrom "

                                fi

}

#Funcion que automatiza los usuarios de recorriendo listas con un for, que ejecuta un ls, a continuación dentro del mismo for, hará otro para los directorios, creando así al user
automatizar(){

        usrs=$(ls /mnt/usuarios)

        for usr in ${usrs[@]}
        do
                uname=$(cat /etc/passwd | grep $usr)
                if [ $uname ]
                then
                        echo "El usuario $usr ya existe"
                else
                        echo "Creando al usuario $usr..."
                        useradd -m $usr -s /bin/bash
 fi
                dirs=$(cat /mnt/usuarios/$usr)
                for dir in ${dirs[@]}
                do
                        mkdir /home/$usr/$dir
                done
                if [ $? -eq 0 ]
                then
                        rm -rf /mnt/usuarios/$usr
                fi
        done
}
#Funcion que creará un fichero vacio que pese 1024 kb con condicionales
crear(){

        ficher="fichero_vacio"
        kbs="1024"

        if [ ! -z $1 ]; then
        ficher=$1;
        fi

        if [ ! -z $2 ]; then
        milkb=$2;
        fi

        truncate -s "${kbs}K" $ficher

}
#Funciion algo mas compleja, se comporta igual que la anterior, pero requerirá la comprobación del objeto y añadirá un 1 al final del nombre, sucesivamente así en caso de crear otro hasta el 9
crear2(){

        ficher="fichero_vacio"
        kb="1024"
        numf=0

        if [ ! -z $1 ]; then
        ficher=$1;
        fi

        if [ ! -z $2 ]; then
        kb=$2;
        fi

        while [ -e $ficher ] && [ $numf -lt 9 ]; do
        ((numf++))
        ficher="${ficher%[0-9]}$numf"
        done

        if [ $numf -lt 9 ]; then
        touch $ficher
        truncate -s "${kb}K" $ficher
        else
        echo "Limite alcanzado"

        fi

}
#Funcion que reescribe las vocales por un rango de 1 a 5, cambiando estas por la posicion indicada aeiou por 12345
rescribir(){

#Obtener la palabra del primer argumento
pal="$1"

#Reemplazar las vocales según las especificaciones
pal_mod=$(echo "$pal" | tr 'aeiou' '12345')

echo "$pal_mod Palabra cambiada"
}

#Ls siguiente funcion, contará la cantidad de usuarios ubicados en el directorio /home, por ultimo hará una copia de seguridad compresa en formato .tar.gz
contarusu() {
        #lista de usuarios
        users=$(awk -F: '$6 ~ "/home/" {print $1}' /etc/passwd)
        fecha_actual=$(date +%Y%m%d)

        for user in $users; do
                echo $user
        done
        #por pantalla se pedira un nombre de usuario
        read -p "Ingrese un nombre de usuario: " user_elegido
        #si extiese el usuario
        if [[ "$users" == *"$user_elegido"* ]]; then
                tar -czvf "/home/copiaseguridad/${user_elegido}_${fecha_actual}.tar.gz" -C "/" "home/${user_elegido}"
                echo "COPIA DE SEGURIDAD REALIZADA Y COMPRIMIDA"
        else
                echo "Usuario no valido"
        fi

}

#Funcion que recoge 1 parámetro que es el numero de examenes, sumará las notas con un incremental y por ultimo hará una media, diciendo asó los suspendidos y aprobados
alumnos() {

    numalu=$1

    suma_notas=0

    aprobados=0

    suspendidos=0
while [ $numalu -gt 0 ]; do

        read -p "La nota del alumno es: " nota



    # Verificar si la nota está entre 0 y 10

    if [ "$nota" -ge 0 ] && [ "$nota" -le 10 ]; then

    suma_notas=$((suma_notas + nota))



    # Verificar si el alumno está aprobado, debiendo ser superior o igual a 5

    if [ "$nota" -ge 5 ]; then

    aprobados=$((aprobados + 1))

    else

    suspendidos=$((suspendidos + 1))

    fi

    numalu=$((numalu - 1))

    else

    echo "La nota debe estar comprendida entre 0 y 10. Inténtalo de nuevo."

    continue  # Vuelve al inicio del bucle para solicitar una nueva nota

    fi

    done

    # Media de las notas

    media=$(( suma_notas / $1 ))

    echo "La media de notas es: $media"

    echo "Aprobados: $aprobados"

    echo "Suspendidos: $suspendidos"

}
#La funcion omite los espacios de los ficheros, mediante un bucle for y recorriendo así con un condicional y modificando los espacios con sed
quita_blancos() {
    for archivo in *; do
        if [ -f "$archivo" ] && [[ "$archivo" == *" "* ]]; then
            nuevo_nombre=$(echo "$archivo" | sed 's/ /_/g')
            mv "$archivo" "$nuevo_nombre"
            echo "Renombrado: $archivo -> $nuevo_nombre"
        fi
    done
    echo "Archivos renombrados exitosamente."
}
#Se trata de una funcion que pasará 3 parametros de entrada, siendo $1 el caracter, $2 las columnas y $3 las filas, haciendo así un dibujo de estas
lineas() {

        if [ $3 -ge 1 ] && [ $3 -le 10 ]; then
                for ((f=1; f<=$3; f=f+1)); 
                do
                        if [ $2 -ge 1 ] && [ $2 -le 60 ]; then
                                for ((c=1; c<=$2; c=c+1)); 
                                do
                                        echo -n $1
                                done
                        else
                                echo "Introduce parámetros válidos (entre 1 y 60): "
                        fi
            echo ""
                done
        else
            echo "Introduce parámetros válidos (entre 1 y 10): "
        fi
}
#Script que anañizará el directorio especificado con el parametro de entrada $1 y a continuación su extensión con $2, hará un find e imprimirá las rutas y subdirectorios los cuales se encuentram
       directoriosana() {

        directorio=$(echo "$anadir" | awk '{print $1}')
        extension=$(echo "$anadir" | awk '{print $2}')

        # Usa wc -l para contar el número de líneas (archivos)
        numero_archivos=$(find "$1" -type f -name "*.$2" | wc -l)

        # Imprime las rutas de los subdirectorios donde se encontraron archivos
        subd=$(find "$1" -type f -name "*.$2" -exec dirname {} \; | sort | uniq)

        # Mensaje con el número de archivos
        echo "Tiene $numero_archivos archivos con extension *.$extension en $directorio. Subdirectorios con resultados de la busqueda en $subd"

}
menu(){

op=1

while [ $op -ne 0 ]
do
        echo "----- MENÚ BASH SCRIPTING -----"
        echo -e "\n0) Salir"
        echo " 1) factorial "
        echo " 2) bisiesto "
        echo " 3) configurarred "
        echo " 4) adivina "
        echo " 5) edad "
        echo " 6) fichero "
        echo " 7) buscar "
        echo " 8) contar "
        echo " 9) privilegios "
        echo "10) permisocotal "
        echo "11) romano "
        echo "12) automatizar "
        echo "13) crear 1 "
        echo "14) crear 2 "
        echo "15) reescribir "
        echo "16) contusu "
        echo "17) alumnos "
        echo "18) quita_blancos"
        echo "19) lineas"
        echo "20) analizar"
        echo -e "\n"
        read -p "Selecciona un numero " op
case $op in
  1) read -p "Introduzca un número " nu
           factorial $nu
        ;;
        2) read -p "Introduzca un año (0000) " an
           bisiesto $an
        ;;
        3) read -p "Introduzca una IP, MASCARA (24), GATEWAY, DNS1 y DNS2 " ips
           red $ips
        ;;
        4) adivina
        ;;
        5) read -p "Introduzca una edad " ani
           edad $ani
        ;;
        6) read -p "Introduzca un fichero " f
           fichero $f
        ;;
        7) read -p "Introduzca un nombre de un fichero " fi
           buscar $fi
        ;;
        8) read -p "Introduzca un directorio a contar " co
           contar $co
        ;;
        9) privilegios
        ;;
        10) read -p "Introduzca el nombre del objeto " ob
            permisoctal $ob
        ;;
        11) romano
        ;;
        12) automatizar
        ;;
        13) read -e -p "Introduce el nombre y el tamaño con un espacio de por medio de ellos " cre
            crear1 $cre
        ;;
        14) read -p "Introduce el primer parámetro (Nombre del fichero)" nombre
		  read -p "Introduce el segundo parámetro (Tamaño del fichero)" sizes
		  crear2 $nombre $sizes
        ;;
        15) read -p "Escribe una palabra con vocales " vo
            reescribir $vo
        ;;
        16) contarusu 
        ;;
        17) read -p "Introduzca el numero de alumnos " al
            alumnos $al
        ;;
        18) quita_blancos
        ;;
        19) 
                read -p "Introduce un primer parámetro una letra un caracter cualquiera; " primi
		read -p "Introduce un parámetro de columna (entre el 1 y el 60); " segu
		read -p "Introduce un  parámetro del numero de filas (entre el 1 y el 10); " tercer
		lineas $primi $segu $tercer
        ;;
        20) read -p "Que elemento desea analizar? " ana
            dirana $ana
        ;;    
        *) echo "Opción invalida"
esac
done
}
menu
                                                            
