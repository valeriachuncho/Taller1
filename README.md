# Programación Funcional y Reactiva - UTPL

Bienvenido a este entorno de programación configurado para los laboratorios de la asignatura de **Programación Funcional y Reactiva** de la titulación de Computación de la Universidad Técnica Particular de Loja.

**RECUERDE**: este entorno es opcional y no pretende reemplazar a las herramientas que usted tenga instaladas en su computador. El uso de este entorno queda a su criterio. Sin embargo, lo alentamos a experimentar la herramienta y vivir la experiencia de otro sistema operativo y de un entorno que está enmarcado en las tendencias futuras.

## 🚀 Abrir en GitHub Codespaces

### Para estudiantes (Primera vez)

1. **Haz Fork de este repositorio**
   - Haz clic en el botón "Fork" arriba a la derecha
   - Esto creará tu propia copia del repositorio

2. **Abre Codespace desde TU repositorio**
   - Ve a tu fork: `https://github.com/TU-USUARIO/Talleres`
   - Haz clic en `Code` → `Codespaces` → `Create codespace on main`
  


Las siguientes instrucciones únicamente tienen sentido una vez que se encuentre dentro del entorno de desarrollo de Codespaces.

## 🛠️ Características del entorno

En este entorno usted encontrará las siguientes herramientas:

- **Java 11** - `java`, `jshell`
- **Scala 3** - `scala`
- **Python 3** - `python3`, `ipython`
- **Maven 3.6** - `mvn`
- **SBT** - `sbt`
- **pip** - `pip`
- **SDKMAN** - `sdk`
- **Glow** - `glow` (para visualizar archivos markdown, extensión .md)
- **MySQL 8.0** - Base de datos relacional
- **Jupyter** - Notebooks interactivos

En los paréntesis que se encuentran al final de cada item encontrará el comando que debe ejecutar para trabajar con cada una de las herramientas.

## 📚 Cómo usar el entorno

Dentro de Codespaces existen dos formas básicas de trabajo:

1. **Visual Studio Code Web**: Un IDE que a través de plugins puede trabajar con diferentes lenguajes de programación. La instalación de los plugins se verá cuando sea necesario y está determinado por el tipo de práctica a realizar.

2. **Línea de comandos (shell)**: Al igual que el caso anterior, su uso estará determinado por el tipo de práctica a realizar.

Independientemente del tipo de práctica, el detalle de cada una de ellas se encuentra publicado en un archivo escrito en markdown (.md). Para iniciar cada práctica debe abrir y visualizar el archivo que corresponde a la semana académica que se encuentra cursando, por ejemplo: si está en la semana 1 del primer bimestre, el detalle de la práctica estará en el archivo con nombre `b1s1.md`.

Para abrir el archivo con el detalle de las prácticas debe ejecutar el comando:
```bash
glow
```

Y luego use las teclas cursor para ubicarse en el archivo correspondiente (por ejemplo `b1s1.md`) y presione **Enter**.

## 🗄️ Conectarse a MySQL

MySQL corre en un contenedor separado y está siempre disponible. Puedes conectarte de tres formas:

### 1. Desde la terminal del Codespace:
```bash
# Conectar a MySQL
mysql -h db -u pfr_user -ppassword pfr_db

# O como root
mysql -h db -u root -ppassword pfr_db
```

### 2. Usando la extensión SQLTools en VS Code:
- La extensión ya viene instalada
- Haz clic en el ícono de base de datos en la barra lateral
- Crea una nueva conexión con estos datos:
  - **Host:** `db`
  - **Puerto:** `3306`
  - **Usuario:** `pfr_user`
  - **Contraseña:** `password`
  - **Base de datos:** `pfr_db`

### 3. Desde tu código (ejemplo en Scala/Java):
```scala
// URL de conexión JDBC
val url = "jdbc:mysql://db:3306/pfr_db"
val user = "pfr_user"
val password = "password"
```

## 📋 Estructura de talleres

### Primer Bimestre

#### Taller 1
- **Taller**: Uso combinado de POO y programación funcional
- **Semana**: 1
- **Archivo**: `b1s1.md`

#### Taller Grupal 1 (Taller 2)
- **Taller**: Funciones, funciones sin nombre y rangos
- **Semana**: 2
- **Archivo**: `b1s2.md`

#### Taller Individual 2 (Taller 3)
- **Taller**: Higher Order Functions
- **Semana**: 3
- **Archivo**: `b1s3.md`

#### Taller 4
- **Taller**: Conceptos básicos de PF desarrollando el ejemplo de la clasificación de números de Nicodemo
- **Semana**: 4
- **Archivo**: `b1s4.md`
- **Estatus**: Ok

#### Taller 5
- **Taller**: Inducción al Cálculo lambda desde la práctica
- **Semana**: 5
- **Archivo**: `b1s5.md`
- **Estatus**: Ok

#### Taller 6
- **Taller**: Usando Option, Either
- **Semana**: 6
- **Archivo**: `b1s6.md`
- **Estatus**: Revisar (Revisar la posibilidad de usar [vavr](https://www.vavr.io/))

#### Taller 7
- **Taller**: Manejo de efectos colaterales aplicando Try Either y Option
- **Semana**: 7
- **Archivo**: `b1s7.md`
- **Estatus**: Revisar (Revisar la posibilidad de usar [vavr](https://www.vavr.io/))

#### Taller 8
- **Taller**: Revisión de Recursividad
- **Semana**: 8
- **Archivo**: `b1s8.md`
- **Estatus**: Ok

### Segundo Bimestre

#### Taller 1
- **Taller**: Herramientas para manejo de dependencias SBT
- **Semana**: 1
- **Archivo**: `b2s1.md`
- **Estatus**: Cambiar

#### Taller 2
- **Taller**: Implementación de una aplicación reactiva
- **Semana**: 2
- **Archivo**: `b2s2.md`
- **Estatus**: Revisar (Trabajo con flujos infinitos de datos o similares)

#### Taller 3
- **Taller**: Lectura de archivos CSV y representación de datos
- **Semana**: 3
- **Archivo**: `b2s3.md`
- **Estatus**: Ok

#### Taller 4
- **Taller**: Análisis exploratorio de datos sobre un dataset
- **Semana**: 4
- **Archivo**: `b2s4.md`
- **Estatus**: Ok (Cambiar nombre por: Estadística descriptiva)

#### Taller 5
- **Taller**: Uso ADT para escribir archivos
- **Semana**: 5
- **Archivo**: `b2s5.md`
- **Estatus**: Ok

#### Taller 6
- **Taller**: Ejecución de sentencias DML en un lenguaje funcional
- **Semana**: 6
- **Archivo**: `b2s6.md`
- **Estatus**: Ok

#### Taller 7
- **Taller**: Manejo de bases de datos relacionales usando programación funcional
- **Semana**: 7
- **Archivo**: `b2s7.md`
- **Estatus**: Ok

#### Taller 8
- **Taller**: Bases de datos NoSQL desde una perspectiva funcional
- **Semana**: 8
- **Archivo**: `b2s8.md`
- **Estatus**: Ok

## 💡 Comandos útiles
```bash
# Ver archivos markdown con estilo
glow archivo.md

# Iniciar shell interactivo de Java
jshell

# Iniciar REPL de Scala
scala

# Iniciar REPL de Scala CLI
scala-cli repl

# Ejecutar Python
python3

# Ejecutar IPython (REPL mejorado)
ipython

# Compilar proyecto Maven
mvn compile

# Compilar proyecto SBT
sbt compile

# Conectar a MySQL
mysql -h db -u pfr_user -ppassword pfr_db

# Ver bases de datos
mysql -h db -u pfr_user -ppassword -e "SHOW DATABASES;"
```

## ⚙️ Configuración adicional

El entorno se configura automáticamente al crear el Codespace. La primera vez tardará aproximadamente 5-8 minutos en instalar todas las herramientas. Si necesitas reinstalar algo, puedes ejecutar:
```bash
bash .devcontainer/setup.sh
```

## 🏗️ Arquitectura del entorno

Este entorno usa Docker Compose con dos contenedores:

- **app**: Contenedor principal con todas las herramientas de desarrollo (Java, Scala, Python, SBT, Maven, etc.)
- **db**: Contenedor MySQL 8.0 con datos persistentes

Los datos de MySQL se mantienen entre sesiones gracias a Docker volumes.

## 🔧 Solución de problemas

### Si Scala no funciona:
```bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
scala -version
```

### Si MySQL no se conecta:
```bash
# Verificar que el contenedor esté corriendo
docker ps

# Ver logs de MySQL
docker logs devcontainer-db-1
```

### Rebuild del contenedor:
`Cmd/Ctrl + Shift + P` → "Rebuild Container"

## 📝 Notas importantes

- Este entorno es **opcional** y no reemplaza las herramientas instaladas en tu computador
- El uso del entorno queda a tu criterio
- Te alentamos a experimentar y vivir la experiencia de este sistema operativo
- La primera configuración tarda 5-8 minutos, pero después es muy rápida
- MySQL se inicia automáticamente y siempre está disponible

---

**Universidad Técnica Particular de Loja**  
*Programación Funcional y Reactiva*
