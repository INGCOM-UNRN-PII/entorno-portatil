@echo off
setlocal
title Limpieza de Datos Personales - Entorno Portable

:: 1. Detectar ruta del USB
set "USB_ROOT=%~dp0"
if "%USB_ROOT:~-1%"=="\" set "USB_ROOT=%USB_ROOT:~0,-1%"

set "DATA_DIR=%USB_ROOT%\data"

echo ====================================================
echo    LIMPIEZA DE DATOS PERSONALES
echo ====================================================
echo.
echo [!] ADVERTENCIA: Este script eliminara TODOS los datos
echo     personales almacenados en el USB, incluyendo:
echo.
echo     - Configuracion de Git (nombre, email)
echo     - Sesiones de GitHub CLI (tokens)
echo     - Cache de Gradle
echo     - Configuracion y plugins de IntelliJ
echo     - Historial y preferencias
echo.
echo     Los binarios (tools) y proyectos (workspace) NO se eliminaran.
echo.
echo ====================================================
echo.
set /p "CONFIRM=¿Estas seguro de continuar? (S/N): "

if /i not "%CONFIRM%"=="S" (
    echo.
    echo [*] Operacion cancelada por el usuario.
    pause
    exit /b 0
)

echo.
echo [+] Iniciando limpieza de datos personales...
echo.

:: 2. Eliminar datos de configuracion
if exist "%DATA_DIR%\idea" (
    echo [+] Eliminando configuracion de IntelliJ...
    rmdir /s /q "%DATA_DIR%\idea" 2>nul
    mkdir "%DATA_DIR%\idea"
)

if exist "%DATA_DIR%\gradle" (
    echo [+] Eliminando cache de Gradle...
    rmdir /s /q "%DATA_DIR%\gradle" 2>nul
    mkdir "%DATA_DIR%\gradle"
)

if exist "%DATA_DIR%\gh_config" (
    echo [+] Eliminando tokens de GitHub CLI...
    rmdir /s /q "%DATA_DIR%\gh_config" 2>nul
    mkdir "%DATA_DIR%\gh_config"
)

if exist "%DATA_DIR%\.gitconfig" (
    echo [+] Eliminando configuracion global de Git...
    del /f /q "%DATA_DIR%\.gitconfig" 2>nul
)

if exist "%DATA_DIR%\.gitignore_global" (
    echo [+] Eliminando gitignore global...
    del /f /q "%DATA_DIR%\.gitignore_global" 2>nul
)

if exist "%DATA_DIR%\AppData" (
    echo [+] Eliminando datos de aplicaciones...
    rmdir /s /q "%DATA_DIR%\AppData" 2>nul
)

if exist "%DATA_DIR%\.bash_history" (
    echo [+] Eliminando historial de terminal...
    del /f /q "%DATA_DIR%\.bash_history" 2>nul
)

if exist "%DATA_DIR%\.ssh" (
    echo [+] Eliminando claves SSH...
    rmdir /s /q "%DATA_DIR%\.ssh" 2>nul
)

:: 3. Limpiar archivos temporales comunes
for %%f in (.viminfo .lesshst .wget-hsts .oracle_jre_usage) do (
    if exist "%DATA_DIR%\%%f" (
        del /f /q "%DATA_DIR%\%%f" 2>nul
    )
)

echo.
echo ====================================================
echo    LIMPIEZA COMPLETADA
echo ====================================================
echo.
echo [OK] Todos los datos personales han sido eliminados.
echo [*] Las carpetas base se han recreado.
echo [*] El USB esta listo para usar en otra computadora.
echo.
echo [!] RECUERDA: Deberas ejecutar 'configurar_git_y_gh.bat'
echo     nuevamente antes de trabajar.
echo.
pause
exit
