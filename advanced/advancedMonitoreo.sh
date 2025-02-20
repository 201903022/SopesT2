#!/bin/bash

LOG_FILE="monitoreo.log"

# Función para monitoreo de RAM
monitor_ram() {
    RAM_USED=$(free | awk '/Mem:/ {printf "%.2f", $3/$2 * 100}')
    echo "📊 Uso de memoria RAM: $RAM_USED%" | tee -a $LOG_FILE
    free -h | tee -a $LOG_FILE
    if (( $(echo "$RAM_USED > 80" | bc -l) )); then
        notify-send "⚠️ ALTO USO DE RAM: $RAM_USED%"
    fi
}

# Función para monitoreo de CPU
monitor_cpu() {
    CPU_USED=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
    echo "📈 Uso de CPU: $CPU_USED%" | tee -a $LOG_FILE
    top -bn1 | grep "Cpu(s)" | tee -a $LOG_FILE
    if (( $(echo "$CPU_USED > 85" | bc -l) )); then
        notify-send "⚠️ ALTO USO DE CPU: $CPU_USED%"
    fi
}

# Función para monitoreo de Disco
monitor_disco() {
    echo "💾 Espacio disponible en disco:" | tee -a $LOG_FILE
    df -h --output=avail / | tail -n 1 | tee -a $LOG_FILE
}

# Función para ver los registros guardados
ver_logs() {
    echo "📜 Registros guardados en $LOG_FILE:"
    cat $LOG_FILE
}

while true; do
    clear
    echo "===== MONITOR DE SISTEMA ====="
    echo "1) Ver uso de memoria RAM"
    echo "2) Ver uso de CPU"
    echo "3) Ver espacio disponible en disco"
    echo "4) Monitoreo en tiempo real (RAM)"
    echo "5) Monitoreo en tiempo real (CPU)"
    echo "6) Monitoreo en tiempo real (Disco)"
    echo "7) Ver registros guardados"
    echo "8) Salir"
    echo "=============================="
    read -p "Seleccione una opción: " opcion

    case $opcion in
        1) monitor_ram ;;
        2) monitor_cpu ;;
        3) monitor_disco ;;
        4) watch -n 2 free -h ;;
        5) watch -n 2 "top -bn1 | grep 'Cpu(s)'" ;;
        6) watch -n 2 df -h ;;
        7) ver_logs ;;
        8) echo "Saliendo..."; exit 0 ;;
        *) echo "❌ Opción inválida, intenta de nuevo." ;;
    esac
    read -p "Presiona [Enter] para continuar..."
done
