@echo off
REM BlissAndGlow Setup Script for Windows

setlocal enabledelayedexpansion

echo.
echo ==========================================
echo BlissAndGlow - Setup Script (Windows)
echo ==========================================

REM Check Java
echo.
echo [1/4] Checking prerequisites...

java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Java not found. Please install Java 17+
    pause
    exit /b 1
)

for /f "tokens=*" %%i in ('java -version 2^>^&1') do (
    echo ✓ %%i
)

REM Build project
echo.
echo [2/4] Building project with Maven...

if exist "mvnw.cmd" (
    call mvnw.cmd clean install
) else (
    call mvn clean install
)

if %errorlevel% neq 0 (
    echo ❌ Build failed
    pause
    exit /b 1
)
echo ✓ Project built successfully

REM Database setup
echo.
echo [3/4] Setting up database...
echo.
echo If using XAMPP, typically: username=root, password=(leave blank)
echo.

set /p DB_USER="Enter MySQL Username (default: root): " || set DB_USER=root
set /p DB_PASS="Enter MySQL Password (press Enter if none): "

if defined DB_PASS (
    mysql -u %DB_USER% -p%DB_PASS% < database\schema.sql
    mysql -u %DB_USER% -p%DB_PASS% < database\seed.sql
) else (
    mysql -u %DB_USER% < database\schema.sql
    mysql -u %DB_USER% < database\seed.sql
)

if %errorlevel% equ 0 (
    echo ✓ Database setup complete
) else (
    echo ⚠ Database setup failed. Please manually execute:
    echo   mysql -u root -p ^< database\schema.sql
    echo   mysql -u root -p ^< database\seed.sql
)

REM Final info
echo.
echo [4/4] Setup Complete!
echo ==========================================
echo Application ready to deploy!
echo.
echo Next steps:
echo 1. Deploy WAR: target\blissandglow.war to Tomcat
echo 2. Start Tomcat
echo 3. Visit: http://localhost:8080/blissandglow/
echo.
echo Or use Docker:
echo   docker-compose up -d
echo ==========================================
echo.
pause
