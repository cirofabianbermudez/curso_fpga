#!/bin/bash

# Variables predeterminadas
archivo=""
flag_a=false
flag_b=false
flag_c=false

# Función para mostrar el mensaje de ayuda
mostrar_ayuda() {
    echo "Uso: mi_script.sh <archivo> [opciones]"
    echo "Opciones:"
    echo "    -a: Imprime mensaje A."
    echo "    -b: Imprime mensaje B."
    echo "    -c: Imprime mensaje C."
}

# Procesar los argumentos de línea de comandos
while [[ $# -gt 0 ]]; do
    case $1 in
        -a) flag_a=true; shift;;
        -b) flag_b=true; shift;;
        -c) flag_c=true; shift;;
        *) archivo=$1; shift;;
    esac
done

# Verificar si se proporcionó el nombre del archivo
if [[ -z $archivo ]]; then
    echo "Debe especificar el nombre del archivo."
    mostrar_ayuda
    exit 1
fi

# Imprimir mensajes según las banderas especificadas
if $flag_a; then
    echo "Mensaje A"
fi

if $flag_b; then
    echo "Mensaje B"
fi

if $flag_c; then
    echo "Mensaje C"
fi

# Resto del código para trabajar con el archivo especificado
echo "Procesando archivo: $archivo"
# Resto del código para procesar el archivo

read -p "Press enter to continue"