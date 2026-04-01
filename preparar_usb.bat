@echo off
setlocal enabledelayedexpansion
title Preparación Inicial del USB Portable

:: --- CONFIGURACIÓN DE NOMBRES ---
set "ZIP_IDEA=intellij.zip"
set "EXE_GIT=PortableGit.exe"
set "ZIP_JDK=jdk.zip"
set "ZIP_GH=gh.zip"

echo ====================================================
echo    ASISTENTE DE PREPARACION - ENTORNO PORTABLE
echo ====================================================
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

:: 2. Función de descompresión
echo.
if exist "%ZIP_IDEA%" (
    echo [+] Descomprimiendo IntelliJ IDEA...
    powershell -command "Expand-Archive -Path '%ZIP_IDEA%' -DestinationPath 'tools\intellij' -Force"
)
if exist "%EXE_GIT%" (
    echo [+] Extrayendo Git Portable
    "%EXE_GIT%" -o"tools\git" -y
) else (
    echo [!] No se encontro %EXE_GIT%. Descargalo desde git-scm.com
)
if exist "%ZIP_JDK%" (
    echo [+] Descomprimiendo JDK...
    powershell -command "Expand-Archive -Path '%ZIP_JDK%' -DestinationPath 'tools\jdk' -Force"
)
if exist "%ZIP_GH%" (
    echo [+] Descomprimiendo GitHub CLI...
    powershell -command "Expand-Archive -Path '%ZIP_GH%' -DestinationPath 'tools\gh' -Force"
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
echo [!] NOTA: GitHub CLI suele extraerse en una subcarpeta.
echo     Mueva el contenido de esa subcarpeta directamente a 'tools\gh'.
echo.
echo ====================================================
echo    PROCESO COMPLETADO
echo ====================================================
pause
exit
