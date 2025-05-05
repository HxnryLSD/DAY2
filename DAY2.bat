@echo off

:: Check for administrative privileges at the start of the script
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    powershell -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('This script requires administrative privileges. Please run it as an administrator.', 'Error', 'OK', 'Error')"
    exit
)

:: Define the total number of steps for each routine
set reset_network_steps=7
set optimize_network_steps=16

set /a step_counter=0

:UpdateProgress
:: Updates the progress percentage in the title bar
set /a progress=(step_counter*100)/total_steps
set title_text=DAY2 / [%progress%%]
title %title_text%

:: Logging function to write messages to a log file
:LogMessage
set log_file=DAY2.log
set timestamp=%date% %time%
echo [%timestamp%] %1 >> %log_file%
goto :eof

:CheckError
:: Check the error level and display a message box if an error occurred
if %ERRORLEVEL% NEQ 0 (
    call :LogMessage "Error occurred: %1"
    powershell -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('An error occurred while executing the command: %1', 'Error', 'OK', 'Error')"
    exit
)

:Menu
cls
:: Display the main menu to the user
echo Select an option:
echo 1. Reset network
echo 2. Optimize network
echo 3. Exit
set /p choice=Input: 
if "%choice%" == "1" goto ResetNetwork
if "%choice%" == "2" goto OptimizeNetwork
if "%choice%" == "3" exit
echo Invalid input. Please try again.
pause
goto Menu

:ResetNetwork
:: Set the total steps for ResetNetwork

set total_steps=%reset_network_steps%

set /a step_counter+=1
call :UpdateProgress
call :LogMessage "Executing: ipconfig /flushdns"
ipconfig /flushdns
call :CheckError "ipconfig /flushdns"

set /a step_counter+=1
call :UpdateProgress
call :LogMessage "Executing: netsh int ip reset"
netsh int ip reset
call :CheckError "netsh int ip reset"

set /a step_counter+=1
call :UpdateProgress
call :LogMessage "Executing: ipconfig /registerdns"
ipconfig /registerdns
call :CheckError "ipconfig /registerdns"

set /a step_counter+=1
call :UpdateProgress
call :LogMessage "Executing: ipconfig /release"
ipconfig /release
call :CheckError "ipconfig /release"

set /a step_counter+=1
call :UpdateProgress
call :LogMessage "Executing: ipconfig /renew"
ipconfig /renew
call :CheckError "ipconfig /renew"

set /a step_counter+=1
call :UpdateProgress
call :LogMessage "Executing: netsh winsock reset"
netsh winsock reset
call :CheckError "netsh winsock reset"

:: Exit after completing the reset
set /a step_counter+=1
call :UpdateProgress
pause
goto Menu

:OptimizeNetwork
:: Optimize network settings for better performance

set total_steps=%optimize_network_steps%

set /a step_counter+=1
call :UpdateProgress
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_SZ /d "ffffffff" /f
call :CheckError "Reg.exe add NetworkThrottlingIndex"

set /a step_counter+=1
call :UpdateProgress
nbtstat -R
call :CheckError "nbtstat -R"

set /a step_counter+=1
call :UpdateProgress
nbtstat -RR
call :CheckError "nbtstat -RR"

set /a step_counter+=1
call :UpdateProgress
arp -d *
call :CheckError "arp -d *"

set /a step_counter+=1
call :UpdateProgress
netsh interface ip delete arpcache
call :CheckError "netsh interface ip delete arpcache"

set /a step_counter+=1
call :UpdateProgress
netsh interface tcp set global autotuninglevel=highlyrestricted
call :CheckError "netsh interface tcp set global autotuninglevel=highlyrestricted"

set /a step_counter+=1
call :UpdateProgress
netsh interface tcp set global heuristics=disabled
call :CheckError "netsh interface tcp set global heuristics=disabled"

set /a step_counter+=1
call :UpdateProgress
netsh interface tcp set global congestionprovider=ctcp
call :CheckError "netsh interface tcp set global congestionprovider=ctcp"

set /a step_counter+=1
call :UpdateProgress
netsh interface tcp set global rss=enabled
call :CheckError "netsh interface tcp set global rss=enabled"

set /a step_counter+=1
call :UpdateProgress
netsh interface tcp set global chimney=enabled
call :CheckError "netsh interface tcp set global chimney=enabled"

set /a step_counter+=1
call :UpdateProgress
netsh interface tcp set global timestamps=disabled
call :CheckError "netsh interface tcp set global timestamps=disabled"

set /a step_counter+=1
call :UpdateProgress
netsh interface tcp set global ecncapability=enabled
call :CheckError "netsh interface tcp set global ecncapability=enabled"

set /a step_counter+=1
call :UpdateProgress
netsh interface tcp set global maxsynretransmissions=1
call :CheckError "netsh interface tcp set global maxsynretransmissions=1"

set /a step_counter+=1
call :UpdateProgress
netsh interface ip set global nonbest_effort_limit=0
call :CheckError "netsh interface ip set global nonbest_effort_limit=0"

set /a step_counter+=1
call :UpdateProgress
netsh winsock reset catalog
call :CheckError "netsh winsock reset catalog"

:: Exit after completing the optimization
set /a step_counter+=1
call :UpdateProgress
pause
goto Menu