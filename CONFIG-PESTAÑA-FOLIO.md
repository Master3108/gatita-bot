# 🔧 Configuración para Usar Pestaña "FOLIO" Única

## Cambios en Workflow 2

### **1. Nodo "Get All Rows"**
Cambiar el Sheet Name de dinámico a fijo:

**Antes:**
```javascript
={{ $json.query.sheet_name }}
```

**Después:**
```
FOLIO
```

---

### **2. Nodo "Create Row"**
Cambiar el Sheet Name de dinámico a fijo:

**Antes:**
```javascript
={{ $json.query.sheet_name }}
```

**Después:**
```
FOLIO
```

---

### **3. Agregar Columna "EMPRESA" en Google Sheets**

1. Abre la pestaña "FOLIO"
2. Agrega una nueva columna llamada "EMPRESA"
3. Esta columna guardará: CASAZ, ROBUSTA, ARPINO o CB

---

### **4. Actualizar el Nodo "Create Row" para Incluir EMPRESA**

El mapeo de columnas debe incluir:

```json
{
  "EMPRESA": "={{ $json.query.sheet_name }}",
  "FOLIO": "={{ $json.query.FOLIO }}",
  "RUT": "={{ $json.query.RUT }}",
  "RAZON SOCIAL": "={{ $json.query['RAZON SOCIAL'] }}",
  "SALDO PENDIENTE": "={{ $json.query['SALDO PENDIENTE'] }}",
  "COMENTARIO": "={{ $json.query.COMENTARIO || '' }}",
  "GLOSA": "={{ $json.query.GLOSA || '' }}"
}
```

---

### **5. Actualizar el Filtro de Búsqueda**

En el nodo "Clean & Convert Data", agregar un filtro para la empresa:

```javascript
// Filtrar por empresa si se especificó
const empresa = $('Execute Workflow Trigger').item.json.query.sheet_name;
if (empresa && $json.EMPRESA !== empresa) {
  return null; // Excluir este registro
}
return $json;
```

---

## ✅ Resultado

Con estos cambios:
- Todos los registros se guardan en la pestaña "FOLIO"
- La columna "EMPRESA" indica a qué empresa pertenece cada registro
- Las búsquedas filtran automáticamente por empresa
- El sistema muestra las columnas correctas: FOLIO, RUT, RAZON SOCIAL, SALDO PENDIENTE, COMENTARIO, GLOSA
