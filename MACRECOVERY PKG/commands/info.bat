@echo off
title MacingOS System Info
color 0A

echo ==========================
echo     SYSTEM INFORMATION
echo ==========================
echo.

echo [CPU]
wmic cpu get name

echo.
echo [GPU]
wmic path win32_VideoController get name

echo.
echo [RAM]
wmic memorychip get capacity

echo.
echo [DISK]
wmic diskdrive get model,size

echo.
echo [OS]
ver

echo.
pause