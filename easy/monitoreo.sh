#!/bin/bash

while true; do
    clear
    echo "===== MONITOR DE SISTEMA ====="
    echo "1) Ver uso de memoria RAM"
    echo "2) Ver uso de CPU"
    echo "3) Ver espacio disponible en disco"
    echo "4) Salir"
    echo "=============================="
    read -p "Seleccione una opción: " opcion

    case $opcion in
        1)
            echo "Uso de memoria RAM:"
            free -h
            ;;
        2)
            echo "Uso de CPU:"
            top -bn1 | grep "Cpu(s)"
            ;;
        3)
            echo "Espacio disponible en disco:"
            df -h
            ;;
        4)
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo " Opción inválida, intenta de nuevo."
            ;;
    esac
    read -p "Presiona [Enter] para continuar..."
done
