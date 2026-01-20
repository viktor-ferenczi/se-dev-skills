@echo off

echo Verifying Python
python --version
if %ERRORLEVEL% EQU 0 goto has_python
echo ERROR: Missing Python
echo Please install Python 3.13 or newer. 
echo Make sure python.exe is on PATH.
goto failed
:has_python

uv -V 2>NUL
if %ERRORLEVEL% EQU 0 goto skip_uv
echo Installing uv
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
uv -V
if %ERRORLEVEL% NEQ 0 goto failed
:skip_uv

if exist .venv goto skip_venv
echo Setting up Python .venv (uv sync)
uv sync
:skip_venv

echo Installing ILSpy (if not installed already)
ilspycmd -v 2>NUL
if %ERRORLEVEL% EQU 0 goto skip_ilspycmd
dotnet tool install --global ilspycmd
ilspycmd -v
if %ERRORLEVEL% NEQ 0 goto failed
:skip_ilspycmd

if exist Bin64 goto skip_bin64
echo Linking the game folder as Bin64
REM It must be the folder where SpaceEngineers.exe is located:
mklink /J Bin64 "C:\Program Files (x86)\Steam\steamapps\common\SpaceEngineers\Bin64"
if %ERRORLEVEL% EQU 0 goto skip_bin64
echo ERROR: Missing Bin64 folder.
echo Please verify that Space Engineers (version 1) is installed.
echo If Space Engineers is installed at custom location, then please update the absolute path to the `Bin64` folder in the `mklink` command inside `Prepare.bat` accordingly and try again.
goto failed
:skip_bin64

if exist Decompiled\VRage.XmlSerializers goto skip_decompile
call Decompile.bat
if %ERRORLEVEL% NEQ 0 goto failed
:skip_decompile

rmdir /s /q Bin64

if exist Content goto skip_content
echo Copying indexable content
uv run python -u copy_content.py
if %ERRORLEVEL% NEQ 0 goto failed
:skip_content

if exist CodeIndex\variables.csv goto skip_index
echo Indexing decompiled code
mkdir CodeIndex 2>NUL
uv run python -OO -u index_code.py Decompiled CodeIndex
if %ERRORLEVEL% NEQ 0 goto failed
:skip_index

echo DONE
del "\\?\%cd%\nul"
echo DONE >Prepare.DONE
exit /b 0

:failed
echo FAILED
exit /b 1
