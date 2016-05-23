::@echo off

for /f "delims=" %%i in ('dir "c:\Program Files\Java\jre*" /OD- /B') do set javasource=c:\Program Files\Java\%%i
IF NOT EXIST %javasource%\nul goto nojava
set javaroot=r:\java
set dirletter=R


IF EXIST %javaroot%\nul GOTO skipmount

:: check if user is admin
:: openfiles > NUL 2>&1
:: IF NOT %ERRORLEVEL% EQU 0 goto notadmin

:: imdisk -a -t vm -s 500m -m %dirletter%: -p "/fs:ntfs /q /y"
IF NOT EXIST %dirletter%:\nul GOTO notr

:skipmount
IF EXIST %javaroot%\nul goto diralready

mkdir %javaroot%
xcopy /E /R /Y "%javasource%" "%javaroot%"

:: this doesn't require mkdir but let the BAT stuck for a while
:: echo d | xcopy /E /R /Y "%javasource%" "%javaroot%"

goto end
:: ------------------------------------------------------

:notadmin
echo You must run as administrator.
goto end

:: ------------------------------------------------------

:notr
echo Can't create %dirletter%: as ramdisk.
goto end

:: ------------------------------------------------------

:diralready
echo %javaroot% already exists, can't proceed.
goto end

:: ------------------------------------------------------

:nojava
echo Can't find Java location to copy from.
goto end

:: ------------------------------------------------------
:end
echo.
pause
