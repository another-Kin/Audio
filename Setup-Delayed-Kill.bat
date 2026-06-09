@echo off
echo ====================================================
echo Setting up Delayed Kill for Performance Services
echo ====================================================
echo.
echo 1. Ensuring services can start with Windows to prevent Explorer delays...
sc.exe config WpnService start= auto >nul 2>&1
sc.exe config wlidsvc start= demand >nul 2>&1
sc.exe config AppIDSvc start= demand >nul 2>&1

echo 2. Creating Scheduled Task to kill them 60 seconds after login...
schtasks /create /tn "Audiophile_Delayed_Kill" /tr "powershell.exe -WindowStyle Hidden -Command \"Stop-Service -Name TimeBrokerSvc,WpnService,wlidsvc,AppIDSvc -Force -ErrorAction SilentlyContinue\"" /sc onlogon /delay 0001:00 /rl highest /f

echo.
echo [OK] All done! Upon your next reboot:
echo - Your desktop will load instantly.
echo - Exactly 1 minute later, these background services will be silently killed.
timeout /t 3 >nul
exit
