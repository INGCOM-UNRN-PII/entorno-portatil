# 🛠️ Entorno de Desarrollo 100% Portable (IntelliJ + Git + GitHub CLI)

Este kit te permite llevar el entorno de trabajo completo de la cátedra en un USB, listo para usar en cualquier PC con Windows sin dejar rastro y manteniendo todas tus herramientas organizadas en un subdirectorio.

---

## 🚀 1. Instalación Inicial

### 1.  Copia los archivos de este repositorio a la raíz de tu USB:

- `preparar_usb.bat`
- `iniciar_entorno.bat`
- `configurar_git_y_gh.bat`
- `abrir_terminal.bat`
   
### 2.  Descarga y coloca en la misma carpeta los siguientes archivos:

Los archivos se detectan automáticamente por su nombre. Solo asegurate que empiecen con el prefijo correcto:

 -   **IntelliJ IDEA**: `intellij*.zip` [Windows ZIP](https://www.jetbrains.com/idea/download/?section=windows)
 -   **Git Portable**: `PortableGit*.exe` [64-bit Portable (autoextraíble)](https://git-scm.com/download/win)
 -   **Oracle Java 25**: `jdk*.zip` [Windows x64 ZIP](https://www.oracle.com/java/technologies/downloads/)
 -   **GitHub CLI**: `gh*.zip` [Windows amd64 ZIP](https://github.com/cli/cli/releases/)

💡 **Ejemplo**: `intellij-2024.1.zip`, `PortableGit-2.48.0.exe`, `jdk-25_windows-x64.zip`, `gh_2.89.0_windows_amd64.zip`
    
### 3.  Ejecuta **`preparar_usb.bat`**. Este script:
 *   Creará la carpeta `tools/` y `data/`.
 *   Descomprimirá las herramientas dentro de `tools/`.
 *   Configurará IntelliJ para usar rutas relativas hacia la carpeta `data/`.

> **IMPORTANTE**: GitHub CLI suele extraerse en una subcarpeta (ej: `gh_2.x.x_windows_amd64`). Mueve el contenido de esa subcarpeta directamente a `tools\gh` para que el lanzador funcione.

---

## ⚙️ 2. Configuración Inicial (Solo la primera vez)

Antes de empezar a programar, ejecuta **`configurar_git_y_gh.bat`**. 
Este script te permitirá:
1.  Configurar tu **Nombre** y **Email** para tus commits.
2.  Iniciar sesión en **GitHub** de forma segura (los tokens se guardarán en el USB en `data\gh_config`).

---

## 💻 3. Uso Diario

Para empezar a trabajar en cualquier PC:
👉 **`Iniciar_Entorno.bat`**: Abre IntelliJ IDEA con todo configurado.
👉 **`Abrir_Terminal.bat`**: Abre una terminal Git Bash en la carpeta `workspace/`.

Este script prepara el sistema, inyecta las herramientas de la carpeta `tools/` en el `PATH` y abre el entorno seleccionado.

---

## 🧹 4. Limpieza de Datos (Computadora Compartida)

Si usas el USB en una computadora compartida y quieres eliminar tus datos personales:
👉 **`limpiar_datos.bat`**: Elimina configuraciones, tokens, caché y historial.

**⚠️ IMPORTANTE**: Este script elimina:
- Configuración de Git (nombre y email)
- Tokens de autenticación de GitHub
- Caché de Gradle y plugins de IntelliJ
- Historial de terminal y configuraciones personales

Los binarios (`tools/`) y proyectos (`workspace/`) **NO** se eliminan.

---

## 📁 Estructura del USB
*   `tools/`: **Contenedor de binarios.** (IntelliJ, Git, JDK, GH).
*   `data/`: **Tus configuraciones y secretos.** (Caché de Gradle, Plugins, Perfil de Git, Tokens de GitHub). **¡Mantenela segura!**
*   `workspace/`: Tus proyectos de código.
*   Scripts raíz: Acceso rápido a las funciones principales.

---

## ⚠️ Notas Importantes
*   **Aislamiento**: Nada de lo que hagas se guardará en la PC host.
*   **Seguridad**: Si pierdes el USB, cualquiera con acceso físico podría usar tus credenciales de GitHub si no están cifradas. Usa `limpiar_datos.bat` regularmente en computadoras compartidas.
*   **Rendimiento**: Se requiere un puerto **USB 3.0** o superior para una experiencia fluida.
*   **Computadora Compartida**: Ejecuta `limpiar_datos.bat` antes de desconectar el USB para eliminar tus datos personales.
