#!/usr/bin/env python3
"""
Servidor Local para GatitaBot Chat
Ejecuta este script para servir el chat en tu red local
"""

import http.server
import socketserver
import socket
import webbrowser
import os
from pathlib import Path

# Configuración
PORT = 8080
DIRECTORY = Path(__file__).parent

class MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=str(DIRECTORY), **kwargs)
    
    def end_headers(self):
        # Agregar headers CORS
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        super().end_headers()

def get_local_ip():
    """Obtiene la IP local de la máquina"""
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        local_ip = s.getsockname()[0]
        s.close()
        return local_ip
    except Exception:
        return "127.0.0.1"

def main():
    local_ip = get_local_ip()
    
    print("=" * 60)
    print("🐱 GatitaBot Chat - Servidor Local")
    print("=" * 60)
    print()
    print(f"📡 Servidor iniciado en el puerto {PORT}")
    print()
    print("🌐 URLs de Acceso:")
    print(f"   Local:    http://localhost:{PORT}/chat-gatita-premium.html")
    print(f"   Red:      http://{local_ip}:{PORT}/chat-gatita-premium.html")
    print()
    print("📱 Desde tu móvil/tablet:")
    print(f"   Abre:     http://{local_ip}:{PORT}/chat-gatita-premium.html")
    print()
    print("⚠️  Asegúrate de que tu firewall permita conexiones en el puerto", PORT)
    print()
    print("🛑 Para detener el servidor: Presiona Ctrl+C")
    print("=" * 60)
    print()
    
    # Abrir navegador automáticamente
    url = f"http://localhost:{PORT}/chat-gatita-premium.html"
    print(f"🚀 Abriendo navegador en: {url}")
    webbrowser.open(url)
    
    # Iniciar servidor
    with socketserver.TCPServer(("", PORT), MyHTTPRequestHandler) as httpd:
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\n\n🛑 Servidor detenido")
            print("¡Hasta luego! 👋")

if __name__ == "__main__":
    main()
