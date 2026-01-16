# 🌐 Servidor Local - GatitaBot Chat

## 🚀 Inicio Rápido

### **Opción 1: Doble Click (Más Fácil)**
1. Haz **doble click** en: `INICIAR-CHAT.bat`
2. El navegador se abrirá automáticamente
3. ¡Listo! El chat está funcionando

### **Opción 2: Python**
```bash
python servidor-local.py
```

### **Opción 3: PowerShell**
```powershell
.\servidor-local.ps1
```

---

## 📱 Acceder desde Otros Dispositivos

### **Desde tu Móvil/Tablet:**

1. **Inicia el servidor** en tu PC (opción 1, 2 o 3)
2. **Anota la URL de red** que aparece en la consola
   - Ejemplo: `http://192.168.1.100:8080/chat-gatita-premium.html`
3. **Abre esa URL** en el navegador de tu móvil/tablet
4. ¡Listo! Puedes chatear desde cualquier dispositivo

### **Requisitos:**
- ✅ Tu móvil/tablet debe estar en la **misma red WiFi** que tu PC
- ✅ El **firewall** de Windows debe permitir conexiones en el puerto 8080

---

## 🔥 Configurar Firewall (Si es Necesario)

Si no puedes acceder desde otros dispositivos:

### **Windows Firewall:**
1. Abre **Panel de Control** → **Firewall de Windows**
2. Click en **"Configuración avanzada"**
3. Click en **"Reglas de entrada"** → **"Nueva regla"**
4. Selecciona **"Puerto"** → **Siguiente**
5. Selecciona **"TCP"** y escribe **8080** → **Siguiente**
6. Selecciona **"Permitir la conexión"** → **Siguiente**
7. Marca todas las opciones → **Siguiente**
8. Nombre: **"GatitaBot Chat"** → **Finalizar**

---

## 🌐 URLs Disponibles

Cuando inicies el servidor, verás algo como:

```
============================================================
🐱 GatitaBot Chat - Servidor Local
============================================================

📡 Servidor iniciado en el puerto 8080

🌐 URLs de Acceso:
   Local:    http://localhost:8080/chat-gatita-premium.html
   Red:      http://192.168.1.100:8080/chat-gatita-premium.html

📱 Desde tu móvil/tablet:
   Abre:     http://192.168.1.100:8080/chat-gatita-premium.html

⚠️  Asegúrate de que tu firewall permita conexiones en el puerto 8080

🛑 Para detener el servidor: Presiona Ctrl+C
============================================================
```

---

## 🔧 Solución de Problemas

### **Error: "Python no está instalado"**
1. Descarga Python desde: https://python.org
2. Durante la instalación, marca **"Add Python to PATH"**
3. Reinicia la terminal
4. Intenta de nuevo

### **Error: "No puedo acceder desde mi móvil"**
1. ✅ Verifica que estés en la **misma red WiFi**
2. ✅ Verifica que el **firewall** permita conexiones (ver arriba)
3. ✅ Usa la **URL de red** (no localhost)
4. ✅ Verifica que el servidor esté **corriendo** en tu PC

### **Error: "Puerto 8080 ya está en uso"**
1. Cierra otras aplicaciones que usen el puerto 8080
2. O edita los scripts y cambia `8080` por otro puerto (ej: `8081`)

---

## 📊 Comparación de Opciones

| Método | Ventaja | Desventaja |
|--------|---------|------------|
| **INICIAR-CHAT.bat** | ✅ Más fácil (doble click) | ⚠️ Requiere Python |
| **servidor-local.py** | ✅ Multiplataforma | ⚠️ Requiere Python |
| **servidor-local.ps1** | ✅ Múltiples opciones | ⚠️ Más complejo |
| **Abrir HTML directo** | ✅ No requiere servidor | ❌ No funciona en red local |

---

## 🎯 Casos de Uso

### **Uso Personal (Solo tú)**
- Abre directamente: `chat-gatita-premium.html`
- No necesitas servidor

### **Uso en Equipo (Misma oficina)**
- Usa: `INICIAR-CHAT.bat`
- Comparte la URL de red con tu equipo

### **Uso Público (Internet)**
- Despliega en Netlify/Vercel
- Ver: `INICIO-RAPIDO-CHAT.md`

---

## 🚀 Próximos Pasos

1. ✅ **Inicia el servidor**: Doble click en `INICIAR-CHAT.bat`
2. ✅ **Prueba localmente**: Abre `http://localhost:8080/chat-gatita-premium.html`
3. ✅ **Prueba en móvil**: Usa la URL de red
4. ✅ **Comparte**: Envía la URL a tu equipo

---

## 📞 Soporte

Si tienes problemas:
1. Revisa la sección **"Solución de Problemas"**
2. Verifica que el workflow de n8n esté **activo**
3. Abre la **consola del navegador** (F12) para ver errores

---

**¡Disfruta de tu chat local!** 🎉
