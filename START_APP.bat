@echo off
echo ========================================
echo Starting Documentation Analyzer
echo ========================================
echo.

cd moengage_project\codebase

echo Checking Python...
python --version
if errorlevel 1 (
    echo ERROR: Python not found!
    pause
    exit /b 1
)

echo.
echo Starting Flask application...
echo.
echo ========================================
echo Application will be available at:
echo http://localhost:5000
echo ========================================
echo.
echo Press Ctrl+C to stop the server
echo.

python app.py

pause

