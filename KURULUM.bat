@echo off
setlocal
chcp 65001 >nul
title Master Kodlama Terminali - Kurulum

echo ================================================================
echo              MASTER KODLAMA TERMINALI KURULUMU
echo                       Kurucu: xllor
echo ================================================================
echo.

where py >nul 2>nul
if %errorlevel%==0 (
    set "PYTHON=py"
) else (
    where python >nul 2>nul
    if errorlevel 1 goto :python_yok
    set "PYTHON=python"
)

echo [1/4] Python surumu kontrol ediliyor...
%PYTHON% -c "import sys; raise SystemExit(0 if sys.version_info >= (3, 10) else 1)"
if errorlevel 1 (
    echo [HATA] Python 3.10 veya daha yeni bir surum gerekli.
    goto :hata
)

echo [2/4] Paket yoneticisi hazirlaniyor...
%PYTHON% -m pip install --upgrade pip
if errorlevel 1 goto :hata

echo [3/4] Gerekli kutuphaneler yukleniyor...
%PYTHON% -m pip install -r requirements.txt
if errorlevel 1 goto :hata

echo [4/4] Kurulum dogrulaniyor...
if not exist "cikti" mkdir "cikti"
%PYTHON% -c "from modules.commands import Terminal; Terminal(); print('[OK] Terminal basariyla hazirlandi.')"
if errorlevel 1 goto :hata

echo.
echo ================================================================
echo  KURULUM TAMAMLANDI
echo  Programi acmak icin BASLAT.bat dosyasina cift tiklayin.
echo ================================================================
pause
exit /b 0

:python_yok
echo [HATA] Python bulunamadi.
echo Python 3.10 veya daha yenisini https://www.python.org/downloads/
echo adresinden kurun. Kurulumda "Add Python to PATH" secenegini isaretleyin.
goto :hata

:hata
echo.
echo Kurulum tamamlanamadi. Yukaridaki hata mesajini kontrol edin.
pause
exit /b 1

