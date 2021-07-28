@echo off
Rem Hassan Uddin[EXT] 2021 jully

 call :isAdmin

 if %errorlevel% == 0 (
    goto :run
 ) else (
    echo Requesting administrative privileges...
    goto :UACPrompt
 )

 exit /b

 :isAdmin
    fsutil dirty query %systemdrive% >nul
 exit /b

 :run
 set input-fileDir="%~f1"
set input-path="%~dp1b"
set file="%~n1.cab"
set "k=%input-path%\"
if not exist %input-path% mkdir %input-path%
Expand -F:* %input-fileDir% %input-path%
SET VAR=
FOR /F %%I IN ('dir %k%*Windows10*.cab /s /b') DO CALL %0 %%I
SET VAR
SET VAR=%VAR%%1
DISM.exe /online /add-package /packagepath:%VAR%
  
 exit /b

 :UACPrompt
   echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
   echo UAC.ShellExecute "cmd.exe", "/c %~s0 %~1", "", "runas", 1 >> "%temp%\getadmin.vbs"

   "%temp%\getadmin.vbs"
   del "%temp%\getadmin.vbs"
  exit /B`