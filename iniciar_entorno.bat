@echo off
setlocal
title Entorno de Desarrollo Portable (IntelliJ + Git + GitHub CLI)

:: 1. Detectar ruta del USB
set "USB_ROOT=%~dp0"
if "%USB_ROOT:~-1%"=="\" set "USB_ROOT=%USB_ROOT:~0,-1%"

:: 2. Definir rutas críticas
set "TOOLS_DIR=%USB_ROOT%\tools"
set "JAVA_HOME=%TOOLS_DIR%\jdk"
set "GIT_DIR=%TOOLS_DIR%\git"
set "GH_DIR=%TOOLS_DIR%\gh"
set "GRADLE_USER_HOME=%USB_ROOT%\data\gradle"
set "DATA_DIR=%USB_ROOT%\data"
set "GH_CONFIG_DIR=%DATA_DIR%\gh_config"

:: 3. Aislamiento Total (Redirigir carpetas de usuario al USB)
set "HOME=%DATA_DIR%"
set "USERPROFILE=%DATA_DIR%"
set "APPDATA=%DATA_DIR%\AppData\Roaming"
set "LOCALAPPDATA=%DATA_DIR%\AppData\Local"

:: 4. Configurar el PATH (Inyectar herramientas del USB)
set "PATH=%JAVA_HOME%\bin;%GIT_DIR%\cmd;%GIT_DIR%\bin;%GIT_DIR%\usr\bin;%GH_DIR%\bin;%GH_DIR%;%PATH%"

:: 5. Verificación básica en consola
echo ==========================================
echo    ENTORNO PORTABLE INICIADO
echo ==========================================
echo  JAVA:   %JAVA_HOME%
echo  GRADLE: %GRADLE_USER_HOME%
echo  GITHUB: %GH_CONFIG_DIR%
echo ==========================================

:: 6. Lanzar IntelliJ IDEA
:: Buscamos el ejecutable en la carpeta de herramientas
for /f "delims=" %%f in ('dir /s /b "%TOOLS_DIR%\intellij\idea64.exe" 2^>nul') do set "IDEA_EXE=%%f"

if defined IDEA_EXE (
    cd /d "%IDEA_EXE%\.."
    start "" "idea64.exe"
) else (
    echo [!] ERROR: No se encontro idea64.exe en %TOOLS_DIR%\intellij
    pause
)

exit
