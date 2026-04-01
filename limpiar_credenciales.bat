@echo off
setlocal enabledelayedexpansion

title Limpieza de Credenciales - PC Publica

echo ====================================================
echo    LIMPIEZA DE CREDENCIALES - PC PUBLICA
echo ====================================================
echo.
echo [+] Eliminando rastros de credenciales de la PC...
echo.

:: --- GitHub CLI Config ---
if exist "%LOCALAPPDATA%\gh\" (
    echo [!] Borrando config de GitHub CLI...
    rmdir /s /q "%LOCALAPPDATA%\gh" 2>nul
)

if exist "%APPDATA%\GitHub CLI\" (
    echo [!] Borrando cache de GitHub CLI...
    rmdir /s /q "%APPDATA%\GitHub CLI" 2>nul
)

:: --- Git Credential Manager ---
if exist "%LOCALAPPDATA%\GitCredentialManager\" (
    echo [!] Borrando Git Credential Manager...
    rmdir /s /q "%LOCALAPPDATA%\GitCredentialManager" 2>nul
)

:: --- SSH Agent temporales ---
if exist "%TEMP%\ssh-*" (
    echo [!] Borrando archivos temporales SSH...
    del /q /f "%TEMP%\ssh-*" 2>nul
)

:: --- Git credential cache ---
if exist "%TEMP%\.git-credential-cache\" (
    echo [!] Borrando cache de credenciales Git...
    rmdir /s /q "%TEMP%\.git-credential-cache" 2>nul
)

:: --- Archivos .git-credentials temporales ---
for %%f in ("%TEMP%\git-credential-*") do (
    if exist "%%f" (
        echo [!] Borrando %%~nxf...
        del /q /f "%%f" 2>nul
    )
)

:: --- Known hosts temporales ---
for %%f in ("%TEMP%\known_hosts_*") do (
    if exist "%%f" (
        echo [!] Borrando %%~nxf...
        del /q /f "%%f" 2>nul
    )
)

echo.
echo ====================================================
echo    LIMPIEZA DE CREDENCIALES COMPLETADA
echo ====================================================
echo.
echo [OK] Ya puedes retirar el USB de forma segura.
echo.
pause
