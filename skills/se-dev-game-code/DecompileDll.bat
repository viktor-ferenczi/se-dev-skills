@echo off
echo Decompiling: %1

if exist Decompiled\%1 goto skip1
ilspycmd --project --nested-directories --referencepath Bin64 --languageversion CSharp11_0 --disable-updatecheck -o Decompiled\%1 %2
if %ERRORLEVEL% NEQ 0 goto failed
ilspycmd --ilcode --il-sequence-points -o Decompiled\%1 %2
if %ERRORLEVEL% NEQ 0 goto failed
:skip1
exit /b 0

:failed
exit /b 1
