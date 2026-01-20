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

if exist busybox.exe goto skip_busybox
echo Downloading busybox
uv run python -u download_busybox.py
if %ERRORLEVEL% NEQ 0 goto failed
:skip_busybox

if exist SteamScripts goto skip_steam_scripts
echo Linking the Steam content folder as SteamScripts
mklink /J SteamScripts "C:\Program Files (x86)\Steam\steamapps\workshop\content\244850"
if %ERRORLEVEL% EQU 0 goto skip_steam_scripts
echo ERROR: Missing Steam content folder
echo Please fix the folder path on the `mklink` line in the `Prepare.bat` script.
goto failed
:skip_steam_scripts

if exist LocalScripts goto skip_local_scripts
echo Linking the game's local IngameScript\local folder as LocalScripts
mklink /J LocalScripts "%AppData%\SpaceEngineers\IngameScripts\local"
if %ERRORLEVEL% EQU 0 goto skip_local_scripts
echo ERROR: Missing local IngameScripts\local folder, this should not happen
goto failed
:skip_local_scripts

echo DONE
echo DONE >Prepare.DONE
exit /b 0

:failed
echo FAILED
exit /b 1
