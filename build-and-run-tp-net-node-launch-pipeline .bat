@echo off

set BASE_URL=https://github.com/tungttsmd
set BRANCH=staging
set FOLDER=tp-net-node-launch
set REPO=%BASE_URL%/tp-net-node-launch

:: Check git: using portable first, fallback into system git
if exist "%~dp0pipeline-environment\git\cmd\git.exe" (
    set GIT=%~dp0pipeline-environment\git\cmd\git.exe
) else (
    set GIT=git
)

:: Kiểm tra folder đã có chưa
if exist "%~dp0%FOLDER%" (
    echo Folder already exists, skipping clone...
) else (
    echo Cloning repo...
    %GIT% clone --branch %BRANCH% --single-branch --depth 1 %REPO% "%~dp0%FOLDER%"
)

:: Đợi 5 giây
timeout /t 5

:: CD tới thư mục rồi chạy
cd /d "%~dp0%FOLDER%"
start "" "%~dp0%FOLDER%\launch.exe"

:: Xóa file bat này
del /f "%~f0"