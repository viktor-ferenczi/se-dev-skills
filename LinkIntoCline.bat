@echo off
setlocal enabledelayedexpansion

set "SOURCE_BASE=%~dp0skills"
set "TARGET_BASE=%USERPROFILE%\.cline\skills"

if not exist "%TARGET_BASE%" (
    echo Creating target directory: %TARGET_BASE%
    mkdir "%TARGET_BASE%"
)

set "FOLDERS=se-dev-script se-dev-mod se-dev-plugin se-dev-game-code"

echo.
echo Linking skills into Cline's skills folder:

:: 5. Loop through each folder and create the link
for %%F in (%FOLDERS%) do (
    set "SRC=!SOURCE_BASE!\%%F"
    set "DEST=!TARGET_BASE!\%%F"

    if exist "!SRC!" (
        if exist "!DEST!" (
            echo [SKIP] Link or folder already exists at: !DEST!
        ) else (
            mklink /J "!DEST!" "!SRC!"
        )
    ) else (
        echo [ERROR] Source folder not found: !SRC!
    )
)

echo DONE
pause