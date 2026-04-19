@echo off
title MacingOS EFI Builder
setlocal enabledelayedexpansion

echo ==========================
echo   MacingOS EFI BUILDER
echo ==========================
echo.

:: ==========================
:: 1. HARDWARE REPORT
:: ==========================
echo [1/3] Hardware Detection
echo --------------------------

for /f "skip=1 delims=" %%a in ('wmic cpu get name') do if not defined CPU set CPU=%%a
for /f "skip=1 delims=" %%a in ('wmic path win32_VideoController get name') do if not defined GPU set GPU=%%a

echo CPU: !CPU!
echo GPU: !GPU!
echo.

:: ==========================
:: SIMPLE COMPATIBILITY MAP
:: ==========================
set RECOMMENDED=TAHOE

echo Checking compatibility...

echo !CPU! | findstr /i "Ryzen AMD" >nul
if !errorlevel! == 0 (
    set CPU_OK=YES
) else (
    set CPU_OK=UNKNOWN
)

echo !GPU! | findstr /i "AMD" >nul
if !errorlevel! == 0 (
    set GPU_OK=YES
) else (
    set GPU_OK=UNKNOWN
)

echo CPU STATUS: !CPU_OK!
echo GPU STATUS: !GPU_OK!
echo.

:: DEFAULT RULE (important)
set RECOMMENDED=TAHOE

echo Recommended profile: !RECOMMENDED!
pause

:: ==========================
:: 2. SELECT VERSION
:: ==========================
cls
echo ==========================
echo [2/3] Select Profile
echo ==========================
echo.

echo Recommended: !RECOMMENDED!
echo.

echo 1 - Tahoe (Default)
echo 2 - Sonoma
echo 3 - Ventura
echo.

set /p choice=Choose version (or press Enter for default):

if "%choice%"=="" set PROFILE=!RECOMMENDED!
if "%choice%"=="1" set PROFILE=TAHOE
if "%choice%"=="2" set PROFILE=SONOMA
if "%choice%"=="3" set PROFILE=VENTURA

echo Selected: !PROFILE!
pause

:: ==========================
:: 3. BUILD EFI
:: ==========================
cls
echo ==========================
echo [3/3] EFI BUILD
echo ==========================
echo.

set SOURCE=PROFILES\!PROFILE!\EFI
set DEST=EFI

echo Checking profile folder: !SOURCE!

if not exist "!SOURCE!" (
    echo ERROR: Profile folder missing!
    echo Falling back to TAHOE...

    set SOURCE=PROFILES\TAHOE\EFI

    if not exist "!SOURCE!" (
        echo CRITICAL ERROR: No EFI found at all!
        pause
        exit
    )
)

if not exist "!DEST!" mkdir "!DEST!"

echo Copying EFI from !PROFILE!...

xcopy "!SOURCE!\*" "!DEST!\" /E /H /C /I /Y >nul

echo.
echo ==========================
echo EFI BUILD COMPLETE
echo Profile: !PROFILE!
echo ==========================
pause
if not exist "TEMPLATES\BASE_EFI\config.plist" (
    echo ERROR: Base EFI missing!
    pause
    exit
)@echo off
title MacingOS Template Deploy
setlocal enabledelayedexpansion

echo ==========================
echo   MacingOS DEPLOY SYSTEM
echo ==========================
echo.

:: ==========================
:: CHECK BASE TEMPLATE
:: ==========================
if not exist "TEMPLATES\BASE_EFI\config.plist" (
    echo ERROR: BASE template missing!
    pause
    exit
)

echo Base template found.
echo.

:: ==========================
:: CREATE PROFILES
:: ==========================

for %%V in (TAHOE SONOMA VENTURA) do (

    echo Creating %%V profile...

    if not exist "PROFILES\%%V" mkdir "PROFILES\%%V"
    if not exist "PROFILES\%%V\EFI" mkdir "PROFILES\%%V\EFI"

    xcopy "TEMPLATES\BASE_EFI\*" "PROFILES\%%V\EFI\" /E /H /C /I /Y >nul

    echo %%V DONE
    echo.
)

echo ==========================
echo ALL PROFILES CREATED
echo ==========================
pause