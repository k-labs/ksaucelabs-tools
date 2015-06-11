@echo off
REM loop over all input arguments (a list of domain names) and blacklist them via pointing them to localhost
REM idea from https://github.com/albedithdiaz/sauceSupport/blob/master/EditDNS_Windows.bat
REM has to be run from an elevated prompt

echo # > %temp%\temphosts.txt

REM the lovale junk below is just a loop on all input params... from http://stackoverflow.com/questions/19835849/batch-script-iterate-through-arguments
setlocal enableDelayedExpansion
set argCount=0
for %%x in (%*) do (
   set /A argCount+=1
   set "argVec[!argCount!]=%%~x"
)

for /L %%i in (1,1,%argCount%) do echo 127.0.0.1 !argVec[%%i]! >> %temp%\temphosts.txt

type C:\WINDOWS\system32\drivers\etc\hosts >> %temp%\temphosts.txt

REM type %temp%\temphosts.txt

copy /Y %temp%\temphosts.txt C:\WINDOWS\system32\drivers\etc\hosts

REM in case copying fails - see https://support.saucelabs.com/customer/portal/articles/2005376-edit-the-domain-name-system-dns-within-the-sauce-labs-virtual-machine-vm-

set HOSTALIASES=/tmp/hostaliases
setx HOSTALIASES=/tmp/hostaliases