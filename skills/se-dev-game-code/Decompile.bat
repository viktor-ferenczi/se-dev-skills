@echo off
echo Decompiling game assemblies...
echo Decompiling game assemblies: >Decompile.log

call DecompileDll.bat Sandbox.Common Bin64\Sandbox.Common.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat Sandbox.Game Bin64\Sandbox.Game.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat Sandbox.Game.XmlSerializers Bin64\Sandbox.Game.XmlSerializers.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat Sandbox.Graphics Bin64\Sandbox.Graphics.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat Sandbox.RenderDirect Bin64\Sandbox.RenderDirect.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat SpaceEngineers Bin64\SpaceEngineers.exe >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat SpaceEngineers.Game Bin64\SpaceEngineers.Game.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat SpaceEngineers.ObjectBuilders Bin64\SpaceEngineers.ObjectBuilders.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat SpaceEngineers.ObjectBuilders.XmlSerializers Bin64\SpaceEngineers.ObjectBuilders.XmlSerializers.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat VRage.Ansel Bin64\VRage.Ansel.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat VRage.Audio Bin64\VRage.Audio.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat VRage Bin64\VRage.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat VRage.EOS Bin64\VRage.EOS.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat VRage.EOS.XmlSerializers Bin64\VRage.EOS.XmlSerializers.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat VRage.Game Bin64\VRage.Game.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat VRage.Game.XmlSerializers Bin64\VRage.Game.XmlSerializers.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat VRage.Input Bin64\VRage.Input.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat VRage.Library Bin64\VRage.Library.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat VRage.Math Bin64\VRage.Math.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat VRage.Math.XmlSerializers Bin64\VRage.Math.XmlSerializers.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat VRage.Mod.Io Bin64\VRage.Mod.Io.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat VRage.NativeAftermath Bin64\VRage.NativeAftermath.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat VRage.NativeWrapper Bin64\VRage.NativeWrapper.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat VRage.Network Bin64\VRage.Network.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat VRage.Platform.Windows Bin64\VRage.Platform.Windows.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat VRage.Render Bin64\VRage.Render.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat VRage.Render11 Bin64\VRage.Render11.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat VRage.Scripting Bin64\VRage.Scripting.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat VRage.Steam Bin64\VRage.Steam.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat VRage.UserInterface Bin64\VRage.UserInterface.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

call DecompileDll.bat VRage.XmlSerializers Bin64\VRage.XmlSerializers.dll >>Decompile.log
if %ERRORLEVEL% NEQ 0 goto failed

:done
echo Successfully decompiled the game assemblies.
del Decompile.log
exit /b 0

:failed
echo Failed to decompile the game assemblies. Please check Decompile.log for details.
exit /b 1
