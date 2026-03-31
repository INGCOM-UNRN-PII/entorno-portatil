@echo off
setlocal
title Configuracion Inicial de Git y GitHub

:: 1. Detectar ruta del USB
set "USB_ROOT=%~dp0"
if "%USB_ROOT:~-1%"=="\" set "USB_ROOT=%USB_ROOT:~0,-1%"

:: 2. Configurar entorno portable para esta sesion
set "DATA_DIR=%USB_ROOT%\data"
set "TOOLS_DIR=%USB_ROOT%\tools"
set "HOME=%DATA_DIR%"
set "USERPROFILE=%DATA_DIR%"
set "GH_CONFIG_DIR=%DATA_DIR%\gh_config"

:: Definir rutas de herramientas
set "JAVA_BIN=%TOOLS_DIR%\jdk\bin"
set "GIT_CMD=%TOOLS_DIR%\git\cmd"
set "GIT_BIN=%TOOLS_DIR%\git\bin"
set "GH_BIN=%TOOLS_DIR%\gh\bin"

set "PATH=%JAVA_BIN%;%GIT_CMD%;%GIT_BIN%;%GH_BIN%;%PATH%"

echo ====================================================
echo    CONFIGURACION DE GIT Y GITHUB (PORTABLE)
echo ====================================================
echo.

:: --- CONFIGURACION DE GIT ---
set /p "GIT_NAME=Introduce tu Nombre (ej: Juan Perez): "
set /p "GIT_EMAIL=Introduce tu Email (ej: juan@example.com): "

echo.
echo [+] Configurando Git globalmente en el USB...
git config --global user.name "%GIT_NAME%"
git config --global user.email "%GIT_EMAIL%"
git config --global core.autocrlf true

echo.
echo [OK] Git configurado:
git config --global user.name
git config --global user.email
echo.

:: --- CONFIGURACION DE GITHUB CLI ---
echo ====================================================
echo.
echo ¿Quieres iniciar sesion en GitHub ahora? (S/N)
set /p "LOGIN_GH="

if /i "%LOGIN_GH%"=="S" (
    echo [+] Iniciando proceso de autenticacion de GitHub CLI...
    echo [!] Sigue las instrucciones en el navegador.
    gh auth login
)

echo.
echo ====================================================
echo    CONFIGURACION FINALIZADA
echo ====================================================
echo Ahora puedes cerrar esta ventana y usar 'Iniciar_Entorno.bat'.
echo.
pause
exit
