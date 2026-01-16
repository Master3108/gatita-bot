# 🔧 Solución: Chat No Reconoce Imágenes

## ⚠️ Problema

El workflow de n8n NO está recibiendo correctamente las imágenes que se pegan o suben en el chat.

Error en el nodo "Detect File Type": `{{ $json.body.file }}`

---

## 🔍 Causa

El chat envía las imágenes como **FormData** (binary), pero el workflow está buscando el archivo en `$json.body.file` (que no existe).

---

## ✅ Solución

Necesitas **editar manualmente** el nodo "Detect File Type" en n8n.

### **Pasos:**

1. **Abre n8n**: https://n8n-n8n.cwf1hb.easypanel.host
2. **Abre el workflow**: "GATITA CHAT WEB (Multimodal Premium)"
3. **Click en el nodo**: "Detect File Type"
4. **Reemplaza todo el código** con este:

```javascript
// Detectar tipo de archivo del FormData
const files = $input.item.binary;
const body = $input.item.json.body;

// Si viene como binary (archivo subido)
if (files && files.file) {
  const file = files.file;
  const fileName = file.fileName.toLowerCase();
  
  let fileType = 'unknown';
  
  if (fileName.match(/\.(jpg|jpeg|png|gif|webp)$/)) {
    fileType = 'image';
  } else if (fileName.match(/\.(mp3|wav|webm|ogg|m4a)$/)) {
    fileType = 'audio';
  } else if (fileName.match(/\.(pdf)$/)) {
    fileType = 'pdf';
  } else if (fileName.match(/\.(doc|docx)$/)) {
    fileType = 'document';
  }
  
  return {
    json: {
      fileType,
      fileName: file.fileName,
      message: body.message || '',
      sessionId: body.sessionId || '',
      company: body.company || ''
    },
    binary: {
      file: file
    }
  };
}

// Si no hay archivo, retornar error
throw new Error('No se encontró ningún archivo en la petición');
```

5. **Guarda** el nodo
6. **Activa** el workflow

---

## 🎯 Qué Hace Este Código

1. ✅ Lee el archivo del **binary** (donde n8n guarda los archivos subidos)
2. ✅ Detecta el tipo de archivo por extensión
3. ✅ Extrae también `message`, `sessionId` y `company` del body
4. ✅ Devuelve el archivo en el binary para que los siguientes nodos lo procesen

---

## 🧪 Probar

Después de hacer el cambio:

1. Refresca el chat
2. Selecciona una empresa
3. **Pega una imagen** (Ctrl+V) o **arrastra** una imagen
4. El bot debería procesarla correctamente

---

## 📋 Nodos Adicionales que Necesitan Actualización

También necesitas actualizar estos nodos para que lean del **binary**:

### **1. Nodo "Transcribe Audio"**
- Debe leer: `$binary.file`

### **2. Nodo "AI Vision Agent"**
- Debe leer: `$binary.file`

### **3. Nodo "Extract PDF"**
- Debe leer: `$binary.file`

---

## 🚀 Alternativa: Importar Workflow Corregido

Si prefieres, puedo crear un workflow completamente corregido que puedas importar directamente.

---

**Edita el nodo "Detect File Type" en n8n con el código de arriba y prueba de nuevo!** 🔧
