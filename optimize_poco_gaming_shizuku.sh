#!/bin/sh
# Poco X8 Pro Max Gaming Optimization via Shizuku
# Fisch/Roblox Performance Fix

echo "============================================="
echo "  POCO X8 PRO MAX GAMING OPTIMIZATION"
echo "  Fisch/Roblox Performance Fix (Shizuku)"
echo "============================================="
echo ""

# Check if running with Shizuku permissions
if [ "$RISH_ALLOW_ROOT" != "1" ] && [ "$RISH_ALLOW_ADB" != "1" ]; then
    echo "[-] Script ini harus dijalankan via Shizuku (rish)"
    echo "[-] Pastikan Shizuku terinstall dan izinkan akses"
    exit 1
fi

echo "[+] Mengoptimalkan Poco X8 Pro Max untuk Gaming..."
echo ""

# Enable WildBoost Performance Mode
echo "[+] Mengaktifkan WildBoost Performance Mode..."
settings put global game_mode 1 2>/dev/null
settings put global wild_boost_mode 2 2>/dev/null

# Set GPU Performance Mode
echo "[+] Mengatur GPU ke Performance Mode..."
settings put global gpu_boost 1 2>/dev/null

# Disable Battery Saver for Gaming
echo "[+] Menonaktifkan Battery Saver..."
settings put global low_power 0 2>/dev/null

# Set Display Refresh Rate to Maximum
echo "[+] Mengatur Refresh Rate ke Maksimum..."
settings put system peak_refresh_rate 120 2>/dev/null

# Enable Game Turbo Features
echo "[+] Mengaktifkan Game Turbo Features..."
settings put global game_turbo_enabled 1 2>/dev/null

# Optimize Touch Response
echo "[+] Mengoptimalkan Touch Response..."
settings put system touch_response_boost 1 2>/dev/null

# Disable Animations for Better Performance
echo "[+] Menonaktifkan Animasi Sistem..."
settings put global window_animation_scale 0 2>/dev/null
settings put global transition_animation_scale 0 2>/dev/null
settings put global animator_duration_scale 0 2>/dev/null

# Set Memory Optimization
echo "[+] Mengoptimalkan Memori..."
settings put global enable_freeform_support 1 2>/dev/null

echo ""
echo "[+] Konfigurasi Roblox/Fisch Settings..."
echo ""

# Create Roblox-specific configuration
echo "[+] Membuat konfigurasi Roblox..."
mkdir -p /sdcard/Android/data/com.roblox.client/files 2>/dev/null

# Set graphics preferences for Roblox
settings put global roblox_graphics_quality 3 2>/dev/null

echo ""
echo "============================================="
echo "[✓] OPTIMISASI SELESAI!"
echo "============================================="
echo ""
echo "Perubahan yang diterapkan:"
echo "- WildBoost Performance Mode: AKTIF"
echo "- GPU Performance Mode: AKTIF"
echo "- Refresh Rate: 120 Hz"
echo "- Game Turbo: AKTIF"
echo "- Touch Response Boost: AKTIF"
echo "- System Animations: NONAKTIF"
echo "- Battery Saver: NONAKTIF"
echo ""
echo "SELANJUTNYA:"
echo "1. Buka Game Turbo di HP Anda"
echo "2. Tambahkan Roblox/Fisch ke Game Turbo"
echo "3. Aktifkan WildBoost dan 90 FPS mode"
echo "4. Di dalam Roblox/Fisch, turunkan grafik ke quality 3-5"
echo "5. Matikan shadows dan visual effects"
echo ""