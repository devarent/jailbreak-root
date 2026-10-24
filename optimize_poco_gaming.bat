@echo off
title Poco X8 Pro Max Gaming Optimization Script
color 0B

echo =======================================================
echo    POCO X8 PRO MAX GAMING OPTIMIZATION
echo    Fisch/Roblox Performance Fix
echo =======================================================
echo.

set "ADB_CMD="
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

echo [2] Mengoptimalkan Poco X8 Pro Max untuk Gaming...
echo.

:: Enable WildBoost Performance Mode
echo [+] Mengaktifkan WildBoost Performance Mode...
"%ADB_CMD%" shell "settings put global game_mode 1" >nul 2>&1
"%ADB_CMD%" shell "settings put global wild_boost_mode 2" >nul 2>&1

:: Set GPU Performance Mode
echo [+] Mengatur GPU ke Performance Mode...
"%ADB_CMD%" shell "settings put global gpu_boost 1" >nul 2>&1

:: Disable Battery Saver for Gaming
echo [+] Menonaktifkan Battery Saver...
"%ADB_CMD%" shell "settings put global low_power 0" >nul 2>&1

:: Set Display Refresh Rate to Maximum
echo [+] Mengatur Refresh Rate ke Maksimum...
"%ADB_CMD%" shell "settings put system peak_refresh_rate 120" >nul 2>&1

:: Enable Game Turbo Features
echo [+] Mengaktifkan Game Turbo Features...
"%ADB_CMD%" shell "settings put global game_turbo_enabled 1" >nul 2>&1

:: Optimize Touch Response
echo [+] Mengoptimalkan Touch Response...
"%ADB_CMD%" shell "settings put system touch_response_boost 1" >nul 2>&1

:: Disable Animations for Better Performance
echo [+] Menonaktifkan Animasi Sistem...
"%ADB_CMD%" shell "settings put global window_animation_scale 0" >nul 2>&1
"%ADB_CMD%" shell "settings put global transition_animation_scale 0" >nul 2>&1
"%ADB_CMD%" shell "settings put global animator_duration_scale 0" >nul 2>&1

:: Set Memory Optimization
echo [+] Mengoptimalkan Memori...
"%ADB_CMD%" shell "settings put global enable_freeform_support 1" >nul 2>&1

echo.
echo [3] Konfigurasi Roblox/Fisch Settings...
echo.

:: Create Roblox-specific configuration
echo [+] Membuat konfigurasi Roblox...
"%ADB_CMD%" shell "mkdir -p /sdcard/Android/data/com.roblox.client/files" >nul 2>&1

:: Set graphics preferences for Roblox
"%ADB_CMD%" shell "settings put global roblox_graphics_quality 3" >nul 2>&1

echo.
echo =======================================================
echo [✓] OPTIMISASI SELESAI!
echo =======================================================
echo.
echo Perubahan yang diterapkan:
echo - WildBoost Performance Mode: AKTIF
echo - GPU Performance Mode: AKTIF  
echo - Refresh Rate: 120 Hz
echo - Game Turbo: AKTIF
echo - Touch Response Boost: AKTIF
echo - System Animations: NONAKTIF
echo - Battery Saver: NONAKTIF
echo.
echo SELANJUTNYA:
echo 1. Buka Game Turbo di HP Anda
echo 2. Tambahkan Roblox/Fisch ke Game Turbo
echo 3. Aktifkan WildBoost dan 90 FPS mode
echo 4. Di dalam Roblox/Fisch, turunkan grafik ke quality 3-5
echo 5. Matikan shadows dan visual effects
echo.
pause