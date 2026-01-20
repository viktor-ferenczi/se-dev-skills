@echo off
echo Preparing all skills. It may take 6-16 minutes, be patient.

cd skills

cd se-dev-script
call Prepare.bat
if %ERRORLEVEL% NEQ 0 goto failed
cd ..

echo ---

cd se-dev-mod
call Prepare.bat
if %ERRORLEVEL% NEQ 0 goto failed
cd ..

echo ---

cd se-dev-plugin
call Prepare.bat
if %ERRORLEVEL% NEQ 0 goto failed
cd ..

echo ---

cd se-dev-game-code
call Prepare.bat
if %ERRORLEVEL% NEQ 0 goto failed
cd ..

echo ---

goto DONE

:failed
cd ..\..
echo LATEST ONE FAILED, SEE ABOVE
exit /b 1

:done
cd ..
echo ALL DONE
exit /b 0
