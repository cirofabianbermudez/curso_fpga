#!/bin/bash

# Variables predeterminadas
archivo=""
flag_v=false

# Función para mostrar el mensaje de ayuda
mostrar_ayuda() {
    echo "Uso: simu_linux.sh <archivo> [opciones]"
    echo "Opciones:"
    echo "    -v: Open wave viewer."
}

# Procesar los argumentos de línea de comandos
while [[ $# -gt 0 ]]; do
    case $1 in
        -v) flag_v=true; shift;;
         *)
             if [[ $1 == -* ]]; then
                echo "Opción inválida: $1"
                mostrar_ayuda
                read -p "Press enter to continue"
                exit 1
            else
                archivo=$1
                shift
            fi
            ;;
    esac
done

# Verificar si se proporcionó el nombre del archivo
if [[ -z $archivo ]]; then
    echo "Debe especificar el nombre del archivo."
    mostrar_ayuda
    read -p "Press enter to continue"
    exit 1
fi

# Generar nombres dinamicos
v=".v"
vvp=".vvp"
vcd=".vcd"
v_file="${archivo}${v}"
vvp_file="${archivo}${vvp}"
vcd_file="${archivo}${vcd}"

# Verificar si el archivo existe
if [[ ! -e $v_file ]]; then
    echo "El archivo $v_file no existe."
    mostrar_ayuda
    read -p "Press enter to continue"
    exit 1
fi

# Ejecutar comandos en secuencia
echo "1. Compiling verilog code..."
iverilog -o $vvp_file $v_file
echo "2. Runing simulation..."
vvp $vvp_file

# Acción dependiendo de la bandera
if $flag_v; then
    echo "3. Opening wave viewer.."
    open -a gtkwave $vcd_file
fi

read -p "Press enter to continue"
