@echo off
REM 同步静态文件到 www 目录（用于 Capacitor 打包）
echo.
echo ========================================
echo   同步文件到 www 目录
echo ========================================
echo.

cd /d "%~dp0"

REM 复制 HTML 文件
echo [1/4] 复制 HTML 文件...
copy /Y index.html www\ >nul
copy /Y 404.html www\ >nul

REM 复制 assets 目录
echo [2/4] 复制 assets 目录...
if exist www\assets rmdir /s /q www\assets
xcopy /E /I /Y assets www\assets >nul

REM 复制其他资源文件
echo [3/4] 复制资源文件...
copy /Y *.webmanifest www\ >nul 2>nul
copy /Y *.png www\ >nul 2>nul
copy /Y *.jpg www\ >nul 2>nul
copy /Y *.webp www\ >nul 2>nul
copy /Y *.mp3 www\ >nul 2>nul
copy /Y sw*.js www\ >nul 2>nul
copy /Y workbox*.js www\ >nul 2>nul

REM 复制 audio 目录（环境背景音）
if exist www\audio rmdir /s /q www\audio
xcopy /E /I /Y audio www\audio >nul

REM 同步到 Android
echo [4/4] 同步到 Capacitor...
call npx cap sync

if %errorlevel% neq 0 (
    echo.
    echo [错误] 同步失败！
    pause
    exit /b 1
)

echo.
echo ========================================
echo   ✓ 同步完成！
echo ========================================
echo.
pause
