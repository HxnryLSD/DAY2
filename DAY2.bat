@echo off

echo.  
echo.  
echo       :::::::::      :::   :::   :::  ::::::::  
echo       :+:    :+:   :+: :+: :+:   :+: :+:    :+: 
echo       +:+    +:+  +:+   +:+ +:+ +:+        +:+  
echo       +#+    +:+ +#++:++#++: +#++:       +#+    
echo       +#+    +#+ +#+     +#+  +#+      +#+      
echo       #+#    #+# #+#     #+#  #+#     #+#       
echo       #########  ###     ###  ###    ########## 
echo.  
echo.         Network Optimizer and Resetter
title DAY2 / Welcome User!
color 0d
timeout 2 > nul
color 0f
echo.  
echo.  
echo.  

echo.       List what will happen:
echo.  


echo.    - Depot forwarding is reset
echo.    - Depot is reset
echo.    - Control protocol is reset
echo.    - Echo sequence request is reset
echo.    - Global is reset
echo.    - Reset interface
echo.    - Anycast address is reset
echo.    - Reset multicast address
echo.    - Reset unicast address
echo.    - Neighbor is reset
echo.    - Path is reset
echo.    - Potential is reset
echo.    - Reset prefix policy
echo.    - Reset proxy neighbor
echo.    - Reset route
echo.    - Reset location prefix
echo.    - Reset subinterface
echo.    - Reset reactivation pattern
echo.    - Resolve neighbor is reset
echo.    - Flushing DNS Cache
echo.    - Deleting Temp Data
echo.    - Clearing NetBIOS name cache
echo.    - Name resolution refresh
echo.    - Clearing ARP cache
echo.    - MAC address reconnecting

title DAY2 / Waiting For Permission ...
echo.     
echo.     
echo.       ! Press Any Button To Continue

timeout 999 > nul

NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (

cls
title DAY2 / Received Permissions
echo.     
echo.     Administrator rights Detected!
echo.     
color 0a
timeout 1 > nul
color 0f

) ELSE (

cls
title DAY2 / ERROR NO ADMIN RIGHTS - EXITING
echo.     
echo.     
echo           :::::::::: :::::::::  :::::::::   ::::::::  :::::::::
echo          :+:        :+:    :+: :+:    :+: :+:    :+: :+:    :+:
echo         +:+        +:+    +:+ +:+    +:+ +:+    +:+ +:+    +:+
echo        +#++:++#   +#++:++#:  +#++:++#:  +#+    +:+ +#++:++#:
echo       +#+        +#+    +#+ +#+    +#+ +#+    +#+ +#+    +#+
echo      #+#        #+#    #+# #+#    #+# #+#    #+# #+#    #+#
echo     ########## ###    ### ###    ###  ########  ###    ###
echo.     
echo.     
echo.     No Administrator rights detected.
echo.     
echo.     THE PROCESS IS TERMINATED!
echo.     
echo.     
echo.     Press Any Key To Close...
echo.     
color c0
timeout 1 > nul
color 0c
timeout 1 > nul
color c0
timeout 1 > nul
color 0c

timeout 10 > nul
exit
)

title DAY2 /  [2%]
ipconfig /flushdns

timeout 1 > nul

title DAY2 / [11%]
netsh int ip reset


title DAY2 / [24%]
ipconfig /registerdns


title DAY2 / [29%]
ipconfig /release


title DAY2 / [34%]
ipconfig /renew


title DAY2 / [40%]
netsh winsock reset


timeout 1 > nul

title DAY2 / [57%]
TAKEOWN /F C:\Windows\Prefetch /A
rd C:\Windows\Prefetch /s /q && md C:\Windows\Prefetch


title DAY2 / [62%]
TAKEOWN /F %USERPROFILE%\AppData\Local\Temp /A
rd %USERPROFILE%\AppData\Local\Temp /s /q && md %USERPROFILE%\AppData\Local\Temp


title DAY2 / [68%]
TAKEOWN /F C:\Windows\Temp /A
rd C:\Windows\Temp /s /q && md C:\Windows\Temp


title DAY2 / [69%]
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_SZ /d "ffffffff" /f


title DAY2 / [80%]
nbtstat -R
nbtstat -RR


title DAY2 / [92%]
arp -d *

cls
title DAY2 / DONE [100%]
echo     :::::::::      :::   :::   :::  ::::::::  
echo     :+:    :+:   :+: :+: :+:   :+: :+:    :+: 
echo     +:+    +:+  +:+   +:+ +:+ +:+        +:+  
echo     +#+    +:+ +#++:++#++: +#++:       +#+    
echo     +#+    +#+ +#+     +#+  +#+      +#+      
echo     #+#    #+# #+#     #+#  #+#     #+#       
echo     #########  ###     ###  ###    ########## 
echo.     
echo.     
echo.     Press Any Button To Exit
echo.     

Pause > nul