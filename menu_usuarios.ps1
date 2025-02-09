clear-host
function menu{
@"

                    1) Listar Usuarios
                    2) Crear Usuarios (pide ususario y contraseña)
                    3) Elimina usuarios (pide usuario)
                    4) Modifica usuarios (pide usuario y nuevo nombre)
                    5) Salir


"@
}

do{
     menu
     $lu = read-host "Elige la opción: "
     switch($lu){
     
        1 {
            get-localuser | select-object name | Out-Host
        }  

        2 {
           new-localuser
        }

        3 {
           $user= Read-Host "Introduzca los usuarios que desea eliminar: "
           remove-localuser $user
        }
        4 {
           $users= Read-Host "Introduzca un usuario existente: "
           Rename-LocalUser $users
        }
        5 {
            write-host "Saliendo del menú..."
         }
        default{ write-host "Opción no válida!"
        }
     }








} while ($lu -ne 5)








