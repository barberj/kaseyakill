rem Windows Batch file to stop service, disable and clean registry
:: Author Justin (barber.justin@gmail.com)
@echo off

:: Used this site as a guide in developing these scripts
:: http://blog.kazmarek.com/2009/10/15/manually-uninstall-kaseya-agent/

:: References
:: http://www.computerhope.com/batch.htm
:: http://ss64.com/nt/sc.html

:begin
set service="KaseyaAVService"
set service_dir=C:\Program Files\Kaseya

:exists
:: Find out if service exists
sc query %service% | find "STATE" 
if errorlevel 1 goto :end

:running
:: Find out if service running
echo %service% exists
sc query %service% | find "RUNNING"
if errorlevel 1 goto :disable

:stop
ECHO %service% is running. Going to stop.
sc stop %service% 

:wait
echo ...stopping
sc query %service% | FIND "STOPPED"
if errorlevel 1 goto :wait

:disable
echo Disabling %service%
sc config %service% start= disabled | find "SUCCESS"

:delete
echo Deleting %service%
sc delete %service% 

:clean
:: Unable to find the Setup.exe in our setups.
:: Going straight to cleaning registry
:: http://support.microsoft.com/kb/310516
echo Cleaning registry 
regedit.exe CleanRegistry.reg

:filesys
:: We have some files on the system we don't want
if exist %service_dir% ( echo going to delete ) else ( echo doesn't exists )

:end
echo %service% has been removed from %computername%
