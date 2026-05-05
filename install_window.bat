# install_windows.bat

```bat id="7r5h1r"
@echo off
title Ledger Automation Installer

set INSTALL_DIR=%USERPROFILE%\.ledger-automation
set PYTHON_DIR=%INSTALL_DIR%\Python

if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

echo Downloading bootstrap.py...
curl -L "https://raw.githubusercontent.com/Abdurrahimgithub/AutoFIlings/main/bootstrap.py" -o "%INSTALL_DIR%\bootstrap.py"

echo Checking Python...
where python >nul 2>nul

if %ERRORLEVEL% neq 0 (
    echo Python not found. Downloading Python...
    curl -L "https://www.python.org/ftp/python/3.12.3/python-3.12.3-amd64.exe" -o "%INSTALL_DIR%\python-installer.exe"

    echo Installing Python...
    "%INSTALL_DIR%\python-installer.exe" /quiet InstallAllUsers=0 PrependPath=1 Include_pip=1 TargetDir="%PYTHON_DIR%"
)

echo Adding Python to user PATH...
setx PATH "%PATH%;%PYTHON_DIR%;%PYTHON_DIR%\Scripts"

echo Refreshing current session PATH...
set PATH=%PATH%;%PYTHON_DIR%;%PYTHON_DIR%\Scripts

echo Verifying pip...
"%PYTHON_DIR%\python.exe" -m ensurepip --upgrade

echo Running Bootstrap Installer...
"%PYTHON_DIR%\python.exe" "%INSTALL_DIR%\bootstrap.py"

pause
```

