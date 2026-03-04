@echo off
set BRANCH=staging
set FOLDER=tp-net-node-launch
set REPO=https://github.com/tungttsmd/tp-net-node-launch

:: Check git: using portable first, fallback into system git
if exist "%~dp0pipeline-environment\git\cmd\git.exe" (
    set GIT=%~dp0pipeline-environment\git\cmd\git.exe
) else (
    set GIT=git
)

echo Updating node...

if not exist %FOLDER% (
    %GIT% clone --branch %BRANCH% --single-branch %REPO%
    if errorlevel 1 (
        echo Clone failed.
        pause
        exit /b
    )
) else (
    cd %FOLDER%
    %GIT% fetch origin
    %GIT% reset --hard origin/%BRANCH%
    cd ..
)

cd %FOLDER%

echo Launching...
launch.exe