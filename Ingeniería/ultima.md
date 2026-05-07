# Documento de Especificación de Requerimientos del Software (ERS)
# Sistema de Monitoreo y Control de Viñedos — CosechaSmart

---

## Tabla de Contenidos

1. [Introducción](#introducción)
   - Propósito del Documento
   - Alcance
   - Definiciones
2. [Descripción General](#descripción-general)
   - Perspectiva del Producto
   - Funciones del Producto
   - Restricciones
3. [Requerimientos Específicos](#requerimientos-específicos)
   - Requerimientos Funcionales (RF-001 a RF-005)
   - Requerimientos No Funcionales (NFR-001 a NFR-004)
4. [Casos de Uso](#casos-de-uso)
5. [Interfaz Externa](#interfaz-externa)
6. [Anexos](#anexos)
   - Diagramas
   - Orden y priorización de requerimientos
   - Historial de Cambios

---

## Introducción

### Propósito del Documento

Este documento describe los requerimientos funcionales y no funcionales para el desarrollo del sistema **CosechaSmart**, una plataforma de monitoreo y control inteligente de viñedos basada en tecnología IoT. El objetivo es brindar al personal técnico y de desarrollo una especificación clara y completa que sirva de base para el diseño, implementación y validación del sistema.

### Alcance

El sistema abarca la recolección continua de datos climáticos desde 200 sensores IoT distribuidos en parcelas de viñedo, su visualización en tiempo real, la generación de alertas automáticas ante condiciones críticas (como riesgo de helada), el control remoto de dispositivos físicos (calentadores) y la generación de gráficos predictivos del rendimiento de la cosecha. El sistema estará disponible para tres perfiles de usuario: Ingeniero Agrónomo, Operario de Campo y Propietario.

### Definiciones

| Término | Definición |
|---|---|
| **Parcela** | Unidad geográfica de cultivo delimitada dentro del viñedo, equipada con uno o más sensores IoT. |
| **Sensor IoT** | Dispositivo físico instalado en campo que mide temperatura, humedad del suelo y radiación solar, y envía lecturas cada 5 minutos. |
| **Alerta de helada** | Notificación automática disparada cuando la temperatura de una parcela desciende por debajo de 2 °C durante la madrugada. |
| **Calentador** | Dispositivo físico instalado en las parcelas que puede ser activado local o remotamente para proteger la cosecha. |
| **Modo offline** | Capacidad del sistema de permitir acciones de control (encendido de calentadores) sin requerir conexión activa a internet. |
| **Gráfico predictivo** | Visualización generada por el sistema que proyecta el rendimiento esperado de la cosecha en base a datos climáticos históricos. |
| **Ingeniero Agrónomo** | Usuario técnico que monitorea el estado de las parcelas y recibe alertas. |
| **Operario de Campo** | Usuario que actúa sobre las parcelas desde dispositivos móviles en el terreno. |
| **Propietario** | Usuario con acceso de consulta al estado general y proyecciones del sistema. |

---

## Descripción General

### Perspectiva del Producto

CosechaSmart es un sistema embebido en la infraestructura del viñedo que integra hardware (sensores y calentadores IoT) con una plataforma de software compuesta por un backend de ingesta de datos, una base de datos de series temporales y una interfaz web responsiva. El sistema opera de forma continua (24/7) y debe garantizar alta disponibilidad para proteger la producción agrícola ante eventos climáticos críticos.

### Funciones del Producto

- Visualización en tiempo real del estado de cada parcela mediante mapa interactivo.
- Recepción y almacenamiento continuo de lecturas de 200 sensores IoT.
- Detección automática de condiciones de helada y disparo de alertas.
- Control remoto de calentadores desde interfaz web/móvil, con soporte offline.
- Activación automática de calentadores como respaldo ante falta de respuesta del operario.
- Generación de gráficos predictivos de rendimiento de cosecha.

### Restricciones

- El sistema debe operar en entornos con conectividad intermitente o nula en campo.
- La interfaz debe ser legible bajo luz solar directa (alto contraste, tipografía grande).
- Debe cumplir con normativas de protección de datos aplicables.
- La arquitectura debe escalar para soportar 200+ sensores enviando datos cada 5 minutos de forma sostenida.
- El sistema debe ser compatible con navegadores modernos y dispositivos móviles (tablets de campo).

---

## Requerimientos Específicos

### Requerimiento Funcional RF-001

- **Título:** Visualización del mapa en tiempo real.
- **Descripción:** El sistema debe mostrar un mapa interactivo con el estado actualizado de cada parcela, incluyendo temperatura, humedad del suelo y radiación solar, refrescado en intervalos no mayores a 5 minutos.
- **Criterios de Aceptación:** El mapa debe mostrar datos actualizados de todas las parcelas. Cada parcela debe ser seleccionable para ver el detalle de sus métricas. La latencia entre la lectura del sensor y su visualización en el mapa no debe superar los 30 segundos.

---

### Requerimiento Funcional RF-002

- **Título:** Alerta automática de helada.
- **Descripción:** El sistema debe disparar alertas automáticas cuando la temperatura de cualquier parcela descienda por debajo de 2 °C durante el horario de madrugada (00:00 – 07:00 hs).
- **Criterios de Aceptación:** La alerta debe llegar al Ingeniero Agrónomo y a los operarios asignados a la parcela afectada. El tiempo máximo desde la detección hasta el envío de la alerta no debe superar los 60 segundos. La alerta debe identificar la parcela afectada y la temperatura registrada.

---

### Requerimiento Funcional RF-003

- **Título:** Control manual de calentadores (offline).
- **Descripción:** El sistema debe permitir que los operarios de campo enciendan y apaguen los calentadores de una parcela desde su tablet, incluso sin conexión a internet, mediante sincronización diferida.
- **Criterios de Aceptación:** La acción de encendido debe ejecutarse y registrarse localmente aunque no haya conexión. Al recuperar conectividad, el estado debe sincronizarse con el servidor central. El operario debe recibir confirmación visual de la acción ejecutada.

---

### Requerimiento Funcional RF-004

- **Título:** Activación automática de calentadores.
- **Descripción:** Si el operario no responde a una alerta de helada dentro de un tiempo configurable (por defecto, 10 minutos), el sistema debe activar los calentadores de la parcela afectada de forma automática.
- **Criterios de Aceptación:** El sistema debe registrar la activación automática con marca de tiempo. Se debe notificar al Ingeniero Agrónomo y al Propietario que se realizó una activación automática. El umbral de tiempo de espera debe ser configurable por un administrador.

---

### Requerimiento Funcional RF-005

- **Título:** Gráficos predictivos de rendimiento de cosecha.
- **Descripción:** El sistema debe generar gráficos que proyecten el rendimiento esperado de la cosecha por parcela, basándose en los datos climáticos históricos almacenados.
- **Criterios de Aceptación:** Los gráficos deben ser accesibles desde cualquier perfil de usuario. Deben actualizarse al menos una vez por día con los nuevos datos disponibles. Deben mostrar el rango de variación proyectado (mínimo, esperado, máximo).

---

### Requerimiento No Funcional NFR-001

- **Título:** Disponibilidad continua.
- **Descripción:** El servidor debe operar sin interrupciones las 24 horas del día, los 7 días de la semana, con un SLA mínimo de disponibilidad del 99,5%.
- **Criterios de Aceptación:** El tiempo máximo de caída no planificada no debe superar los 4 minutos por mes. Deben existir mecanismos de failover automático.

---

### Requerimiento No Funcional NFR-002

- **Título:** Usabilidad en campo.
- **Descripción:** La interfaz del mapa y los controles deben tener alto contraste y tipografía de tamaño mínimo 16px para garantizar legibilidad bajo luz solar directa en campo.
- **Criterios de Aceptación:** La interfaz debe cumplir con ratio de contraste WCAG AA (4.5:1 mínimo). Todos los controles principales deben ser operables con guantes de trabajo (elementos táctiles ≥ 48x48px).

---

### Requerimiento No Funcional NFR-003

- **Título:** Rendimiento bajo alta carga.
- **Descripción:** El sistema debe procesar miles de lecturas por hora sin degradación de rendimiento ni pérdida de datos.
- **Criterios de Aceptación:** El sistema debe soportar la ingesta sostenida de al menos 2.400 lecturas por hora (200 sensores × 12 envíos/hora). La tasa de pérdida de datos debe ser inferior al 0,01%. El tiempo de respuesta de la API de ingesta no debe superar los 500ms bajo carga nominal.

---

### Requerimiento No Funcional NFR-004

- **Título:** Escalabilidad de la arquitectura.
- **Descripción:** La arquitectura debe soportar el volumen de datos generado por 200+ sensores con envíos cada 5 minutos de forma sostenida, y permitir incorporar nuevos sensores sin rediseño estructural.
- **Criterios de Aceptación:** Agregar un nuevo sensor al sistema no debe requerir cambios en el código del backend. La arquitectura debe soportar hasta 500 sensores sin cambios de infraestructura base.

---

## Casos de Uso

| ID | Caso de Uso | Actor Principal | Descripción |
|---|---|---|---|
| CU-001 | Monitorear parcelas en tiempo real | Ingeniero Agrónomo | El Ingeniero Agrónomo accede al mapa desde su oficina y visualiza la temperatura, humedad y radiación solar de cada parcela en tiempo real. |
| CU-002 | Disparar alerta de helada | Sistema (automático) | Cuando la temperatura de una parcela baja de 2 °C durante la madrugada, el sistema dispara una alerta automática al Ingeniero Agrónomo y a los operarios de campo. |
| CU-003 | Activar calentadores manualmente | Operario de Campo | El operario recibe la alerta y desde su tablet enciende los calentadores de la parcela afectada sin necesidad de conexión a internet. |
| CU-004 | Activar calentadores automáticamente | Sistema (automático) | Si el operario no responde la alerta dentro de un tiempo determinado, el sistema activa los calentadores de forma automática para proteger la cosecha. |
| CU-005 | Consultar gráficos predictivos de cosecha | Propietario | El propietario ingresa al sistema desde la capital y consulta los gráficos predictivos del rendimiento de la cosecha basados en el clima almacenado. |

---

## Interfaz Externa

- **Sensores IoT:** Los 200 dispositivos de campo se comunican con el backend mediante protocolo MQTT sobre redes celulares (4G/LTE) o Wi-Fi, enviando lecturas en formato JSON cada 5 minutos.
- **Dispositivos de calentadores:** El sistema envía comandos de activación/desactivación a los controladores de calentadores vía MQTT. En modo offline, los comandos se encolan localmente en la tablet del operario y se sincronizan al recuperar conectividad.
- **Interfaz de usuario:** Aplicación web responsiva accesible desde navegadores modernos (Chrome, Firefox, Safari, Edge) en computadoras de escritorio y tablets. No requiere instalación de software adicional.
- **Notificaciones:** El sistema se conectará a un servicio de mensajería externo (push notifications / SMS) para el envío de alertas a los usuarios en campo.

---

## Anexos

### Diagramas

- **Diagrama de casos de uso:** Interacciones entre los actores (Ingeniero Agrónomo, Operario de Campo, Propietario y Sistema) con los casos de uso definidos. *(Ver archivo adjunto: CosechaSmart.drawio)*

---

### Orden y priorización de requerimientos (MoSCoW)

| ID | Requerimiento | Tipo | Prioridad | Criterios de Aceptación |
|---|---|---|---|---|
| RF-002 | Alerta automática de helada | Funcional | **Must** | Alerta en ≤60 seg, identifica parcela y temperatura. |
| RF-003 | Control manual de calentadores (offline) | Funcional | **Must** | Ejecuta acción offline, sincroniza al reconectar. |
| RF-004 | Activación automática de calentadores | Funcional | **Must** | Activa en ≤10 min si operario no responde; registra evento. |
| NFR-001 | Disponibilidad continua (24/7) | No Funcional | **Must** | SLA ≥99,5%; failover automático. |
| NFR-003 | Rendimiento bajo alta carga | No Funcional | **Must** | ≥2.400 lecturas/hora; pérdida <0,01%. |
| RF-001 | Visualización del mapa en tiempo real | Funcional | **Should** | Datos frescos en ≤30 seg; parcelas seleccionables. |
| NFR-004 | Escalabilidad de la arquitectura | No Funcional | **Should** | Soportar 500 sensores sin rediseño. |
| RF-005 | Gráficos predictivos de cosecha | Funcional | **Could** | Actualización diaria; rango mín/esp/máx visible. |
| NFR-002 | Usabilidad en campo | No Funcional | **Could** | Contraste WCAG AA; botones ≥48px. |

---

### Historial de Cambios

| Versión | Fecha | Autor | Cambios |
|---|---|---|---|
| 1.0 | 07/05/2026 | Carlos Morales | Versión inicial del ERS |
