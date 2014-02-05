@echo off

cls
echo Activating Windows 7
echo Please wait as this might take several minutes...
echo.
cscript //B "%windir%\system32\slmgr.vbs" /ipk LICENSE-KEY-GOES-HERE
cscript //B "%windir%\system32\slmgr.vbs" /ato

echo Activation complete!
pause
