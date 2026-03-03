@echo off
chcp 65001 >nul
title Build Tp-net-node-release

echo ================================
echo Cloning TP Net staging projects
echo ================================
echo.

set BRANCH=staging
set BASE_URL=https://github.com/tungttsmd
set RELEASE_REPO=tp-net-node-release
set TARGET_REPO=%BASE_URL%/%RELEASE_REPO%

REM ===== Clone source repos =====
git clone --branch %BRANCH% --single-branch %BASE_URL%/tp-net-node-cloudflared-service
git clone --branch %BRANCH% --single-branch %BASE_URL%/tp-net-librehwmonitor
git clone --branch %BRANCH% --single-branch %BASE_URL%/tp-net-trigger

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

rmdir /s /q tp-net-node-cloudflared-service\.git 2>nul
rmdir /s /q tp-net-librehwmonitor\.git 2>nul
rmdir /s /q tp-net-trigger\.git 2>nul

echo.
echo ================================
echo Moving projects into release
echo ================================
echo.

move tp-net-node-cloudflared-service %RELEASE_REPO%\
move tp-net-librehwmonitor %RELEASE_REPO%\
move tp-net-trigger %RELEASE_REPO%\

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
git commit -m "tp-net-node-release-0.0.1"
git push origin %BRANCH%:%BRANCH%

echo.
echo ================================
echo DONE
echo ================================
pause