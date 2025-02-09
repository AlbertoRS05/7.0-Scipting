function pizzeria{ 
@"
    1) Pizza_Vegetariana
    2) Pizza_Comun
    3) salir

"@


}
do{
    pizzeria
    $pi = read-host "selecciona una opción entre 1-3"
    switch ($pi){
        1{
            write-host "Tiene que escoger entre estos 2 ingredientes"
            write-host "`t1- Tofu"
            Write-Host "`t2- Pimiento"
            $ingredientv = read-host "Escoja el ingrediente que desee: (Mozzarella y tomate ya incluidos)"
            if ($ingredientv -eq 1){
                write-host "Usted eligió la pizza de: Mozzarella, tomate y Tofu"
            } else {
                write-host "Usted eligió la pizza de: Mozzarella, tomate y Pimiento"  
            }
    
        }
        2{
            write-host "Tiene que escoger entre estos 3 ingredientes"
            write-host "`t1 - Peperoni"
            write-host "`t2 - Jamón"
            write-host "`t3 - Salmón"
            $ingredientv = read-host "Escoja el ingrediente que desee: (Mozzarella y tomate ya incluidos)"
            if ($ingredientv -eq 1){
                write-host "Usted eligió la pizza de: Mozzarella, tomate y peperoni"
            } elseif ($ingredientv -eq 2) {
                write-host "Usted eligió la pizza de: Mozzarella, tomate y jamón"  
            } else {
                write-host "Usted eligió la pizza de: Mozzarella, tomate y salmón"
            }
        }
        3{
            write-host "Saliendo del menú..."
        }
        default{ write-host "Opción no válida!"
        }
    } 
} while ($pi -ne 3)