@echo off
set BRANCH=staging
set FOLDER=tp-net-node-launch
set REPO=https://github.com/tungttsmd/tp-net-node-launch

echo Updating node...

if not exist %FOLDER% (
    git clone --branch %BRANCH% --single-branch %REPO%
    if errorlevel 1 (
        echo Clone failed.
        pause
        exit /b
    )
) else (
    cd %FOLDER%
    git fetch origin
    git reset --hard origin/%BRANCH%
    cd ..
)

cd %FOLDER%

echo Launching...
launch.exe