# Elementos

### Sucursal Montevideo
- Router "R. Montevideo" (2911) - con el modulo agregado de HWIC-2T (para serial) en el primer slot
- Switch "s. 1 Montevideo" (2960-24TT)
- Switch "s. 2 Montevideo" (2960-24TT)
- 4 PCs
- Impresora
- 1 Servidor

### Sucursal Melo
- Router "R. Melo" (2911) - con el modulo agregado de HWIC-2T (para serial) en el primer slot
- Switch "s. 1 Melo" (2960-24TT)
- AccessPoint "ap. 1 Melo"
- 2 PCs
- 2 Laptops
- 1 Webcam

### ISP
- Router PT "ISP"


<br>
<br>
<br>

# Conexiones cableadas

### ISP
- Router PT "ISP"
  - Serial 2/0 hacia Montevideo
  - Serial 3/0 hacia Melo

### Montevideo
- Router "R. Montevideo"
  - Serial 0/0/0 hacia ISP Serial 2/0
  - GigabitEthernet 0/1 hacia switch "s. 1 Montevideo"
  - GigabitEthernet 0/2 hacia switch "s. 2 Montevideo"

- Switch "s. 1 Montevideo"
  - FastEthernet 0/1 al 0/4 estan conectadas las PCs
  - FastEthernet 0/5 esta la impresora

- Switch "s. 2 Montevideo"
  - FastEthernet 0/1 esta el servidor

### Melo
- Router "R. Melo"
  - Serial 0/0/0 hacia ISP Serial 3/0
  - GigabitEthernet 0/1 hacia switch "s. 1 Melo"
  - GigabitEthernet 0/2 hacia AccessPoint "ap. 1 Melo"

- Switch "s. 1 Melo"
  - FastEthernet 0/1 al 0/2 estan conectadas las PCs

- AccessPoint "ap. 1 Melo"
  - 2 Laptops
  - Webcam


<br>
<br>
<br>

# Configuraciones

## ISP

> [!WARNING]
> El cable serial se tiene que conectar desde el router (ISP) hacia el router de la sucursal, no al reves.

#### Comandos iniciales
- enable
- configure terminal
- hostname ISP

#### ISP hacia Montevideo
La interfaz `s2/0` es la que esta conectada al router de Montevideo.

- interface s2/0
- ip address 200.100.100.1 255.255.255.252
- clock rate 64000
- no shutdown
- exit

#### ISP hacia Melo
La interfaz `s3/0` es la que esta conectada al router de Melo.

- interface s3/0
- ip address 200.100.100.5 255.255.255.252
- clock rate 64000
- no shutdown
- exit

<br>

## R. Montevideo (Router)

#### Comandos iniciales
- enable
- configure terminal
- hostname R-Montevideo

#### R. Montevideo hacia ISP
En la `s0/0/0` esta conectado al ISP

- interface s0/0/0
- ip address 200.100.100.2 .255.255.255.252
- no shutdown
- exit

#### R. Montevideo hacia s.1 Montevideo
En la `g0/1` esta conectado el switch s.1 Montevideo

- interface g0/1
- ip address 192.168.10.1 255.255.255.0
- no shutdown
- exit

#### R. Montevideo hacia s.2 Montevideo
- Pendiente

## R. Melo (Router)

#### Comandos iniciales
- enable
- configure terminal
- hostname R-Melo
