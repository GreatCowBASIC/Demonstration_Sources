@echo off
rem Adds the GCcode / SynWrite support for DIM ... AT location OVERRIDE (GCBASIC build 1660) to a GC Studio
rem installation. Usage:
rem     install_GCcode_Support.cmd                          (C:\GCstudio, the default)
rem     install_GCcode_Support.cmd "E:\GCstudio"            (another GC Studio folder: the one with gcbasic\ in it)
rem     install_GCcode_Support.cmd [folder] -WhatIf         (report only, change nothing)
rem     install_GCcode_Support.cmd [folder] -Force          (replace a file of another version by this folder's copy)
rem The work is done by install_GCcode_Support.ps1 (in this folder); see its notes.
setlocal
set "HERE=%~dp0"
set "TARGET=C:\GCstudio"
set "ARG1=%~1"
if not "%ARG1%"=="" if not "%ARG1:~0,1%"=="-" (
    set "TARGET=%~1"
    shift
)
powershell -NoProfile -ExecutionPolicy Bypass -File "%HERE%install_GCcode_Support.ps1" -Target "%TARGET%" %1 %2
exit /b %errorlevel%
