@echo off
setlocal EnableExtensions
cd /d "%~dp0"
title TA-STORE-VN - Don dep runtime tam

if not exist "%~dp0server.js" (
  echo [LOI] Hay dat file nay cung thu muc voi server.js va start.bat.
  pause
  exit /b 1
)

echo =====================================================
echo       TA-STORE-VN - DON DEP FILE TAM
echo =====================================================
echo.
echo File nay CHI xoa trong thu muc project hien tai:
echo   - .runtime  (log, PID, file tam va runtime cu neu co)
echo   - PUBLIC_URL.txt
echo.
echo KHONG xoa database key trong data\store.json, config.json,
echo ma nguon website, Node.js da cai tren Windows, hay file ca nhan.
echo.
echo Neu website dang chay, hay bam stop.bat truoc khi don dep.
echo.
choice /C YN /N /M "Ban chac chan muon xoa file tam cua project nay? [Y/N] "
if errorlevel 2 goto CANCEL

if exist "%~dp0.runtime\node.pid" (
  echo [CANH BAO] Phat hien PID Node.js trong .runtime.
  echo Hay chay stop.bat de dung website truoc, sau do chay lai file nay.
  pause
  exit /b 2
)
if exist "%~dp0.runtime\watchdog.pid" (
  echo [CANH BAO] Phat hien PID watchdog trong .runtime.
  echo Hay chay stop.bat de dung website truoc, sau do chay lai file nay.
  pause
  exit /b 2
)

if exist "%~dp0.runtime" rmdir /s /q "%~dp0.runtime"
if exist "%~dp0PUBLIC_URL.txt" del /f /q "%~dp0PUBLIC_URL.txt"
if exist "%~dp0PUBLIC_URL.txt.tmp" del /f /q "%~dp0PUBLIC_URL.txt.tmp"

echo.
echo [OK] Da don dep file tam cua project.
echo Du lieu key va cau hinh duoc giu nguyen.
pause
exit /b 0

:CANCEL
echo Da huy. Khong co file nao bi xoa.
exit /b 0
