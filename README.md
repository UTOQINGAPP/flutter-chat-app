
# Flutter Chat App

Esta aplicación es un sistema de CRUD de usuarios y chat en tiempo real desarrollado con Flutter. Se conecta a un servidor backend que permite gestionar usuarios y salas de chat.

## Configuración Inicial

Para comenzar a utilizar la aplicación, es necesario realizar algunas configuraciones previas.

### 1. Clonar el Repositorio Backend

Primero, clona el repositorio del servidor backend que se utilizará para la aplicación:

```bash
git clone https://github.com/UTOQINGAPP/chat-backend-server.git
```

Sigue las instrucciones del repositorio para iniciar el servidor.

### 2. Configurar las Variables de Entorno

Dentro del proyecto Flutter, hay un archivo de configuración que necesita ser modificado para que la aplicación pueda conectarse correctamente al servidor.

#### Pasos:

1. Renombra el archivo `env_config_copy.dart` a `env_config.dart`.

2. Abre `env_config.dart` y modifica las siguientes variables para que coincidan con la configuración de tu servidor:

```dart
import 'dart:io';
//change the name of “env_config_copy.dart” to “env_config.dart”
//If an error occurs, it may be found in the “configs.dart” file, in case it requires adding or removing a route.
import 'package:flutter/foundation.dart';

class EnvConfig {
  static String apiUrl() {
    if (kIsWeb) {
      return 'http://localhost:3000/api';
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000/api';
    } else if (Platform.isIOS) {
      return 'http://localhost:3000/api';
    } else {
      return 'http://localhost:3000/api';
    }
  }

  static String socketUrl() {
    if (kIsWeb) {
      return 'http://localhost:3000';
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000';
    } else if (Platform.isIOS) {
      return 'http://localhost:3000';
    } else {
      return 'http://localhost:3000';
    }
  }
}
```

### 3. Configuración Adicional en caso de Error

Si experimentas problemas al conectar con el servidor, verifica y modifica el archivo `configs.dart`. Este archivo gestiona las rutas de los archivos pertenecientes a la capa "configs".

### 4. Instalar las Dependencias

Antes de ejecutar la aplicación, instala las dependencias definidas en `pubspec.yaml` ejecutando el siguiente comando:

```bash
flutter pub get
```

### 5. Ejecutar la Aplicación

Una vez que hayas configurado las variables de entorno, verificado las configuraciones necesarias y instalado las dependencias, puedes ejecutar la aplicación usando el siguiente comando (soporta web, android e ios, los demás no fueron probados):

```bash
flutter run
```

### Notas Adicionales

- Asegúrate de tener el servidor backend en ejecución antes de iniciar la aplicación para evitar problemas de conexión.
- La aplicación puede ser configurada para conectarse tanto a un servidor local como remoto. Ajusta las variables de entorno en `env_config.dart` según sea necesario.

## Funcionalidades de la Aplicación

- **CRUD de Usuarios**: Permite crear, leer, actualizar y eliminar usuarios.
- **Chat en Tiempo Real**: Los usuarios pueden enviar y recibir mensajes en tiempo real.
- **Conexión a un Servidor**: La aplicación se conecta a un servidor backend que maneja la lógica y almacenamiento de datos.

## Tecnologías Utilizadas

- **Flutter**: Para el desarrollo de la interfaz de usuario.
- **Servidor Backend NodeJS**: Puedes encontrar el repositorio del servidor en [chat-backend-server](https://github.com/UTOQINGAPP/chat-backend-server.git).

## Licencia

Este proyecto está bajo la Licencia Apache License, Version 2.0 - mira el archivo [LICENSE](LICENSE) para más detalles.