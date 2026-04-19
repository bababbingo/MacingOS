@echo off
title MacingOS Utilities
color 0A

:menu
cls
echo ==========================
echo   MACINGOS UTILITIES
echo ==========================
echo.
echo 1 - MacRecovery
echo 2 - System Info
echo 3 - Back
echo.

set /p choice=Select:

if "%choice%"=="1" goto rec
if "%choice%"=="2" goto info
if "%choice%"=="3" exit

goto menu

:rec
call macrecovery\recovery.bat
pause
goto menu

:info
wmic cpu get name
wmic path win32_VideoController get name
pause
goto menu