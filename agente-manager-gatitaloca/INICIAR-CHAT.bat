@echo off
chcp 65001 >nul
color 0A

echo ============================================================
echo 🐱 GatitaBot Chat - Servidor Local
echo ============================================================
echo.

REM Verificar si Python está instalado
python --version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Python detectado
    echo 📡 Iniciando servidor en puerto 8080...
    echo.
    echo 🌐 URLs de Acceso:
    echo    Local:    http://localhost:8080/chat-gatita-premium.html
    echo.
    echo 📱 Desde tu móvil/tablet:
    for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4"') do (
        set IP=%%a
        goto :found
    )
    :found
    echo    Red:      http://%IP:~1%:8080/chat-gatita-premium.html
    echo.
    echo 🛑 Para detener: Presiona Ctrl+C
    echo ============================================================
    echo.
    
    REM Abrir navegador
    start http://localhost:8080/chat-gatita-premium.html
    
    REM Iniciar servidor
    python -m http.server 8080
) else (
    echo ❌ Python no está instalado
    echo.
    echo 📥 Por favor instala Python desde: https://python.org
    echo    O usa el archivo: servidor-local.ps1
    echo.
    pause
)
