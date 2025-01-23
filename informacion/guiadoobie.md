# Guía Didáctica para el Uso de Doobie en Operaciones CRUD con MySQL

Esta guía está diseñada para ayudarte a aprender a usar **Doobie**, una librería funcional de Scala, para realizar operaciones CRUD (Create, Read, Update, Delete) en una base de datos MySQL. El proyecto se configura con **SBT** y está diseñado para Scala.

---

## 🛠 Configuración del Proyecto

### **1. Configurar `build.sbt`**

Asegurar que el archivo `build.sbt` contenga las dependencias necesarias para usar Doobie y conectar con MySQL.

```scala
scalaVersion := "3.3.4"

libraryDependencies ++= Seq(
    "org.tpolecat" %% "doobie-core" % "1.0.0-RC5",      // Dependencias de doobie
      "org.tpolecat" %% "doobie-hikari" % "1.0.0-RC5",    // Para gestión de conexiones
      "com.mysql" % "mysql-connector-j" % "8.0.31",  // Driver para mysql
      "com.typesafe" % "config"           % "1.4.2"  // Para archivos de configuración
)
```

### **2. Crear un archivo de configuración (`application.conf`)**

Utiliza un archivo `application.conf` para almacenar los detalles de conexión a tu base de datos MySQL:

```hocon
db {
  driver = "com.mysql.cj.jdbc.Driver"
  url = "jdbc:mysql://localhost:3306/mi_base_de_datos"
  user = "mi_usuario"
  password = "mi_contraseña"
}
```

Agrega el archivo en el directorio `src/main/resources`.

---

## 🚀 Conexión a la Base de Datos

### **1. Configurar el Transactor**

Un **Transactor** gestiona las conexiones a la base de datos. Configurémoslo:

```scala
import cats.effect.{IO, Resource}
import doobie.hikari.HikariTransactor
import com.typesafe.config.ConfigFactory
import scala.concurrent.ExecutionContext

object Database {

  private val connectEC: ExecutionContext = ExecutionContext.global

  def transactor: Resource[IO, HikariTransactor[IO]] = {
    val config = ConfigFactory.load().getConfig("db")
    HikariTransactor.newHikariTransactor[
      IO
    ](
      config.getString("driver"),
      config.getString("url"),
      config.getString("user"),
      config.getString("password"),
      connectEC // ExecutionContext requerido para Doobie
    )
  }
}
```

---

## Conceptos Clave en Doobie

### **ConnectionIO**
- Es un tipo que representa una operación que interactúa con la base de datos.
- Las operaciones como consultas o actualizaciones se definen en este contexto para ser ejecutadas posteriormente.

### **transact**
- Convierte una operación `ConnectionIO` en un efecto ejecutable (como `IO`) utilizando un `Transactor`.
- Asegura que la operación se ejecute dentro de un contexto transaccional.

### **unsafeRunSync**
- Ejecuta un efecto de tipo `IO` y devuelve el resultado de forma síncrona.
- Úsalo solo para propósitos de demostración o en aplicaciones pequeñas, ya que bloquea el hilo.

### **Resource[IO]**
- Es una abstracción que gestiona recursos que necesitan ser inicializados y liberados de manera segura (como conexiones de base de datos).
- En este caso, el `HikariTransactor` se gestiona dentro de un `Resource[IO]` para garantizar que las conexiones sean cerradas correctamente al finalizar.
- Proporciona métodos como `.use` para trabajar con el recurso.

### **ExecutionContext**
- Es una abstracción que define un contexto de ejecución para tareas concurrentes, como la gestión de conexiones o ejecución de consultas en Doobie.
- Actúa como un planificador que decide dónde y cómo se ejecutarán las tareas.

### **ExecutionContext.global**
- Es un `ExecutionContext` predeterminado proporcionado por Scala.
- Utiliza un `ForkJoinPool` debajo para ejecutar tareas concurrentes y es adecuado para la mayoría de las aplicaciones generales.
- Se usa aquí para gestionar las tareas de conexión a la base de datos en el `HikariTransactor`.

---

## 🧑‍💻 Operaciones CRUD

### **1. Crear la Tabla**

Antes de realizar operaciones CRUD, asegúrate de que la tabla exista en la base de datos. Por ejemplo:

```sql
CREATE TABLE usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  edad INT NOT NULL
);
```

---

### **2. Implementar las Operaciones CRUD**

Usaremos el patrón **DAO (Data Access Object)** para organizar las operaciones relacionadas con la tabla `usuarios`. Esto facilita la reutilización y el mantenimiento del código.

#### **Definición del Objeto `UsuarioDAO`**

```scala
import doobie._
import doobie.implicits._
import cats.effect.IO

/**
  * Objeto que encapsula las operaciones CRUD para la tabla `usuarios`.
  */
object UsuarioDAO {

  /**
    * Crear un nuevo usuario.
    * @param nombre Nombre del usuario.
    * @param edad Edad del usuario.
    * @return Número de filas afectadas.
    */
  def crear(nombre: String, edad: Int): ConnectionIO[Int] =
    sql"INSERT INTO usuarios (nombre, edad) VALUES ($nombre, $edad)".update.run

  /**
    * Obtener todos los usuarios.
    * @return Lista de tuplas con los datos de los usuarios.
    */
  def obtenerTodos: ConnectionIO[List[(Int, String, Int)]] =
    sql"SELECT id, nombre, edad FROM usuarios".query[(Int, String, Int)].to[List]

  /**
    * Actualizar la edad de un usuario.
    * @param id Identificador del usuario.
    * @param nuevaEdad Nueva edad del usuario.
    * @return Número de filas afectadas.
    */
  def actualizarEdad(id: Int, nuevaEdad: Int): ConnectionIO[Int] =
    sql"UPDATE usuarios SET edad = $nuevaEdad WHERE id = $id".update.run

  /**
    * Eliminar un usuario.
    * @param id Identificador del usuario.
    * @return Número de filas afectadas.
    */
  def eliminar(id: Int): ConnectionIO[Int] =
    sql"DELETE FROM usuarios WHERE id = $id".update.run
}
```

Detalles técnicos:

- **ConnectionIO** describe qué hacer, pero no ejecuta la consulta hasta que se use con un transactor
- **update.run** Es utilizado para operaciones que no devuelven filas. Generalmente, esto incluye (INSERT, UPDATE, DELETE). Devolverá un Int con el número de filas actualizadas
- **query** utilizado para operaciones que devuelven resultados (es decir, filas). Generalmente, esto incluye SELECT

---

## 🛠 Ejecutar las Operaciones

Las operaciones CRUD deben ejecutarse dentro del contexto de un **Transactor**. 

Un **Transactor** se encarga de: 
1. Conectar a la base de datos.
2. Gestionar transacciones (abrir, confirmar, o deshacer).
3. Ejecutar las acciones descritas en el ConnectionIO.


Aquí tienes un ejemplo más cercano al estilo tradicional:

```scala
import doobie.implicits._
import cats.effect.unsafe.implicits.global

object Main extends App {

  // Obtener el transactor
  val (transactor, cleanup) = Database.transactor.allocated.unsafeRunSync()

  try {
    // Crear un usuario
    val creado = UsuarioDAO.crear("Alice", 30).transact(transactor).unsafeRunSync()
    println(s"Usuario creado: $creado")

    // Leer usuarios
    val usuarios = UsuarioDAO.obtenerTodos.transact(transactor).unsafeRunSync()
    println(s"Usuarios: $usuarios")

    // Actualizar un usuario
    val actualizado = UsuarioDAO.actualizarEdad(1, 35).transact(transactor).unsafeRunSync()
    println(s"Usuarios actualizados: $actualizado")

    // Eliminar un usuario
    val eliminado = UsuarioDAO.eliminar(1).transact(transactor).unsafeRunSync()
    println(s"Usuarios eliminados: $eliminado")
  } finally {
    // Ejecuta la acción de limpieza
    cleanup.unsafeRunSync()
  }
}

```

Detalles técnicos:

- **Database.transactor**: Es una función o valor que devuelve un transactor configurado para conectarse a la base de datos. El transactor es el componente que ejecuta acciones declaradas como ConnectionIO contra la base de datos real.
- **allocated**: Devuelve una tupla con el transactor (HikariTransactor) y una acción de limpieza. La acción de limpieza (cleanup) se asegura de cerrar correctamente los recursos asociados al transactor (como las conexiones a la base de datos).
- **transact(transactor)**: Ejecuta la acción declarada (ConnectionIO) usando el transactor, que maneja la conexión y las transacciones.
- **unsafeRunSync():** Bloquea el programa y ejecuta la operación, devolviendo el número de filas afectadas.





