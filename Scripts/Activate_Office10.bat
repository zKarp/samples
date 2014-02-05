@echo off
ECHO.
ECHO This will activate Microsoft Office 2010 automatically
ECHO Close this window if you do NOT wish to activate Office 2010
ECHO.
ECHO.
pause
ECHO.
ECHO.
cscript "C:\Program Files\Microsoft Office\Office14\OSPP.VBS" /osppsvcrestart
ECHO.
ECHO.
cscript "C:\Program Files\Microsoft Office\Office14\OSPP.VBS" /act
ECHO.
ECHO If activation is unsuccessful close the window and try again.
pause