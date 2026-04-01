@echo off
setlocal enabledelayedexpansion
title Preparación Inicial del USB Portable

echo ====================================================
echo    ASISTENTE DE PREPARACION - ENTORNO PORTABLE
echo ====================================================
echo.

:: --- DETECCIÓN AUTOMÁTICA DE ARCHIVOS ---
echo [+] Detectando archivos descargados...

:: Buscar archivos por patrón
for %%f in (idea*.zip) do set "ZIP_IDEA=%%f"
for %%f in (PortableGit*.exe) do set "EXE_GIT=%%f"
for %%f in (jdk*.zip) do set "ZIP_JDK=%%f"
for %%f in (gh*.zip) do set "ZIP_GH=%%f"

echo     IntelliJ: %ZIP_IDEA%
echo     Git:      %EXE_GIT%
echo     JDK:      %ZIP_JDK%
echo     GitHub:   %ZIP_GH%
echo.

:: 1. Crear estructura de directorios
echo [+] Creando estructura de carpetas...
if not exist "tools" mkdir "tools"
for %%d in (intellij git jdk gh) do (
    if not exist "tools\%%d" mkdir "tools\%%d"
)
for %%d in (workspace data\idea data\gradle data\gh_config) do (
    if not exist "%%d" mkdir "%%d"
)

:: 2. Extracción de herramientas
echo.
if not "%ZIP_IDEA%"=="" (
    echo [+] Descomprimiendo IntelliJ IDEA...
    powershell -command "Expand-Archive -Path '%ZIP_IDEA%' -DestinationPath 'tools\intellij' -Force"
) else (
    echo [!] No se encontro archivo intellij*.zip
)

if not "%EXE_GIT%"=="" (
    echo [+] Extrayendo Git Portable (autoextraible)...
    "%EXE_GIT%" -o"tools\git" -y
) else (
    echo [!] No se encontro archivo PortableGit*.exe
)

if not "%ZIP_JDK%"=="" (
    echo [+] Descomprimiendo JDK...
    powershell -command "Expand-Archive -Path '%ZIP_JDK%' -DestinationPath 'tools\jdk' -Force"
) else (
    echo [!] No se encontro archivo jdk*.zip
)

if not "%ZIP_GH%"=="" (
    echo [+] Descomprimiendo GitHub CLI...
    powershell -command "Expand-Archive -Path '%ZIP_GH%' -DestinationPath 'tools\gh_temp' -Force"
    
    :: Mover el contenido de la subcarpeta a tools\gh
    echo [+] Reorganizando estructura de GitHub CLI...
    for /d %%d in (tools\gh_temp\gh_*) do (
        xcopy "%%d\*" "tools\gh\" /E /I /Y >nul 2>&1
    )
    
    :: Limpiar carpeta temporal
    rmdir /s /q "tools\gh_temp" 2>nul
) else (
    echo [!] No se encontro archivo gh*.zip
)

:: 3. Parche automático de idea.properties
echo.
echo [+] Aplicando configuracion de rutas relativas en IntelliJ...
:: Buscamos el archivo idea.properties dentro de tools\intellij
for /f "delims=" %%f in ('dir /s /b "tools\intellij\idea.properties" 2^>nul') do set "PROP_FILE=%%f"

if defined PROP_FILE (
    powershell -command "(Get-Content '%PROP_FILE%') -replace '^#\s*idea\.config\.path=.*', 'idea.config.path=${idea.home.path}/../../data/idea/config' -replace '^#\s*idea\.system\.path=.*', 'idea.system.path=${idea.home.path}/../../data/idea/system' -replace '^#\s*idea\.plugins\.path=.*', 'idea.plugins.path=${idea.home.path}/../../data/idea/plugins' -replace '^#\s*idea\.log\.path=.*', 'idea.log.path=${idea.home.path}/../../data/idea/log' | Set-Content '%PROP_FILE%'"
    echo [OK] Archivo idea.properties configurado en: %PROP_FILE%
) else (
    echo [!] No se pudo encontrar idea.properties automáticamente. Verifique la carpeta tools\intellij.
)

echo.
echo ====================================================
echo    PROCESO COMPLETADO
echo ====================================================
pause
exit
