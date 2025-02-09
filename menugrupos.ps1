clear-host #Limpiamos la terminal
function menu{ #Declaramos una función menu y que muestre las distintas opciones
@"

    1) Listar grupos

    2) Ver miembros de un grupo

    3) Crear grupo (pide nombre grupo)

    4) Elimina grupo (pide grupo)

    5) Crea miembro de un grupo (pide grupo y usuario)

    6) Elimina miembro de un grupo (Pide grupo y usuario)

    7) Salir

"@
}
#Iniciamos un bucle para el menú
do{ 
#llamamos a la funcion menu, según lo que elija el usuario del switch, hará una opción distinta
    menu
    $gru = Read-Host "Elija una opción: "
    switch($gru){
    
    1 { 
        Get-LocalGroup | select-object name | out-host
    }
    2 { 
       Get-LocalGroup | select-object name | out-host 
       $nombres = Read-Host "Escriba el nombre del grupo: " 
       write-host "Usuarios a mostrar: "
       Get-LocalGroupMember $nombres | out-host
    }
    3{
      $nombre = read-host "Escoja un nombre para el grupo: " 
      new-LocalGroup $nombre
      write-host "El grupo $nombre, fue creado con éxito!"
    }
    4{
      Get-localgroup | select-object name | out-host
      $nombredel = read-host "Escoja un nombre para la eliminación del grupo: "
      remove-localgroup $nombredel 
      Write-host "$nombredel fue eliminado con éxito!"
    }
    5 {
      $usuario = Read-Host "Escoja un nombre del usuario a introducir al grupo: "
      $grupo = Read-host "Escoja el grupo al que desea introducir al usuario: "
      Add-localGroupMember -group $grupo -Member $usuario
      write-host "$usuario se introdujo en $grupo!"
    }
    6{
      $usr = read-host "Escoja el usuario que desea eliminar: "
      $grp = read-host "Escoja el grupo del que desea expulsar a $usr : "
      remove-localgroupmember -Group $grp -Member $usr
      write-host "El usuario $usr fue removid@ de $grp!"
    }
    7{
     write-host "Saliendo..."
    }



}

#Condicional que cerrará el bucle al pulsar la opción 6
}while ($gru -ne 7)
