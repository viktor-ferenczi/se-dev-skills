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

if exist SteamMods goto skip_steam_mods
echo Linking the Steam content folder as SteamMods
mklink /J SteamMods "C:\Program Files (x86)\Steam\steamapps\workshop\content\244850"
if %ERRORLEVEL% EQU 0 goto skip_steam_mods
echo ERROR: Missing Steam content folder
echo Please fix the folder path on the `mklink` line in the `Prepare.bat` script.
goto failed
:skip_steam_mods

if exist LocalMods goto skip_local_mods
echo Linking the game's local Mods folder as LocalMods
mklink /J LocalMods "%AppData%\SpaceEngineers\Mods"
if %ERRORLEVEL% EQU 0 goto skip_local_mods
echo ERROR: Missing local Mods folder, this should not happen
goto failed
:skip_local_mods

echo DONE
echo DONE >Prepare.DONE
exit /b 0

:failed
echo FAILED
exit /b 1
