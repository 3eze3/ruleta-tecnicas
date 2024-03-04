# Simulador de Ruleta en Bash

Este es un proyecto que incluye un simulador de ruleta implementado en Bash, inspirado en las técnicas de juego utilizadas en el curso de Hack4You de S4vitar.
 El objetivo de este simulador es demostrar cómo las estrategias de apuestas como la martingala y la inversa Laubourchere pueden llevar a pérdidas consistente
s a largo plazo, mostrando que, en última instancia, la casa siempre gana.

## Características

- **Técnicas de apuestas**: El simulador incluye implementaciones de las estrategias de apuestas de martingala, inversa Laubourchere, Fibonacci, inversa marti
ngala y d'Alembert.
- **Modularización**: Se han aplicado técnicas de modularización para organizar el código en varios archivos y mejorar la legibilidad y mantenibilidad.
- **Personalización de la apuesta inicial**: Aunque el proyecto se inicia con una apuesta base de $20, el usuario tiene la flexibilidad de ingresar su propia 
cantidad de dinero inicial.
- **Documentación y comentarios**: El código está documentado y contiene comentarios para facilitar la comprensión y la colaboración.

## Tecnologías utilizadas

- Bash
- Control de versiones con Git

## Uso

Para ejecutar el simulador, asegúrate de tener Bash instalado en tu sistema. Luego, sigue estos pasos:

1. Clona este repositorio en tu máquina local:

```bash
git clone https://github.com/3eze3/ruleta-tecnicas.git
cd casinoTecnicas
./ruleta.sh -m <dinero_inicial> -t <tecnica_de_apuesta>
```
¡Espero que esto sea lo que necesitas! Si tienes alguna otra solicitud o pregunta, no dudes en decirme.
