# Componentes

<br>

## ISP
- Router 2911 "ISP-2". Con el modulo de `HWIC-2T` para comunicacion serial

<br>
<br>

## Sucursal Montevideo
- Router 2911 "r-s-montevideo-2". Con el modulo `HWIC-2T` para comunicacion serial
- Switch 2960-24TT `switch-1-montevideo`
- Switch 2960-24TT `switch-2-montevideo`
- 4 Computadoras
- 1 Impresora
- 1 Servidor PT

<br>
<br>

## Sucursal Melo
- Router 2911 "r-s-melo-2". Con el modulo `HWIC-2T` para comunicacion serial
- Switch 2960-24TT `switch-melo-2`
- 2 Computadoras
- 1 AccesPoint-PT-N
- 1 Webcam

<br>
<br>

# Conexiones

<br>
<br>

Conexiones del ISP
| Origen  | Puerto       | Destino                              | Puerto         |
| ------- | ------------ | -------------------------------------- | -------------- |
| ISP-2   | Serial 0/0/0 | Router Montevideo "r-s-montevideo-2"   | `Serial 0/0/0` |
| ISP-2   | Serial 0/0/1 | Router Melo "r-s-melo-2"                | `Serial 0/0/0` |

<br>
<br>

Conexiones del Router Montevideo "r-s-montevideo-2"
| Origen                        | Puerto                | Destino                       | Puerto                |
| ------------------------------ | --------------------- | ------------------------------ | --------------------- |
| Router `r-s-montevideo-2`       | `Serial 0/0/0`         | ISP-2                          | `Serial 0/0/1`         |
| Router `r-s-montevideo-2`       | `GigabitEthernet0/0`   | Switch `switch-1-montevideo`   | `GigabitEthernet0/1`  |
| Switch `switch-1-montevideo`   | `GigabitEthernet0/2`   | Switch `switch-2-montevideo`   | `GigabitEthernet0/1`  |
| Switch `switch-1-montevideo`   | `FastEthernet 0/1`     | Impresora                      | `FastEthernet 0`      |
| Switch `switch-1-montevideo`   | `FastEthernet 0/2`     | PC                             | `FastEthernet 0`      |
| Switch `switch-1-montevideo`   | `FastEthernet 0/3`     | PC                             | `FastEthernet 0`      |
| Switch `switch-1-montevideo`   | `FastEthernet 0/4`     | PC                             | `FastEthernet 0`      |
| Switch `switch-1-montevideo`   | `FastEthernet 0/5`     | PC                             | `FastEthernet 0`      |
| Switch `switch-2-montevideo`   | `FastEthernet 0/1`     | Servidor                       | `FastEthernet 0`      |

<br>
<br>

Conexiones del Router Melo "r-s-melo-2"
| Origen              | Puerto               | Destino             | Puerto                |
| ------------------- | -------------------- | --------------------- | --------------------- |
| Router `r-s-melo-2` | `Serial 0/0/0`       | ISP-2                  | `Serial 0/0/1`         |
| Router `r-s-melo-2` | `GigabitEthernet0/0` | Switch `switch-melo-2` | `GigabitEthernet0/1`  |
| Switch `switch-melo-2` | `GigabitEthernet0/2` | AP `Access Point0` | `Port 0`             |
| Switch `switch-melo-2` | `FastEthernet 0/1`   | PC                 | `FastEthernet 0`      |
| Switch `switch-melo-2` | `FastEthernet 0/2`   | PC                 | `FastEthernet 0`      |
| AP                   | RED                  | Laptop               | RED                   |
| AP                   | RED                  | Laptop               | RED                   |
| AP                   | RED                  | Webcam               | RED                   |

<br>

# Comandos

### ISP-2
- enable
- configure terminal
- hostname ISP-2

##### Conexiones de ISP-2 a Montevideo
- interface s0/0/0
- ip address 200.100.100.1 255.255.255.252
- clock rate 64000
- no shutdown

##### Conexiones de ISP-2 a Melo
- interface s0/0/1
- ip address 200.100.100.5 255.255.255.252
- clock rate 64000
- no shutdown

<br>

----

### Router `r-s-montevideo-2`
- enable
- configure terminal
- hostname r-s-montevideo-2

##### Conexion de Router a ISP-2
- interface s0/0/0
- ip address 200.100.100.2 255.255.255.252
- no shutdown

##### Conexion de Router a la LAN
- interface g0/0
- ip address 192.168.10.1 255.255.255.0
- no shutdown

#### DHCP
- ip dhcp excluded-address 192.168.10.1 192.168.10.20
- ip dhcp pool montevideo-2
- network 192.168.10.0 255.255.255.0
- default-router 192.168.10.1
- dns-server 8.8.8.8
- exit

### Switch `switch-1-montevideo`
- enable
- conf t
- hostname `switch-1-montevideo`

### Switch `switch-2-montevideo`
- enable
- conf t
- hostname `switch-2-montevideo`

<br>

---------

### Router `r-s-melo-2`
- enable
- configure terminal
- hostname r-s-melo-2

##### Conexion de Router a ISP-2
- interface s0/0/0
- ip address 200.100.100.6 255.255.255.252
- no shutdown

##### Conexion de Router a la LAN
- interface g0/0
- ip address 192.168.20.1 255.255.255.0
- no shutdown

#### DHCP
- ip dhcp excluded-address 192.168.20.50
- ip dhcp excluded-address 192.168.20.1
- ip dhcp pool melo
- network 192.168.20.0 255.255.255.0
- default-router 192.168.20.1
- dns-server 1.1.1.1
- exit

### Switch `switch-melo-2`
- enable
- conf t
- hostname `switch-melo-2`

<br>

# Equipos conectados
  - lan-montevideo
- 4 pc via dhcp
- impresora ip manual 192.168.10.20
- servidor ip manual 192.168.10.10
  - lan-melo
- 2 laptops via dhcp
- 1 webcam ip manual 192.168.20.50

<br>

# Comunicacion entre sucursales
Mismas IPs de WAN y mismas subredes LAN que la topologia 1, las rutas estaticas son identicas.

#### Referencias
[Cisco - ip route](https://www.cisco.com/E-Learning/bulk/public/tac/cim/cib/using_cisco_ios_software/cmdrefs/ip_route.htm)

### Router `r-s-montevideo-2` hacia `r-s-melo-2`
Cualquier paquete que tenga esta `192.168.20.x` de destino se reenvia hacia el ISP-2
- enable
- configure t
- ip route 192.168.20.0 255.255.255.0 200.100.100.1

### Router `r-s-melo-2` hacia `r-s-montevideo-2`
Cualquier paquete que tenga esta `192.168.10.x` de destino se reenvia hacia el ISP-2
- enable
- configure t
- ip route 192.168.10.0 255.255.255.0 200.100.100.5

### Router `ISP-2` hacia ambas sucursales
El ISP-2 reenvia los paquetes entre las LAN
- enable
- configure t
- ip route 192.168.10.0 255.255.255.0 200.100.100.2
- ip route 192.168.20.0 255.255.255.0 200.100.100.6