@echo off

REM idea from https://github.com/albedithdiaz/sauceSupport/blob/master/EditDNS_Windows.bat

echo  74.125.239.112 www.saucelabs.com > %temp%\temphosts.txt
type C:\WINDOWS\system32\drivers\etc\hosts >> %temp%\temphosts.txt
copy /Y %temp%\temphosts.txt C:\WINDOWS\system32\drivers\etc\hosts
