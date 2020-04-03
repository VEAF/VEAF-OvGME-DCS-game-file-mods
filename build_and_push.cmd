@echo off
setlocal enabledelayedexpansion
set MODSNAME=VEAF DCS game mods
set FOLDER=VEAF_DCS_game_mods
set HTTPURL=http://aggressors.free.fr/repos_ovgme
echo.
echo ==========================================
echo  Building %MODSNAME%
echo ==========================================
echo.

rem Create build folder if needed
mkdir .\build

echo.
echo ----------------------------------------
echo  Packing mods
echo ----------------------------------------
echo.
rem Pack mods
for /f "tokens=*" %%i in ('DIR /a:d /b _*') DO (
    rem -- compile the mod
    call :packmods "%%i"
    call :rename_packed_folder "%%i"
)

rem Build xml file
echo ^<?xml version="1.0"?^> >.\build\repository.xml
echo ^<mod_list^> >>.\build\repository.xml
for /f "tokens=*" %%i in ('DIR /a:d /b x*') DO (
    rem -- compile the mod
    call :xml_lines "%%i"
)
echo ^</mod_list^> >>.\build\repository.xml

rem -- Pack built !
echo.
echo ----------------------------------------
echo  DCS VEAF user mods built
echo ----------------------------------------
echo.

echo.
echo ==========================================
echo  Pushing %MODSNAME% on repository
echo ==========================================
echo.

rem Pushing files
ftp -s:remoterepository.ftp
rd /s /q .\build

rem -- Mods pushed !
echo.
echo ========================================
echo  %MODSNAME% pushed on repository
echo ========================================
echo.

pause
GOTO :exit

rem Routine to pack mods
:packmods
 set temp=%1
 set modname=%temp:~2,-1%
 7za a -r -tzip .\build\%modname%.zip .\%1\* -mem=AES256 >nul 2>&1
 cd build
 ren %modname%.zip "%modname:_= %.zip"
 cd ..
 echo %modname% packed
 GOTO :eof

rem Routine to pack mods
:rename_packed_folder
 set oldfoldername=%1
 set newfoldername=x%oldfoldername:~2,-1%
 move %oldfoldername% %newfoldername%
 GOTO :eof

rem Routine to build xml line for each mod
:xml_lines
 set temp=%1
 set modname=!temp:~2,-1!
 set modnamecleaned=%modname:_=^ %
 set filename=!modname:_=%%20!
 set /p version=< .\%temp%\VERSION.txt
 set /p description=< .\%temp%\README.txt
 echo|set /p="<mod name="%modnamecleaned%" version="%version%" url="%HTTPURL%/%FOLDER%/%filename%.zip">%description%</mod>" >>.\build\repository.xml
 echo. >>.\build\repository.xml
 GOTO :eof


:exit
