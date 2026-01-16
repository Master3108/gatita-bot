# 🔧 Fix: Agregar Nodo de Debug

## Problema
El nodo "Create Row" no está devolviendo datos, causando el error "The workflow did not return a response".

## Solución

### Paso 1: Agregar Nodo "Set" de Debug

1. Abre el **Workflow 2** en n8n
2. Agrega un nodo **Set** entre `Create Row` y `Format Register Response`
3. Nómbralo: **"Debug Create Row"**
4. Configúralo así:

```json
{
  "assignments": {
    "assignments": [
      {
        "name": "debug_info",
        "type": "object",
        "value": "={{ $json }}"
      },
      {
        "name": "success",
        "type": "boolean",
        "value": true
      },
      {
        "name": "message",
        "type": "string",
        "value": "Fila creada en Google Sheets"
      }
    ]
  }
}
```

5. Conecta:
   - `Create Row` → `Debug Create Row`
   - `Debug Create Row` → `Format Register Response`

### Paso 2: Ejecutar Test

1. Ejecuta el workflow desde el chat
2. Ve al **Workflow 2**
3. Revisa el nodo **"Debug Create Row"**
4. Si tiene datos → el problema está en `Format Register Response`
5. Si NO tiene datos → el problema está en `Create Row`

---

## Si el Problema Está en "Create Row"

### Causa Más Común: Permisos

**Verificar**:
```bash
# En Google Cloud Console
Scopes autorizados:
✅ https://www.googleapis.com/auth/spreadsheets
❌ https://www.googleapis.com/auth/spreadsheets.readonly
```

**Fix**:
1. n8n → Settings → Credentials
2. Edita "Google Sheets account 2"
3. Reconnect
4. Acepta TODOS los permisos

---

## Si el Problema Está en "Format Register Response"

### Causa: Expresiones Incorrectas

El nodo `Format Register Response` usa:
```javascript
$('Execute Workflow Trigger').item.json.accion
```

Pero después de pasar por `Create Row`, el contexto puede haber cambiado.

**Fix**: Usar `$node` en lugar de `$()`:

```json
{
  "assignments": {
    "assignments": [
      {
        "name": "result",
        "type": "object",
        "value": "={{ {\n  success: true,\n  accion: 'CREAR',\n  empresa: $node['Execute Workflow Trigger'].json.sheet_name,\n  message: '✅ Registro creado exitosamente',\n  registro_afectado: $json\n} }}"
      }
    ]
  }
}
```

---

## Test Completo

### Datos de Prueba

```json
{
  "command": "register",
  "sheet_name": "ROBUSTA",
  "accion": "CREAR",
  "datos": {
    "fecha": "12-ene",
    "descripcion": "Test de debugging",
    "tipo": "EGRESO",
    "monto": 5000,
    "categoria": "Prueba",
    "comentario": "Test manual desde n8n"
  }
}
```

### Resultado Esperado

```json
{
  "result": {
    "success": true,
    "accion": "CREAR",
    "empresa": "ROBUSTA",
    "message": "✅ Registro creado exitosamente",
    "registro_afectado": {
      "FECHA": "12-ene",
      "DESCRIPCION / DETALLE": "Test de debugging",
      "INGRESO": "",
      "EGRESO": "5000",
      "SALDO": "",
      "CATEGORIA": "Prueba",
      "COMENTARIO": "Test manual desde n8n"
    }
  }
}
```

---

## Checklist de Verificación

- [ ] Permisos de Google Sheets verificados (lectura + escritura)
- [ ] Nombres de columnas coinciden exactamente
- [ ] Nodo "Debug Create Row" agregado
- [ ] Test manual ejecutado
- [ ] Datos aparecen en Google Sheets
- [ ] Workflow devuelve respuesta al chat

---

## Si Nada Funciona

**Última opción**: Reemplazar el nodo `Create Row` por un nodo `HTTP Request` que use la API de Google Sheets directamente.

¿Necesitas que te genere esa configuración?
