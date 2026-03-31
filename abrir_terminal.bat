@echo off
setlocal
title Terminal Git Bash (Portable)

:: 1. Detectar ruta del USB
set "USB_ROOT=%~dp0"
if "%USB_ROOT:~-1%"=="\" set "USB_ROOT=%USB_ROOT:~0,-1%"

:: 2. Definir rutas de herramientas y datos
set "TOOLS_DIR=%USB_ROOT%\tools"
set "DATA_DIR=%USB_ROOT%\data"
set "WORKSPACE_DIR=%USB_ROOT%\workspace"

:: 3. Aislamiento de Entorno
set "HOME=%DATA_DIR%"
set "USERPROFILE=%DATA_DIR%"
set "APPDATA=%DATA_DIR%\AppData\Roaming"
set "LOCALAPPDATA=%DATA_DIR%\AppData\Local"
set "GH_CONFIG_DIR=%DATA_DIR%\gh_config"

:: 4. Configurar PATH para la terminal
set "PATH=%TOOLS_DIR%\jdk\bin;%TOOLS_DIR%\git\cmd;%TOOLS_DIR%\git\bin;%TOOLS_DIR%\git\usr\bin;%TOOLS_DIR%\gh\bin;%PATH%"

:: 5. Crear workspace si no existe
if not exist "%WORKSPACE_DIR%" mkdir "%WORKSPACE_DIR%"

echo ==========================================
echo    TERMINAL PORTABLE - WORKSPACE
echo ==========================================
echo  Entorno: %DATA_DIR%
echo  Directorio: %WORKSPACE_DIR%
echo ==========================================
echo.

:: 6. Abrir Git Bash en el workspace
:: Buscamos el ejecutable git-bash.exe o sh.exe
if exist "%TOOLS_DIR%\git\git-bash.exe" (
    start "" "%TOOLS_DIR%\git\git-bash.exe" --cd="%WORKSPACE_DIR%"
) else (
    echo [!] No se encontro git-bash.exe. Iniciando bash estandar...
    cd /d "%WORKSPACE_DIR%"
    "%TOOLS_DIR%\git\bin\sh.exe" --login -i
)

exit
