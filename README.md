# Port Scanner - TCP Port Scanning Tool

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Bash](https://img.shields.io/badge/Bash-4.0%2B-green.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Linux-blue.svg)](https://www.linux.org/)

**Autor**: Manuel Sánchez Gutiérrez  
**Fecha**: Octubre 2024  
**Propósito**: Herramienta educativa de pentesting para escaneo de puertos TCP

---

## 📋 Descripción

**Port Scanner** es una herramienta de línea de comandos escrita en Bash para escanear puertos TCP en hosts remotos. Desarrollada como parte de mi formación en **Administración de Sistemas Informáticos en Red (ASIR)** y mi especialización en **ciberseguridad**.

Esta herramienta permite identificar rápidamente qué puertos están abiertos en un sistema objetivo, así como los servicios que están ejecutándose en esos puertos.

---

## ✨ Características

- ✅ **Escaneo rápido** usando `/dev/tcp` nativo de Bash
- ✅ **Identificación automática de servicios** mediante `/etc/services`
- ✅ **Procesamiento concurrente** (hasta 100 hilos simultáneos)
- ✅ **Exportación de resultados** a formato CSV
- ✅ **Interfaz colorida** para mejor visualización en terminal
- ✅ **Rangos de puertos personalizables**
- ✅ **Manejo de errores robusto**
- ✅ **Sin dependencias externas** (solo Bash)

---

## 🚀 Instalación

### Requisitos

- Sistema operativo: Linux (Ubuntu, Debian, Kali Linux, etc.)
- Bash 4.0 o superior
- Permisos de ejecución

### Pasos

1. Clonar el repositorio:
```bash
git clone https://github.com/tuusuario/port-scanner.git
cd port-scanner
```

2. Dar permisos de ejecución:
```bash
chmod +x port_scanner.sh
```

3. ¡Listo para usar!

---

## 💻 Uso

### Sintaxis Básica

```bash
./port_scanner.sh -t <IP> -p <rango_puertos>
```

### Opciones

| Opción | Descripción | Ejemplo |
|--------|-------------|---------|
| `-t, --target IP` | Host objetivo (obligatorio) | `-t 192.168.1.1` |
| `-p, --ports RANGO` | Rango de puertos (default: 1-1024) | `-p 1-1000` |
| `-o, --output ARCHIVO` | Guardar resultados en archivo | `-o resultados.txt` |
| `-h, --help` | Mostrar ayuda | `-h` |

### Ejemplos de Uso

**Escanear puertos comunes en un host:**
```bash
./port_scanner.sh -t 192.168.1.1 -p 1-1024
```

**Escanear puertos específicos:**
```bash
./port_scanner.sh -t scanme.nmap.org -p 20-100
```

**Escanear y guardar resultados:**
```bash
./port_scanner.sh -t 10.0.0.1 -p 1-65535 -o scan_results.csv
```

**Escanear puertos web comunes:**
```bash
./port_scanner.sh -t example.com -p 80-443
```

---

## 📊 Salida de Ejemplo

```
╔═══════════════════════════════════════════════════════════╗
║           PORT SCANNER - Herramienta de Pentesting        ║
║                   Uso Ético Únicamente                    ║
╚═══════════════════════════════════════════════════════════╝

[*] Objetivo: scanme.nmap.org (45.33.32.156)
[*] Rango de puertos: 1-1000 (1000 puertos)
[*] Inicio del escaneo: 2024-10-28 15:30:45
============================================================
[*] Escaneando 1000 puertos en 45.33.32.156...
[*] Usando 100 hilos concurrentes

[+] Puerto 22/tcp ABIERTO - Servicio: ssh
[+] Puerto 80/tcp ABIERTO - Servicio: http
[+] Puerto 443/tcp ABIERTO - Servicio: https

============================================================
[*] Escaneo completado en 12.34 segundos
[*] Puertos abiertos encontrados: 3/1000
[*] Resultados guardados en: scan_results.csv

[!] Disclaimer: Esta herramienta es solo para uso educativo y ético.
[!] Obtén autorización antes de escanear cualquier sistema.
```

---

## 🔧 Funcionamiento Técnico

### Método de Escaneo

El script utiliza la característica `/dev/tcp` de Bash para realizar conexiones TCP:

```bash
timeout 1 bash -c "echo >/dev/tcp/$host/$port" 2>/dev/null
```

Si la conexión tiene éxito (código de salida 0), el puerto está abierto.

### Procesamiento Concurrente

Para acelerar el escaneo, el script ejecuta múltiples comprobaciones en paralelo:

```bash
check_port "$target" "$port" &

if [ $(jobs -r | wc -l) -ge 100 ]; then
    wait -n
fi
```

Esto permite escanear hasta 100 puertos simultáneamente, reduciendo significativamente el tiempo total.

### Identificación de Servicios

Los servicios se identifican consultando `/etc/services`:

```bash
service=$(grep -w "$port/tcp" /etc/services | awk '{print $1}' | head -n1)
```

---

## 📚 Casos de Uso

### 1. Auditoría de Seguridad en Red Local

Identificar servicios expuestos en dispositivos de tu red:

```bash
./port_scanner.sh -t 192.168.1.1 -p 1-1024 -o router_scan.csv
```

### 2. Verificación de Firewall

Comprobar si un firewall está bloqueando correctamente ciertos puertos:

```bash
./port_scanner.sh -t servidor.ejemplo.com -p 1-65535
```

### 3. Reconocimiento en Pentesting (Laboratorio)

Fase de reconocimiento en máquinas virtuales de práctica:

```bash
./port_scanner.sh -t 10.10.10.5 -p 1-10000 -o target_recon.csv
```

---

## ⚠️ Disclaimer Legal

**IMPORTANTE**: Esta herramienta es exclusivamente para fines educativos y de pentesting ético.

- ✅ **Permitido**: Usar en tus propios sistemas, laboratorios de práctica (HackTheBox, TryHackMe), máquinas virtuales con permiso explícito
- ❌ **Prohibido**: Usar contra sistemas de terceros sin autorización escrita

El escaneo de puertos no autorizado puede ser ilegal en muchas jurisdicciones. El autor **NO se hace responsable** del uso indebido de esta herramienta.

**Siempre obtén autorización por escrito antes de realizar escaneos en sistemas que no sean de tu propiedad.**

---

## 🎓 Contexto Educativo

Este proyecto fue desarrollado como parte de mi formación en:

- **Grado Superior en Administración de Sistemas Informáticos en Red (ASIR)** - UNIR
- **Certificación eJPT v2** (Junior Penetration Tester) - INE Security
- **Formación en Pentesting Ético** - Hack4u

### Conocimientos Demostrados

- ✅ Scripting avanzado en Bash
- ✅ Comprensión de protocolos TCP/IP
- ✅ Sockets y conexiones de red
- ✅ Procesamiento concurrente en shell
- ✅ Manejo de errores y validación de entrada
- ✅ Documentación técnica profesional

---

## 🔄 Comparación con Nmap

| Característica | Port Scanner (Bash) | Nmap |
|----------------|---------------------|------|
| Velocidad | Media (100 hilos) | Muy rápida |
| Tipos de escaneo | Solo TCP Connect | TCP SYN, UDP, etc. |
| Detección de SO | No | Sí |
| Detección de versiones | No | Sí |
| Dependencias | Ninguna | Requiere instalación |
| Tamaño | ~5 KB | ~30 MB |
| Propósito | Educativo | Profesional |

**¿Cuándo usar este script?**
- Entornos donde no puedes instalar Nmap
- Aprendizaje de conceptos de escaneo de puertos
- Scripts personalizados que necesitan escaneo simple
- Sistemas embebidos con solo Bash disponible

---

## 🛠️ Mejoras Futuras

- [ ] Soporte para escaneo UDP
- [ ] Detección de versiones de servicios
- [ ] Escaneo de rangos de IPs (CIDR)
- [ ] Exportación a formatos JSON y XML
- [ ] Integración con APIs de vulnerabilidades (CVE)
- [ ] Modo silencioso para automatización

---

## 📖 Recursos de Aprendizaje

Si quieres aprender más sobre escaneo de puertos y pentesting:

- **Herramientas profesionales**: Nmap, Masscan, Unicornscan
- **Plataformas de práctica**: HackTheBox, TryHackMe, PentesterLab
- **Libros**: "Nmap Network Scanning" de Gordon Lyon
- **Cursos**: Hack4u, INE Security, Offensive Security

---

## 📧 Contacto

**Manuel Sánchez Gutiérrez**  
- Email: manoloadra2@gmail.com  
- LinkedIn: [linkedin.com/in/manuel-sanchez-gutierrez](https://www.linkedin.com/in/manuel-sánchez-gutiérrez-b534ab336/)  
- GitHub: [github.com/tuusuario](https://github.com/tuusuario)

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.

---

## 🌟 Agradecimientos

- A la comunidad de Bash scripting por sus recursos
- A los creadores de Nmap por inspirar esta herramienta educativa
- A Hack4u por la formación en pentesting ético

---

**Recuerda**: El conocimiento es poder, pero con gran poder viene gran responsabilidad. Usa esta herramienta de forma ética y legal.

*"Hack the planet, but do it ethically."*
