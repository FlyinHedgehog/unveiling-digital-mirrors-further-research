@echo off
:: setup.bat

:: Install uv if not found
where uv >nul 2>nul
if %errorlevel% neq 0 (
    echo uv not found. Installing uv...
    powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
    set "PATH=%USERPROFILE%\.cargo\bin;%USERPROFILE%\.local\bin;%PATH%"
)

echo Syncing environment with uv...
uv sync || (pause & exit /b 1)

echo Generating pose clusters and normalized data...
uv run python scripts\cluster_poses.py || (pause & exit /b 1)

echo Environment is ready!
echo Starting the local server...
uv run python scripts\server.py
pause
