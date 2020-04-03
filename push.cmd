@echo off
setlocal enabledelayedexpansion
set MODSNAME=VEAF DCS game mods
set FOLDER=VEAF_DCS_game_mods
set HTTPURL=http://aggressors.free.fr/repos_ovgme/
echo.
echo ==========================================
echo  Pushing %MODSNAME% on repository
echo ==========================================
echo.

rem Pushing files
ftp -s:remoterepository.ftp
rem rd /s /q .\build

rem -- Mods pushed !
echo.
echo ========================================
echo  %MODSNAME% pushed on repository
echo ========================================
echo.

pause
