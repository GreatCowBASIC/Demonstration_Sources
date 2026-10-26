@echo off
rem install_GCcode_Support.cmd - adds #option IncludePath (GCBASIC build 1661) to GCcode's highlighting and autocomplete
rem and to SynWrite's list, in a GC Studio installation. Double-click it.
rem
rem   install_GCcode_Support.cmd [GC Studio folder] [-WhatIf]
rem   the folder: GCBASIC_INSTALL_PATH, else C:\GCstudio. -WhatIf shows what it would do and changes nothing.
rem Each file changed is backed up first (.bak_<date>); a file that already has it is left alone.
setlocal
if "%~1"=="" (
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0install_GCcode_Support.ps1"
) else (
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0install_GCcode_Support.ps1" %*
)
set RC=%ERRORLEVEL%
echo.
if %RC%==0 (echo install_GCcode_Support: OK) else (echo install_GCcode_Support: see the messages above ^(exit %RC%^))
pause
exit /b %RC%
