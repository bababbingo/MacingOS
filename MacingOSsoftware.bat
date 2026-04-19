@echo off
title MacingOS SOFTWARE CORE
color 0A

:main
cls
echo ==========================
echo     MACINGOS CORE
echo ==========================
echo.
echo 1 - EFI Builder
echo 2 - USB Maker
echo 3 - Utilities
echo 4 - System Info
echo 5 - Exit
echo.

set /p c=Select:

if "%c%"=="1" goto efi
if "%c%"=="2" goto usb
if "%c%"=="3" goto util
if "%c%"=="4" goto info
if "%c%"=="5" exit

goto main

:: ==========================
:efi
cls
echo Running EFI Builder...
call EFI-Builder\build.bat
pause
goto main

:: ==========================
:usb
cls
echo Running USB Maker...
call MacingOS-USB\usb.bat
pause
goto main

:: ==========================
:util
cls
echo Opening Utilities...
call Utilities\tools.bat
pause
goto main

:: ==========================
:info
cls
wmic cpu get name
wmic path win32_VideoController get name
pause
goto main