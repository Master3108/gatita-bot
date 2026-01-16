# 🐱 GatitaBot - Chat Premium Multimodal

Sistema de chat inteligente con OCR para el holding "Tu Gatita Loca"

## 📋 Descripción

GatitaBot es un asistente contable con IA que permite:
- 💬 Conversaciones en lenguaje natural
- 🖼️ Procesamiento de imágenes (OCR) de comprobantes
- 📊 Registro automático en Google Sheets
- 🏢 Gestión multi-empresa (CASAZ, ROBUSTA, ARPINO, CB)
- 🧠 Memoria de conversaciones por sesión

## 🎨 Características

### Frontend
- ✨ Diseño premium con glassmorphism
- 🎯 Selector de empresa intuitivo
- 🖼️ Soporte para pegar/arrastrar imágenes (Ctrl+V)
- 💬 Chat fluido estilo Gemini/ChatGPT
- 📱 Interfaz responsive

### Backend (n8n)
- 🤖 AI Agent con OpenAI GPT-4
- 👁️ OCR con Vision API
- 📄 Extracción de datos: RUT, Razón Social, Folios, Montos
- 🧠 Memoria persistente por sesión
- 📊 Integración con Google Sheets
- ⚙️ Herramientas: search, register

## 🚀 Instalación

### 1. Frontend

1. Abre `chat-gatita-gemini-style.html` en tu navegador
2. O inicia el servidor local:
   ```bash
   python servidor-local.py
   ```
   Luego abre: http://localhost:8080

### 2. Backend (n8n)

1. Abre tu instancia de n8n: https://n8n-n8n.cwf1hb.easypanel.host
2. Importa el workflow: `workflow-1-gatita-chat-WEB-PREMIUM.json`
3. Configura las credenciales de OpenAI
4. Activa el workflow

## 📁 Estructura de Archivos

```
agente-manager-gatitaloca/
├── README.md                              # Este archivo
├── chat-gatita-gemini-style.html         # Frontend del chat
├── workflow-1-gatita-chat-WEB-PREMIUM.json  # Workflow de n8n
├── servidor-local.py                      # Servidor HTTP local (Python)
├── servidor-local.ps1                     # Servidor HTTP local (PowerShell)
├── INICIAR-CHAT.bat                       # Script para iniciar el chat
├── SOLUCION-EMPRESA-SELECCIONADA.md      # Guía de solución
└── SOLUCION-IMAGENES-NO-RECONOCIDAS.md   # Guía de solución
```

## 🎯 Uso

### Flujo Básico

1. **Selecciona la empresa** en el header (CASAZ, ROBUSTA, ARPINO o CB)
2. **Pega una imagen** de un comprobante (Ctrl+V) o escribe un mensaje
3. **El bot extrae los datos** automáticamente
4. **Confirma el registro** cuando el bot te pregunte
5. **Verifica en Google Sheets** que el registro se creó correctamente

### Ejemplos de Comandos

**Registro con imagen:**
```
[Pega imagen del comprobante]
"Registra este pago"
```

**Registro manual:**
```
"Registra pago a ACME Corp por $50.000"
```

**Búsqueda:**
```
"Muestra todos los pagos de enero"
"Busca pagos a ACME Corp"
```

**Consulta de empresa:**
```
"¿En qué empresa estamos?"
```

## ⚙️ Configuración

### Variables del Frontend

Edita `chat-gatita-gemini-style.html`:

```javascript
const WEBHOOK_URL = 'https://n8n-n8n.cwf1hb.easypanel.host/webhook/gatita-chat';
```

### Variables del Workflow (n8n)

1. **OpenAI API Key**: Configura en las credenciales de n8n
2. **Google Sheets**: Configura en el workflow "HERRAMIENTAS GATITA"

## 🔧 Troubleshooting

### El bot no reconoce la empresa seleccionada

- **Solución**: Lee `SOLUCION-EMPRESA-SELECCIONADA.md`
- Verifica que el nodo "Unify Input" use: `{{ $('Webhook').item.json.body.company }}`

### Las imágenes no se procesan

- **Solución**: Lee `SOLUCION-IMAGENES-NO-RECONOCIDAS.md`
- Verifica que el nodo "Detect File Type" lea de `$binary.file`
- Verifica que el nodo "Has File?" evalúe `{{ $binary.file }}`

### El bot pregunta por la empresa aunque ya está seleccionada

- **Solución**: Limpia la sesión del chat (F12 → Console → `localStorage.clear()`)
- Verifica que el System Message del AI Agent incluya las reglas de prioridad de `{{ $json.company }}`

## 📊 Estructura de Datos (Google Sheets)

Cada empresa tiene una hoja con las siguientes columnas:

| Columna | Descripción | Requerido |
|---------|-------------|-----------|
| FOLIO | Número de folio | No |
| RUT | RUT del proveedor (formato: 12345678-9) | No |
| RAZON SOCIAL | Nombre del proveedor/cliente | Sí |
| SALDO PENDIENTE | Monto del saldo | Sí |
| COMENTARIO | Notas adicionales | No |
| GLOSA | Categoría o glosa | No |

## 🛠️ Tecnologías Utilizadas

- **Frontend**: HTML5, CSS3 (Glassmorphism), Vanilla JS
- **Backend**: n8n (workflow automation)
- **AI**: OpenAI GPT-4, Vision API
- **Storage**: Google Sheets
- **Servidor Local**: Python HTTP Server

## 📝 Notas Importantes

- El parámetro `company` del frontend SIEMPRE tiene prioridad sobre la memoria del bot
- Los campos FOLIO, RUT, COMENTARIO y GLOSA son opcionales (enviar vacíos si no se proporcionan)
- El bot SIEMPRE pide confirmación antes de registrar
- La sesión se mantiene por navegador (localStorage)

## 🎯 Próximas Mejoras

- [ ] Soporte para audio (transcripción)
- [ ] Soporte para PDF (extracción de datos)
- [ ] Gráficos y reportes
- [ ] Notificaciones por email/WhatsApp
- [ ] Multi-idioma

## 📞 Soporte

Si encuentras algún problema, consulta las guías de solución:
- `SOLUCION-EMPRESA-SELECCIONADA.md`
- `SOLUCION-IMAGENES-NO-RECONOCIDAS.md`

## 📄 Licencia

Proyecto privado - Tu Gatita Loca

---

**Última actualización**: 13 de enero de 2026
**Versión**: 1.0.0
**Estado**: ✅ Producción
