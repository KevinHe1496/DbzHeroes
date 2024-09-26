
# DragonBallHeroes App

**DragonBallHeroes** es una aplicación iOS desarrollada en Swift, diseñada para mostrar a los personajes de Dragon Ball Z junto con sus transformaciones. El proyecto combina **XIBs** para la interfaz de usuario, además de integrar una **API REST** para obtener los datos de los personajes y sus transformaciones. También incluye **testing** para garantizar la calidad del código.

## Características

- **XIBs**: La interfaz de usuario está diseñada utilizando una combinación de XIBs para facilitar el manejo visual de las vistas.
- **API REST**: La aplicación interactúa con una API REST para obtener información sobre los personajes y sus transformaciones.
- **Testing**: El proyecto incluye pruebas unitarias y de integración para asegurar la correcta funcionalidad de las principales características.
- **Lista de Transformaciones**: Muestra una lista de transformaciones para cada personaje seleccionado.

## Tecnologías Utilizadas

- **Swift**: Lenguaje principal para el desarrollo de la app.
- **XIB**: Diseño de interfaz de usuario.
- **UIKit**: Para el manejo de la interfaz y componentes visuales.
- **UITableViewController** y **UITableViewCell**: Componentes para la gestión de listas.
- **TextFields**: Para el manejo de entradas de texto, como en el login.
- **API REST**: Obtención de datos desde un servidor externo.
- **XCTest**: Framework utilizado para implementar pruebas unitarias y de integración.

## Instalación

1. Clona este repositorio:
   ```bash
   git clone https://github.com/KevinHe1496/DbzHeroes.git
   ```

2. Abre el proyecto en Xcode:
   ```bash
   cd DragonBallHeroes
   open DragonBallHeroes.xcodeproj
   ```

3. Ejecuta el proyecto en un simulador o dispositivo físico.

## Uso

1. Al iniciar la aplicación, primero se mostrará una pantalla de **login**.
2. Después de iniciar sesión, podrás ver una lista de personajes de Dragon Ball Z.
3. Selecciona un personaje para ver una lista de sus transformaciones.
4. Cada transformación muestra detalles como el nivel de poder y la descripción del estado.

## Pruebas

Para ejecutar las pruebas del proyecto, sigue estos pasos:

1. Abre el proyecto en Xcode.
2. Presiona `Cmd + U` para ejecutar las pruebas.

