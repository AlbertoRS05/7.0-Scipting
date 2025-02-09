$par = 0
$impar = 0
 
0..365 | foreach{
    $dia = ([datetime]"01/01/2024 00:00").AddDays($_).Day
    if ($dia %2)
    {
        $impar++
    }
    else
    {
        $par++
    }
}
 
"Días pares: " + $par.ToString()
"Días impares: " + $impar.ToString()