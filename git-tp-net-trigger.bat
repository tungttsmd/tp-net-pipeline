@echo off
chcp 65001 >nul
title Git Manager

set BASE_URL=https://github.com/tungttsmd
set REPO_NAME=tp-net-trigger

if exist "%~dp0pipeline-environment\git\cmd\git.exe" (
    set GIT=%~dp0pipeline-environment\git\cmd\git.exe
) else (
    set GIT=git
)

:MENU
cls
echo ================================================================================================
echo   Git Manager - %REPO_NAME%
echo ================================================================================================
echo.
echo  1. push dev      		- Git Push DEV
echo  2. push staging  		- Git Push STAGING
echo  3. reset         		- Git Fetch Reset
echo  4. clone dev     		- Git Clone DEV
echo  5. clone staging 		- Git Clone STAGING
echo  7. [7] windsurf  		- Open repo with Windsurf
echo  7. [8] view repo dev		- Open github repo dev
echo  7. [9] view repo staging		- Open github repo staging
echo  6. exit          		- Thoat
echo.
set /p CHOICE=Nhap lenh: 

if /I "%CHOICE%"=="push dev"      goto PUSH_DEV
if /I "%CHOICE%"=="push staging"  goto PUSH_STAGING
if /I "%CHOICE%"=="reset"         goto FETCH_RESET
if /I "%CHOICE%"=="clone dev"     goto CLONE_DEV
if /I "%CHOICE%"=="clone staging" goto CLONE_STAGING
if /I "%CHOICE%"=="7" 		  goto OPEN_WINDSURF
if /I "%CHOICE%"=="8" 		  goto OPEN_GITHUB_REPO_DEV
if /I "%CHOICE%"=="9" 		  goto OPEN_GITHUB_REPO_STAGING
if /I "%CHOICE%"=="exit"          goto EXIT

echo Lenh khong hop le, thu lai...
timeout /t 2 >nul
goto MENU

:: ================================
:PUSH_DEV
:: ================================
cls
echo Ban dang chuan bi PUSH len:
echo   Repo  : %BASE_URL%/%REPO_NAME%
echo   Branch: dev
echo.
set /p CONFIRM=Nhap YES de xac nhan: 
if /I not "%CONFIRM%"=="YES" (echo Huy bo. & timeout /t 2 >nul & goto MENU)
cd /d "%~dp0%REPO_NAME%"
%GIT% add .
%GIT% commit -m "%REPO_NAME%-dev-0.0.1"
%GIT% push origin HEAD:dev
echo. & echo Push DEV hoan tat!
pause & goto MENU

:: ================================
:PUSH_STAGING
:: ================================
cls
echo Ban dang chuan bi PUSH len:
echo   Repo  : %BASE_URL%/%REPO_NAME%
echo   Branch: staging
echo.
set /p CONFIRM=Nhap YES de xac nhan: 
if /I not "%CONFIRM%"=="YES" (echo Huy bo. & timeout /t 2 >nul & goto MENU)
cd /d "%~dp0%REPO_NAME%"
%GIT% add .
%GIT% commit -m "%REPO_NAME%-staging-0.0.1"
%GIT% push origin HEAD:staging
echo. & echo Push STAGING hoan tat!
pause & goto MENU

:: ================================
:FETCH_RESET
:: ================================
cls
echo Ban dang chuan bi RESET repo:
echo   Repo  : %BASE_URL%/%REPO_NAME%
echo.
echo ** CANH BAO: Moi thay doi chua commit se BI MAT **
echo.
set /p CONFIRM=Nhap YES de xac nhan: 
if /I not "%CONFIRM%"=="YES" (echo Huy bo. & timeout /t 2 >nul & goto MENU)
cd /d "%~dp0%REPO_NAME%"
if not exist ".git" (
    echo Khong tim thay .git, clone lai...
    cd /d "%~dp0"
    rmdir /s /q "%REPO_NAME%" 2>nul
    %GIT% clone --branch staging --single-branch %BASE_URL%/%REPO_NAME%
) else (
    %GIT% fetch origin
    %GIT% reset --hard origin/staging
    %GIT% clean -fd
)
echo. & echo Reset hoan tat!
pause & goto MENU

:: ================================
:CLONE_DEV
:: ================================
cls
echo Ban dang chuan bi CLONE:
echo   Repo  : %BASE_URL%/%REPO_NAME%
echo   Branch: dev
echo.
set /p CONFIRM=Nhap YES de xac nhan: 
if /I not "%CONFIRM%"=="YES" (echo Huy bo. & timeout /t 2 >nul & goto MENU)
cd /d "%~dp0"
rmdir /s /q "%REPO_NAME%" 2>nul
%GIT% clone --branch dev --single-branch %BASE_URL%/%REPO_NAME%
echo. & echo Clone DEV hoan tat!
pause & goto MENU

:: ================================
:CLONE_STAGING
:: ================================
cls
echo Ban dang chuan bi CLONE:
echo   Repo  : %BASE_URL%/%REPO_NAME%
echo   Branch: staging
echo.
set /p CONFIRM=Nhap YES de xac nhan: 
if /I not "%CONFIRM%"=="YES" (echo Huy bo. & timeout /t 2 >nul & goto MENU)
cd /d "%~dp0"
rmdir /s /q "%REPO_NAME%" 2>nul
%GIT% clone --branch staging --single-branch %BASE_URL%/%REPO_NAME%
echo. & echo Clone STAGING hoan tat!
pause & goto MENU

:: ================================
:OPEN_WINDSURF
:: ================================
cls
echo Dang mo Windsurf tai: %~dp0%REPO_NAME%
echo.
start "" /B windsurf "%~dp0%REPO_NAME%"
timeout 4 > null
goto MENU

:: ================================
:OPEN_GITHUB_REPO_DEV
:: ================================
cls
echo Dang mo github repo dev tai https://github.com/tungttsmd/%REPO_NAME%/tree/dev
echo.
start "" "https://github.com/tungttsmd/%REPO_NAME%/tree/dev"
goto MENU

:: ================================
:OPEN_GITHUB_REPO_STAGING
:: ================================
cls
echo Dang mo github repo staging tai https://github.com/tungttsmd/%REPO_NAME%/tree/staging
start "" "https://github.com/tungttsmd/%REPO_NAME%/tree/staging"
goto MENU

:: ================================
:EXIT
:: ================================
cls
echo Tam biet!
timeout /t 2 >nul
exit /b