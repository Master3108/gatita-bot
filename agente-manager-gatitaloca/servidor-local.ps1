# Servidor Local para GatitaBot Chat
# Ejecuta este script en PowerShell para servir el chat

$PORT = 8080
$DIRECTORY = $PSScriptRoot

Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host "🐱 GatitaBot Chat - Servidor Local" -ForegroundColor Green
Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host ""

# Obtener IP local
$LocalIP = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.InterfaceAlias -notlike "*Loopback*" -and $_.IPAddress -notlike "169.254.*"} | Select-Object -First 1).IPAddress

Write-Host "📡 Servidor iniciado en el puerto $PORT" -ForegroundColor Yellow
Write-Host ""
Write-Host "🌐 URLs de Acceso:" -ForegroundColor Cyan
Write-Host "   Local:    http://localhost:$PORT/chat-gatita-premium.html" -ForegroundColor White
Write-Host "   Red:      http://${LocalIP}:$PORT/chat-gatita-premium.html" -ForegroundColor White
Write-Host ""
Write-Host "📱 Desde tu móvil/tablet:" -ForegroundColor Cyan
Write-Host "   Abre:     http://${LocalIP}:$PORT/chat-gatita-premium.html" -ForegroundColor White
Write-Host ""
Write-Host "⚠️  Asegúrate de que tu firewall permita conexiones en el puerto $PORT" -ForegroundColor Yellow
Write-Host ""
Write-Host "🛑 Para detener el servidor: Presiona Ctrl+C" -ForegroundColor Red
Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host ""

# Abrir navegador
$URL = "http://localhost:$PORT/chat-gatita-premium.html"
Write-Host "🚀 Abriendo navegador en: $URL" -ForegroundColor Green
Start-Process $URL

# Iniciar servidor HTTP simple
Write-Host "⏳ Iniciando servidor..." -ForegroundColor Yellow
Write-Host ""

try {
    # Usar Python si está disponible
    if (Get-Command python -ErrorAction SilentlyContinue) {
        Set-Location $DIRECTORY
        python -m http.server $PORT
    }
    # Alternativa: usar Node.js si está disponible
    elseif (Get-Command node -ErrorAction SilentlyContinue) {
        Set-Location $DIRECTORY
        npx -y http-server -p $PORT --cors
    }
    # Si no hay Python ni Node, usar .NET
    else {
        Write-Host "⚠️  Python o Node.js no encontrados" -ForegroundColor Yellow
        Write-Host "📥 Instalando servidor temporal..." -ForegroundColor Cyan
        
        # Crear servidor HTTP simple con .NET
        $listener = New-Object System.Net.HttpListener
        $listener.Prefixes.Add("http://+:$PORT/")
        $listener.Start()
        
        Write-Host "✅ Servidor iniciado correctamente" -ForegroundColor Green
        
        while ($listener.IsListening) {
            $context = $listener.GetContext()
            $request = $context.Request
            $response = $context.Response
            
            $path = $request.Url.LocalPath
            if ($path -eq "/") {
                $path = "/chat-gatita-premium.html"
            }
            
            $filePath = Join-Path $DIRECTORY $path.TrimStart('/')
            
            if (Test-Path $filePath) {
                $content = [System.IO.File]::ReadAllBytes($filePath)
                $response.ContentType = switch ([System.IO.Path]::GetExtension($filePath)) {
                    ".html" { "text/html" }
                    ".css" { "text/css" }
                    ".js" { "application/javascript" }
                    ".json" { "application/json" }
                    default { "application/octet-stream" }
                }
                $response.ContentLength64 = $content.Length
                $response.OutputStream.Write($content, 0, $content.Length)
            } else {
                $response.StatusCode = 404
            }
            
            $response.Close()
        }
    }
}
catch {
    Write-Host ""
    Write-Host "🛑 Servidor detenido" -ForegroundColor Red
    Write-Host "¡Hasta luego! 👋" -ForegroundColor Cyan
}
finally {
    if ($listener) {
        $listener.Stop()
    }
}
