@echo off
title Auto Installer Active.sav 120 FPS via ADB (Tanpa Root)
color 0A

echo =======================================================
echo    AUTO INSTALL ACTIVE.SAV (120 FPS) VIA ADB (PC)
echo            Khusus Poco / Xiaomi / Android
echo =======================================================
echo.

set "SAV_FILE=%~dp0120 FPS\files\UE4Game\ShadowTrackerExtra\ShadowTrackerExtra\Saved\SaveGames\Active.sav"

if not exist "%SAV_FILE%" (
    echo [ERROR] File Active.sav tidak ditemukan di:
    echo "%SAV_FILE%"
    pause
    exit /b
)

:: Cek ADB di sistem atau folder lokal
where adb >nul 2>nul
if %errorlevel% neq 0 (
    if not exist "%~dp0adb\adb.exe" (
        echo [INFO] Mengunduh ADB Portable untuk PC Anda...
        powershell -Command "Invoke-WebRequest -Uri 'https://dl.google.com/android/repository/platform-tools-latest-windows.zip' -OutFile '%~dp0platform-tools.zip'"
        powershell -Command "Expand-Archive -Path '%~dp0platform-tools.zip' -DestinationPath '%~dp0adb_temp' -Force"
        xcopy /E /I /Y "%~dp0adb_temp\platform-tools" "%~dp0adb" >nul
        rd /s /q "%~dp0adb_temp"
        del /f /q "%~dp0platform-tools.zip"
    )
    set "ADB_CMD=%~dp0adb\adb.exe"
) else (
    set "ADB_CMD=adb"
)

echo [1] Menghubungkan ke Perangkat...
echo Pastikan:
echo - Kabel USB terhubung ke PC
echo - USB Debugging di HP sudah AKTIF
echo - Jika muncul popup izin di layar HP, klik 'Izinkan / Allow'
echo.

"%ADB_CMD%" start-server >nul
"%ADB_CMD%" wait-for-device

echo [✓] Perangkat terdeteksi!
for /f "tokens=*" %%i in ('"%ADB_CMD%" shell getprop ro.product.model') do set DEVICE_MODEL=%%i
echo Model HP: %DEVICE_MODEL%
echo.

echo [2] Memasang file Active.sav ke folder Game...
set "TEMP_TARGET=/data/local/tmp/Active.sav"
"%ADB_CMD%" push "%SAV_FILE%" "%TEMP_TARGET%" >nul

:: Loop pemasangan ke semua varian PUBG
set PACKAGES=com.tencent.ig com.pubg.imobile com.vng.pubgmobile com.pubg.krmobile com.reindex.pubg

for %%P in (%PACKAGES%) do (
    "%ADB_CMD%" shell "if [ -d /sdcard/Android/data/%%P ]; then mkdir -p /sdcard/Android/data/%%P/files/UE4Game/ShadowTrackerExtra/ShadowTrackerExtra/Saved/SaveGames && cp /data/local/tmp/Active.sav /sdcard/Android/data/%%P/files/UE4Game/ShadowTrackerExtra/ShadowTrackerExtra/Saved/SaveGames/Active.sav && echo [✓] Sukses terpasang di %%P; fi"
)

"%ADB_CMD%" shell "rm -f /data/local/tmp/Active.sav"

echo.
echo =======================================================
echo [✓] SELESAI! File 120 FPS berhasil dipasang tanpa Root.
echo =======================================================
echo.
pause
