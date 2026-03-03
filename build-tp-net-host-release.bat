@echo off
chcp 65001 >nul
title Build Tp-net-host-release

echo ================================
echo Cloning TP Net staging projects
echo ================================
echo.

set BRANCH=staging
set BASE_URL=https://github.com/tungttsmd
set RELEASE_REPO=tp-net-host-release
set TARGET_REPO=%BASE_URL%/%RELEASE_REPO%

REM ===== Clone source repos =====
git clone --branch %BRANCH% --single-branch %BASE_URL%/tp-net-host-cloudflared-service
git clone --branch %BRANCH% --single-branch %BASE_URL%/tp-net-host-mosquitto-environment
git clone --branch %BRANCH% --single-branch %BASE_URL%/tp-net-host-redis-environment
git clone --branch %BRANCH% --single-branch %BASE_URL%/tp-net-watcher

REM ===== Clone release repo =====
git clone --branch %BRANCH% --single-branch %TARGET_REPO%

echo.
echo ================================
echo Cleaning %RELEASE_REPO%
echo ================================
echo.

cd %RELEASE_REPO%

REM Xoá toàn bộ file và folder trừ .git
for /f "delims=" %%i in ('dir /b /a') do (
    if /I not "%%i"==".git" (
        rmdir /s /q "%%i" 2>nul
        del /f /q "%%i" 2>nul
    )
)

cd ..

echo.
echo ================================
echo Removing nested .git folders
echo ================================
echo.

rmdir /s /q tp-net-host-cloudflared-service\.git 2>nul
rmdir /s /q tp-net-host-mosquitto-environment\.git 2>nul
rmdir /s /q tp-net-host-redis-environment\.git 2>nul
rmdir /s /q tp-net-watcher\.git 2>nul

echo.
echo ================================
echo Moving projects into release
echo ================================
echo.

move tp-net-host-cloudflared-service %RELEASE_REPO%\
move tp-net-host-mosquitto-environment %RELEASE_REPO%\
move tp-net-host-redis-environment %RELEASE_REPO%\
move tp-net-watcher %RELEASE_REPO%\

cd %RELEASE_REPO%

echo.
echo ================================
echo WARNING !!!
echo ================================
echo.
echo You are about to PUSH to:
echo %TARGET_REPO%
echo Branch: %BRANCH%
echo.
echo This will overwrite remote content with current local state.
echo.

set /p CONFIRM=Type YES to continue: 

if /I not "%CONFIRM%"=="YES" (
    echo.
    echo Push cancelled.
    pause
    exit /b
)

echo.
echo ================================
echo Git Commit ^& Push
echo ================================
echo.

git add .
git commit -m "tp-net-host-release-0.0.1"
git push origin %BRANCH%:%BRANCH%

echo.
echo ================================
echo DONE
echo ================================
pause