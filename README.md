# 🛠️ Manual: Entorno de Desarrollo 100% Portable

Este kit te permite llevar un entorno profesional completo (IntelliJ, Git, GitHub CLI, Java y Gradle) en un USB, listo para usar en cualquier PC con Windows.

---

## 🚀 1. Instalación Inicial

1.  Copia estos archivos a la raíz de tu USB:
    *   `preparar_usb.bat`
    *   `Iniciar_Entorno.bat`
    *   `configurar_git_y_gh.bat`
2.  Descarga y coloca en la misma carpeta los siguientes archivos `.zip`:
    *   **IntelliJ IDEA**: `intellij.zip` (Windows ZIP)[https://www.jetbrains.com/idea/download/?section=windows]
    *   **Git Portable**: `git.zip` (64-bit Portable)[https://git-scm.com/install/windows]
    *   **Oracle Java 25**: `jdk.zip` (Windows x64 ZIP)[https://www.oracle.com/java/technologies/downloads/]
    *   **GitHub CLI**: `gh.zip` (Windows amd64 ZIP)[https://github.com/cli/cli/releases/]
3.  Ejecuta **`preparar_usb.bat`**. Este script creará las carpetas y descomprimirá todo automáticamente.

> **IMPORTANTE**: GitHub CLI suele extraerse en una subcarpeta (ej: `gh_2.32.1_windows_amd64`). Mueve el contenido de esa subcarpeta directamente a la carpeta `gh` de tu USB para que el lanzador funcione.

---

## ⚙️ 2. Configuración Inicial (Solo la primera vez)

Antes de empezar a programar, ejecuta **`configurar_git_y_gh.bat`**. 
Este script te permitirá:
1.  Configurar tu **Nombre** y **Email** para tus commits.
2.  Iniciar sesión en **GitHub** de forma segura (los tokens se guardarán en el USB).

---

## 💻 3. Uso Diario

Para empezar a trabajar en cualquier PC:
👉 **`Iniciar_Entorno.bat`**

Este script prepara el sistema, inyecta las herramientas en el `PATH` y abre IntelliJ IDEA.

---

## 📁 Estructura del USB
*   `intellij/`: El IDE.
*   `git/`: Binarios de Git.
*   `jdk/`: Java Development Kit.
*   `gh/`: GitHub CLI.
*   `data/`: **Tus configuraciones y secretos.** (Caché de Gradle, Plugins, Perfil de Git, Tokens de GitHub). **¡Mantenla segura!**
*   `workspace/`: Tus proyectos.

---

## ⚠️ Notas Importantes
*   **Aislamiento**: Nada de lo que hagas se guardará en la PC host (ni historial de Git, ni credenciales).
*   **Seguridad**: Si pierdes el USB, cualquier persona podrá acceder a tu cuenta de GitHub si no tienes el USB cifrado (usa BitLocker To Go si es posible).
*   **Rendimiento**: Usa siempre un puerto **USB 3.0** o superior.
