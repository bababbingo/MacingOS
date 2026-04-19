@echo off
title MacingOS USB Tool
setlocal

echo ==========================
echo   MacingOS USB MAKER
echo ==========================
echo.

echo This tool ONLY prepares USB.
echo EFI must already exist.
echo.

powershell -command "Get-Disk | Format-Table Number, FriendlyName, Size"

echo.
set /p disk=Select USB disk number:

echo.
set /p confirm=Type YES to ERASE USB:

if not "%confirm%"=="YES" (
    echo Cancelled.
    pause
    exit
)

(
echo select disk %disk%
echo clean
echo create partition primary
echo format fs=fat32 quick
echo assign
echo exit
) > usb.txt

diskpart /s usb.txt

echo.
echo DONE formatting USB.
echo.

set /p letter=Enter USB drive letter (e.g. E):

set SOURCE=..\EFI-Builder\OUTPUT\EFI

if not exist "%SOURCE%" (
    echo ERROR: EFI not found!
    echo Run EFI Builder first.
    pause
    exit
)

xcopy "%SOURCE%\*" "%letter%:\EFI\" /E /H /C /I /Y

echo.
echo USB READY (OpenCore bootable)
pause