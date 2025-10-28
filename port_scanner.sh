#!/bin/bash

#####################################################################
# Port Scanner - Herramienta de Escaneo de Puertos
# Autor: Manuel Sánchez Gutiérrez
# Fecha: Octubre 2024
# Descripción: Script en Bash para escanear puertos TCP abiertos
# Uso: ./port_scanner.sh <IP> <puerto_inicio> <puerto_fin>
# Ejemplo: ./port_scanner.sh 192.168.1.1 1 1000
# USO EDUCATIVO Y ÉTICO ÚNICAMENTE
#####################################################################

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Banner
print_banner() {
    echo -e "${CYAN}"
    echo "╔═══════════════════════════════════════════════════════════╗"
    echo "║           PORT SCANNER - Herramienta de Pentesting        ║"
    echo "║                   Uso Ético Únicamente                    ║"
    echo "╚═══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Función para verificar si un puerto está abierto
check_port() {
    local host=$1
    local port=$2
    
    # Usar timeout y /dev/tcp para verificar el puerto
    timeout 1 bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null
    
    if [ $? -eq 0 ]; then
        # Intentar obtener el servicio del puerto
        service=$(grep -w "$port/tcp" /etc/services | awk '{print $1}' | head -n1)
        if [ -z "$service" ]; then
            service="unknown"
        fi
        echo -e "${GREEN}[+] Puerto $port/tcp ABIERTO - Servicio: $service${NC}"
        echo "$port,$service" >> "$output_file"
        ((open_ports++))
    fi
}

# Función de ayuda
show_help() {
    echo "Uso: $0 [OPCIONES]"
    echo ""
    echo "Opciones:"
    echo "  -t, --target IP        Host objetivo (obligatorio)"
    echo "  -p, --ports RANGO      Rango de puertos (ej: 1-1000, default: 1-1024)"
    echo "  -o, --output ARCHIVO   Guardar resultados en archivo"
    echo "  -h, --help             Mostrar esta ayuda"
    echo ""
    echo "Ejemplos:"
    echo "  $0 -t 192.168.1.1 -p 1-1000"
    echo "  $0 -t scanme.nmap.org -p 20-100 -o resultados.txt"
    exit 0
}

# Verificar argumentos
if [ $# -eq 0 ]; then
    show_help
fi

# Variables por defecto
target=""
port_start=1
port_end=1024
output_file=""

# Procesar argumentos
while [[ $# -gt 0 ]]; do
    case $1 in
        -t|--target)
            target="$2"
            shift 2
            ;;
        -p|--ports)
            if [[ $2 =~ ^([0-9]+)-([0-9]+)$ ]]; then
                port_start="${BASH_REMATCH[1]}"
                port_end="${BASH_REMATCH[2]}"
            else
                echo -e "${RED}[!] Error: Formato de puertos inválido. Use: inicio-fin${NC}"
                exit 1
            fi
            shift 2
            ;;
        -o|--output)
            output_file="$2"
            shift 2
            ;;
        -h|--help)
            show_help
            ;;
        *)
            echo -e "${RED}[!] Opción desconocida: $1${NC}"
            show_help
            ;;
    esac
done

# Validar target
if [ -z "$target" ]; then
    echo -e "${RED}[!] Error: Debe especificar un host objetivo con -t${NC}"
    exit 1
fi

# Imprimir banner
print_banner

# Verificar si el host es alcanzable
echo -e "${BLUE}[*] Verificando conectividad con $target...${NC}"
if ! ping -c 1 -W 2 "$target" &>/dev/null; then
    echo -e "${YELLOW}[!] Advertencia: El host no responde a ping (puede tener ICMP bloqueado)${NC}"
    echo -e "${YELLOW}[!] Continuando con el escaneo...${NC}"
fi

# Preparar archivo de salida
if [ -n "$output_file" ]; then
    echo "Puerto,Servicio" > "$output_file"
fi

# Información del escaneo
echo -e "${CYAN}[*] Objetivo: $target${NC}"
echo -e "${CYAN}[*] Rango de puertos: $port_start-$port_end ($((port_end - port_start + 1)) puertos)${NC}"
echo -e "${CYAN}[*] Inicio del escaneo: $(date '+%Y-%m-%d %H:%M:%S')${NC}"
echo "============================================================"

# Variables de estadísticas
open_ports=0
start_time=$(date +%s)

# Escanear puertos
echo -e "${BLUE}[*] Escaneando puertos...${NC}\n"

for port in $(seq $port_start $port_end); do
    check_port "$target" "$port" &
    
    # Limitar procesos concurrentes a 100
    if [ $(jobs -r | wc -l) -ge 100 ]; then
        wait -n
    fi
done

# Esperar a que terminen todos los procesos
wait

# Calcular tiempo transcurrido
end_time=$(date +%s)
elapsed=$((end_time - start_time))

# Resumen
echo ""
echo "============================================================"
echo -e "${GREEN}[*] Escaneo completado en $elapsed segundos${NC}"
echo -e "${GREEN}[*] Puertos abiertos encontrados: $open_ports/$((port_end - port_start + 1))${NC}"

if [ -n "$output_file" ]; then
    echo -e "${BLUE}[*] Resultados guardados en: $output_file${NC}"
fi

echo ""
echo -e "${YELLOW}[!] Disclaimer: Esta herramienta es solo para uso educativo y ético.${NC}"
echo -e "${YELLOW}[!] Obtén autorización antes de escanear cualquier sistema.${NC}"
echo ""
