#!/bin/sh
# Script Otomatis Pasang Active.sav 120 FPS via Shizuku (rish) / ADB Shell
# Tanpa Root - Khusus Xiaomi / Poco / Android 11-15+

echo "============================================="
echo "   AUTO PUSH ACTIVE.SAV (120 FPS) SHIZUKU    "
echo "============================================="

# Lokasi sumber file (letakkan Active.sav di folder Download HP)
SRC="/sdcard/Download/Active.sav"

if [ ! -f "$SRC" ]; then
    echo "[-] File Active.sav tidak ditemukan di folder Download (/sdcard/Download/)!"
    echo "[!] Harap salin file Active.sav ke folder Download terlebih dahulu."
    exit 1
fi

# Daftar package name PUBG Mobile yang didukung
PACKAGES="com.tencent.ig com.pubg.imobile com.vng.pubgmobile com.pubg.krmobile com.reindex.pubg"

SUCCESS=0

for PKG in $PACKAGES; do
    TARGET_DIR="/sdcard/Android/data/$PKG/files/UE4Game/ShadowTrackerExtra/ShadowTrackerExtra/Saved/SaveGames"
    if [ -d "/sdcard/Android/data/$PKG" ]; then
        echo "[+] Ditemukan game: $PKG"
        mkdir -p "$TARGET_DIR" 2>/dev/null
        cp "$SRC" "$TARGET_DIR/Active.sav"
        chmod 660 "$TARGET_DIR/Active.sav" 2>/dev/null
        if [ -f "$TARGET_DIR/Active.sav" ]; then
            echo "[✓] BERHASIL dipasang ke $PKG"
            SUCCESS=1
        else
            echo "[-] Gagal menyalin ke $PKG (Cek izin rish/Shizuku)"
        fi
    fi
done

if [ $SUCCESS -eq 1 ]; then
    echo "============================================="
    echo " [✓] SELESAI! Silakan buka game Anda & nikmati 120 FPS."
    echo "============================================="
else
    echo "[-] Tidak ada folder game PUBG yang terdeteksi di /sdcard/Android/data/."
fi
