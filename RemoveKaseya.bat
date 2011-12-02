REM-Windows Batch file to stop service, disable and clean registry
:: Author Justin (barber.justin@gmail.com)
@ECHO OFF

:: Used this site as a guide in developing these scripts
:: http://blog.kazmarek.com/2009/10/15/manually-uninstall-kaseya-agent/

:: References
:: http://www.computerhope.com/batch.htm

:BEGIN
set service="KaseyaAVService"

:QUERY
:: Find out if service exists/running
setlocal
sc query %service% > temp.txt
endlocal

:STOP
sc stop %service% 

:DISABLE
sc config %service% start=disabled

:DELETE
sc delete %service% 

:CLEAN
:: Unable to find the Setup.exe in our setups.
:: Going straight to cleaning registry
:: http://support.microsoft.com/kb/310516
regedit.exe CleanRegistry.reg

:END
