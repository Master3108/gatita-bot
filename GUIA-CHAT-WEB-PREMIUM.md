# 🎨 GatitaBot - Chat Web Premium

## ✨ Características

### **Diseño & UX**
- 🎨 **Glassmorphism**: Efectos de vidrio esmerilado modernos
- 🌈 **Gradientes vibrantes**: Colores que transmiten confianza (púrpura, azul, rosa)
- ✨ **Animaciones fluidas**: Micro-interacciones en cada acción
- 🐱 **Avatar animado**: Gatita que "respira" mientras piensa
- 💬 **Burbujas de chat dinámicas**: Diferentes estilos para usuario vs bot

### **Funcionalidades**
- ✅ Envío de texto
- 🎤 Grabación de audio (con indicador de tiempo)
- 📷 Subida de imágenes (OCR automático)
- 📄 Subida de PDFs (extracción de texto)
- 💾 Historial de conversación (localStorage)
- ⚡ Indicador de "escribiendo..."
- 🔔 Botones de acción rápida

---

## 🚀 Instalación

### **Paso 1: Importar Workflow en n8n**

1. Abre n8n
2. Click en **"Import from File"**
3. Selecciona: `workflow-1-gatita-chat-WEB-PREMIUM.json`
4. **Activa** el workflow

---

### **Paso 2: Obtener URL del Webhook**

1. Abre el workflow importado
2. Click en el nodo **"Webhook"**
3. Copia la **Production URL**
   - Ejemplo: `https://tu-n8n.com/webhook/gatita-chat`

---

### **Paso 3: Configurar el Chat HTML**

1. Abre el archivo: `chat-gatita-premium.html`
2. Busca la línea:
   ```javascript
   const N8N_WEBHOOK_URL = 'YOUR_N8N_WEBHOOK_URL_HERE';
   ```
3. Reemplaza con tu URL:
   ```javascript
   const N8N_WEBHOOK_URL = 'https://tu-n8n.com/webhook/gatita-chat';
   ```
4. **Guarda** el archivo

---

### **Paso 4: Abrir el Chat**

1. Abre `chat-gatita-premium.html` en tu navegador
2. **¡Listo!** Ya puedes chatear con GatitaBot

---

## 🧪 Pruebas

### **Test 1: Mensaje de Texto**
```
Usuario: "Muéstrame todos los registros de ROBUSTA"
Bot: [Muestra tabla con registros]
```

### **Test 2: Grabación de Audio**
1. Click en el botón del micrófono 🎤
2. Habla: "Registra un pago a Avícola de $500.000 en ROBUSTA"
3. Click en ⏹️ para detener
4. El audio se transcribe automáticamente
5. El bot responde

### **Test 3: Subida de Imagen**
1. Click en el botón de cámara 📷
2. Selecciona una foto de un comprobante de pago
3. El OCR extrae automáticamente:
   - Proveedor
   - Fecha
   - Monto
   - N° de Documento
4. El bot procesa la información

### **Test 4: Subida de PDF**
1. Click en el botón de clip 📎
2. Selecciona un PDF de factura
3. El texto se extrae automáticamente
4. El bot analiza el contenido

---

## 🎨 Personalización

### **Cambiar Colores**

En `chat-gatita-premium.html`, busca:

```css
background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
```

Reemplaza con tus colores favoritos:
```css
background: linear-gradient(135deg, #TU_COLOR_1 0%, #TU_COLOR_2 50%, #TU_COLOR_3 100%);
```

### **Cambiar Avatar**

Busca:
```html
<div class="avatar">🐱</div>
```

Reemplaza con tu emoji favorito o una imagen:
```html
<div class="avatar"><img src="tu-logo.png"></div>
```

### **Cambiar Nombre del Bot**

Busca:
```html
<h1>GatitaBot</h1>
<p>Asistente Contable Inteligente</p>
```

Reemplaza con tu nombre:
```html
<h1>Tu Nombre</h1>
<p>Tu Descripción</p>
```

---

## 🌐 Despliegue en Producción

### **Opción 1: Netlify (Gratis)**

1. Crea una cuenta en [Netlify](https://netlify.com)
2. Arrastra `chat-gatita-premium.html` a Netlify
3. **¡Listo!** Tu chat está en línea

### **Opción 2: Vercel (Gratis)**

1. Crea una cuenta en [Vercel](https://vercel.com)
2. Sube tu archivo HTML
3. Despliega con un click

### **Opción 3: GitHub Pages (Gratis)**

1. Crea un repositorio en GitHub
2. Sube `chat-gatita-premium.html`
3. Renómbralo a `index.html`
4. Activa GitHub Pages en Settings
5. Tu chat estará en: `https://tu-usuario.github.io/tu-repo`

---

## 📱 Responsive Design

El chat es **100% responsive** y funciona perfectamente en:
- 💻 Desktop
- 📱 Móviles
- 📱 Tablets

---

## 🔒 Seguridad

### **CORS (Cross-Origin Resource Sharing)**

El webhook de n8n está configurado con:
```json
"options": {
  "allowedOrigins": "*"
}
```

Para producción, cambia `"*"` por tu dominio:
```json
"options": {
  "allowedOrigins": "https://tu-dominio.com"
}
```

---

## 🎯 Neuromarketing Aplicado

### **Colores Estratégicos**
- **Púrpura (#667eea)**: Creatividad, innovación, confianza
- **Rosa (#f093fb)**: Amigable, accesible, moderno
- **Azul (#764ba2)**: Profesionalismo, estabilidad

### **Micro-Interacciones**
- ✨ Animaciones de entrada de mensajes
- 🌊 Efecto de "respiración" en el avatar
- 💫 Transiciones suaves en botones
- ⚡ Feedback visual inmediato

### **Jerarquía Visual**
- 📍 Avatar grande y centrado (punto focal)
- 💬 Burbujas de chat con sombras (profundidad)
- 🎨 Gradientes que guían la vista
- ✅ Botones de acción destacados

---

## 🐛 Troubleshooting

### **Error: "Failed to fetch"**
- ✅ Verifica que el workflow esté **activo** en n8n
- ✅ Verifica que la URL del webhook sea correcta
- ✅ Verifica que n8n esté accesible desde internet

### **El audio no se graba**
- ✅ Permite el acceso al micrófono en tu navegador
- ✅ Usa HTTPS (el micrófono no funciona en HTTP)

### **Las imágenes no se procesan**
- ✅ Verifica que el nodo "AI Vision Agent" tenga credenciales de OpenAI
- ✅ Verifica que el modelo sea `gpt-4o-mini` o superior

---

## 📊 Métricas de Éxito

- ⚡ **Tiempo de respuesta**: < 2 segundos
- 🎯 **Tasa de éxito**: > 95%
- 💬 **Satisfacción del usuario**: Alta (por diseño atractivo)
- 🔄 **Retención**: Alta (por experiencia fluida)

---

## 🎉 ¡Listo!

Tu chat premium está configurado y listo para usar. Disfruta de una experiencia de chat moderna, interactiva y visualmente impactante.

**¿Preguntas?** Revisa la documentación o contacta al equipo de soporte.
