# Monitor de Sistema en Bash - Documentación Técnica

Este script en **Bash** permite monitorear el estado del sistema en tiempo real, mostrando información sobre el **uso de memoria RAM**, **uso de CPU** y **espacio en disco**. También permite el monitoreo en tiempo real y el almacenamiento de registros en un archivo de log.

##  **Funcionamiento del Script**

El script funciona dentro de un bucle `while true`, lo que significa que se ejecutará continuamente hasta que el usuario seleccione la opción de salir (`8`). 

Cada opción en el menú ejecuta una función específica para obtener información relevante.

##  **Código del Script**

```bash
#!/bin/bash

LOG_FILE="monitoreo.log"

# Función para monitoreo de RAM con submenú
monitor_ram() {
    echo "📊 Opciones de monitoreo de RAM:"
    echo "1) Información general"
    echo "2) RAM usada"
    echo "3) RAM libre"
    read -p "Seleccione una opción: " opcion_ram

    case $opcion_ram in
        1)
            echo "📊 Información general de la RAM:" | tee -a $LOG_FILE
            free -h | tee -a $LOG_FILE
            ;;
        2)
            RAM_USED=$(free -h | awk '/Mem:/ {print $3}')
            echo "💾 RAM usada: $RAM_USED" | tee -a $LOG_FILE
            ;;
        3)
            RAM_FREE=$(free -h | awk '/Mem:/ {print $7}')
            echo "✅ RAM libre (disponible): $RAM_FREE" | tee -a $LOG_FILE
            ;;
        *)
            echo "❌ Opción inválida, regresando al menú principal."
            ;;
    esac
}
```

##  **Explicación de los Comandos Clave**

### **awk**
`awk` es una herramienta de procesamiento de texto utilizada para filtrar y manipular datos de salida.

Ejemplo:
```bash
free -h | awk '/Mem:/ {print $3}'
```
Explicación:
- `/Mem:/` → Busca la línea que contiene "Mem:" en la salida de `free -h`.
- `{print $3}` → Imprime la tercera columna (memoria usada).

### **tee**
`tee` se usa para mostrar la salida en la terminal y simultáneamente escribirla en un archivo.

Ejemplo:
```bash
echo "Información de RAM" | tee -a $LOG_FILE
```
Explicación:
- `tee -a` → Añade la salida al archivo sin sobrescribirlo (`-a` significa append).

### **tail -n 1**
`tail` muestra las últimas líneas de un archivo o salida.

Ejemplo:
```bash
df -h --output=avail / | tail -n 1
```
Explicación:
- `df -h --output=avail /` → Muestra solo la columna de espacio disponible en disco.
- `tail -n 1` → Toma solo la última línea (para evitar imprimir el encabezado).

##  **Explicación del Menú**

Cada opción del menú llama a una función específica:
- **1) Ver uso de memoria RAM** → Llama a `monitor_ram()`
- **2) Ver uso de CPU** → Llama a `monitor_cpu()`
- **3) Ver espacio disponible en disco** → Llama a `monitor_disco()`
- **4, 5, 6) Monitoreo en tiempo real** → Usa `watch` para mostrar datos continuamente.
- **7) Ver registros guardados** → Llama a `ver_logs()`
- **8) Salir** → Termina el script.

##  **Cómo Ejecutar el Script**

```bash
chmod +x monitoreo.sh
./monitoreo.sh
```

 **Listo para usar y monitorear tu sistema en tiempo real **

# Ejemplo de archivo de salida 

[Monitoreo](./monitoreo.log)