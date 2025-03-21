@echo off
setlocal enabledelayedexpansion

echo === List ===
wmic diskdrive get model, deviceid, status

echo.
echo === Check ===
powershell -command "Get-PhysicalDisk | Select-Object DeviceID, MediaType, HealthStatus, OperationalStatus"

echo.
pause
§