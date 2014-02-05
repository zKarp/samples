REM:::SETS TEXT & BACKGROUND COLORS
CLS
@echo off
ECHO.
ECHO The following is meant to change the computer name after imaging on boot.
ECHO If this is incorrect please close the window.
ECHO.
ECHO.
ECHO The file will delete itself after a successful rename
ECHO.
Echo The current name of this PC is %ComputerName%
ECHO.

REM:::Prompts user for new Full computer name and assigns to PCNAME
SET /P PCNAME=Please enter NEW name for this PC: 


REM::: /v : To search for matching value names.
REM::: /d : Specifies the search in data only.
REM::: /t : Specifies registry value data type.
REM::: /f : Specifies the data or pattern to search for.

REM:::Changes registry key

REG ADD HKLM\SYSTEM\ControlSet001\Control\ComputerName /v ComputerName /t REG_SZ /d %PCNAME% /f
REG ADD HKLM\SYSTEM\ControlSet001\Control\ComputerName\ActiveComputerName /v ComputerName /t REG_SZ /d %PCNAME% /f
REG ADD HKLM\SYSTEM\ControlSet001\Control\ComputerName\ComputerName /v ComputerName /t REG_SZ /d %PCNAME% /f
REG ADD HKLM\SYSTEM\ControlSet002\Control\ComputerName\ComputerName /v ComputerName /t REG_SZ /d %PCNAME% /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Control\ComputerName /v ComputerName /t REG_SZ /d %PCNAME% /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName /t REG_SZ /d %PCNAME% /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName /t REG_SZ /d %PCNAME% /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters /v "NV ComputerName" /t REG_SZ /d %PCNAME% /f
REG ADD HKLM\SYSTEM\ControlSet001\Services\Tcpip\Parameters /v "NV Hostname" /t REG_SZ /d %PCNAME% /f
REG ADD HKLM\SOFTWARE\Novell\Login\Profiles\System\Default\Tab3 /v "Windows Domain" /t REG_SZ /d %PCNAME% /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultDomainName /t REG_SZ /d %PCNAME% /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AltDefaultDomainName /t REG_SZ /d %PCNAME% /f
REG ADD "HKEY_CURRENT_USER\Volatile Environment" /v LOGONSERVER /t REG_SZ /d %PCNAME% /f
REG ADD "HKEY_CURRENT_USER\Volatile Environment" /v USERDOMAIN /t REG_SZ /d %PCNAME% /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows Media Player NSS\3.0\Devices\00-00-00-00-00-00" /v FriendlyName /t REG_SZ /d %PCNAME% /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows Media Player NSS\3.0\UDNRenderers\9F6B5BF2-3C30-4CBD-B987-177DECD5661E" /v FriendlyName /t REG_SZ /d %PCNAME% /f

ECHO.
ECHO ***Computer will now restart...***
ECHO.

pause

shutdown -r -t 01 -c "System rebooting in 1 second"

del %0

REM:::Created BY: Ben Besmer, Zachary Karpinski.
