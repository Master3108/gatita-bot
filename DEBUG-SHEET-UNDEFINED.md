# 🔍 Guía de Debugging: Error "Sheet with name undefined not found"

## 📋 Diagnóstico del Error

El error indica que `sheet_name` está llegando como `undefined` al Workflow 2.

---

## 🧪 Test de Debugging

### **Paso 1: Verificar qué datos llegan al Workflow 2**

1. Abre el **Workflow 2** en n8n
2. Agrega un nodo **`Set`** justo después del `Execute Workflow Trigger`
3. Configúralo así:

```json
{
  "assignments": {
    "assignments": [
      {
        "name": "debug_data",
        "type": "object",
        "value": "={{ $json }}"
      },
      {
        "name": "command",
        "type": "string",
        "value": "={{ $json.command }}"
      },
      {
        "name": "sheet_name",
        "type": "string",
        "value": "={{ $json.sheet_name }}"
      },
      {
        "name": "accion",
        "type": "string",
        "value": "={{ $json.accion }}"
      },
      {
        "name": "datos",
        "type": "object",
        "value": "={{ $json.datos }}"
      }
    ]
  }
}
```

4. Ejecuta el workflow y revisa qué valores aparecen

---

## 🔧 Soluciones Posibles

### **Solución 1: El AI Agent no está pasando sheet_name**

**Problema**: El AI Agent está llamando la herramienta sin el parámetro `sheet_name`.

**Causa**: El prompt del AI Agent no está instruyendo correctamente sobre cómo usar la herramienta.

**Fix**: Actualizar el prompt del AI Agent para ser más explícito:

```
IMPORTANTE PARA REGISTRO:
Cuando uses la herramienta "register", SIEMPRE debes incluir:
1. sheet_name: La empresa (CASAZ, ROBUSTA, ARPINO o CB)
2. accion: CREAR, ACTUALIZAR o MARCAR_PAGADO
3. datos: Objeto con los campos necesarios según la acción

Ejemplo de llamada correcta:
register({
  sheet_name: "CASAZ",
  accion: "CREAR",
  datos: {
    fecha: "10-ene",
    descripcion: "Arriendo",
    tipo: "EGRESO",
    monto: 50000
  }
})
```

---

### **Solución 2: Problema con el mapping de parámetros en n8n**

**Problema**: n8n no está mapeando correctamente los parámetros del `inputSchema` al trigger.

**Causa**: Versión de n8n o configuración del nodo `toolWorkflow`.

**Fix**: Usar un enfoque diferente para pasar parámetros.

#### Opción A: Pasar todo en un solo objeto

Cambiar el `inputSchema` de la herramienta `register` para que agrupe todos los parámetros:

```json
{
  "type": "object",
  "properties": {
    "params": {
      "type": "object",
      "properties": {
        "sheet_name": {...},
        "accion": {...},
        "datos": {...},
        "filtro": {...}
      },
      "required": ["sheet_name", "accion"]
    }
  },
  "required": ["params"]
}
```

Luego en el Workflow 2, acceder a:
```
$('Execute Workflow Trigger').item.json.params.sheet_name
```

#### Opción B: Usar fields estáticos

Agregar `sheet_name` como un campo dinámico en `fields`:

**NO RECOMENDADO** porque `sheet_name` es dinámico.

---

### **Solución 3: El problema está en el Workflow 2**

**Problema**: El Workflow 2 está accediendo incorrectamente a los parámetros.

**Causa**: Sintaxis incorrecta en las expresiones.

**Fix**: Verificar que todas las referencias sean exactamente:

```javascript
$('Execute Workflow Trigger').item.json.sheet_name
$('Execute Workflow Trigger').item.json.accion
$('Execute Workflow Trigger').item.json.datos
$('Execute Workflow Trigger').item.json.filtro
```

---

## 🎯 Solución Recomendada (Más Probable)

El problema más común es que **el AI Agent no está extrayendo correctamente el nombre de la empresa** de la conversación del usuario.

### **Fix Rápido: Mejorar el Prompt del AI Agent**

Agrega esta sección al prompt del AI Agent (Workflow 1):

```
📝 REGLAS PARA REGISTRO:

ANTES de llamar a la herramienta "register", DEBES:

1. **Verificar que tienes la empresa**:
   - Si el usuario NO mencionó la empresa, pregunta: "¿En qué empresa quieres registrar esto? (CASAZ, ROBUSTA, ARPINO o CB)"
   - NO llames a "register" sin tener sheet_name confirmado

2. **Extraer la fecha correctamente**:
   - Formato requerido: "DD-MMM" (ej: "10-ene", "25-mar")
   - Si el usuario dice "10 de enero", convierte a "10-ene"
   - Meses válidos: ene, feb, mar, abr, may, jun, jul, ago, sep, oct, nov, dic

3. **Convertir el monto a número**:
   - Si el usuario dice "$50.000", convierte a 50000 (sin símbolos ni puntos)
   - Si el usuario dice "cincuenta mil", convierte a 50000

4. **Determinar el tipo automáticamente**:
   - Si dice "gasto", "egreso", "pago", "compra" → tipo: "EGRESO"
   - Si dice "ingreso", "cobro", "venta" → tipo: "INGRESO"

EJEMPLO DE INTERACCIÓN CORRECTA:

Usuario: "Registra el arriendo de enero"
Tú: "¿De qué empresa? (CASAZ, ROBUSTA, ARPINO o CB)"
Usuario: "CASAZ"
Tú: "¿Cuál fue el monto y la fecha exacta?"
Usuario: "$500.000 el 5 de enero"
Tú: "¿Confirmas que quieres CREAR este registro?
📋 Detalles:
- Empresa: CASAZ
- Fecha: 05-ene
- Concepto: Arriendo
- Tipo: EGRESO
- Monto: $500.000"
Usuario: "Sí"
Tú llamas: register({
  sheet_name: "CASAZ",
  accion: "CREAR",
  datos: {
    fecha: "05-ene",
    descripcion: "Arriendo",
    tipo: "EGRESO",
    monto: 500000,
    categoria: "Arriendo"
  }
})
```

---

## 🧪 Test Manual

Para verificar que el Workflow 2 funciona correctamente:

1. Abre el **Workflow 2**
2. Click en `Execute Workflow Trigger`
3. Click en "Test Step" o "Execute Node"
4. En el panel de datos de prueba, ingresa:

```json
{
  "command": "register",
  "sheet_name": "CASAZ",
  "accion": "CREAR",
  "datos": {
    "fecha": "12-ene",
    "descripcion": "Test de registro",
    "tipo": "EGRESO",
    "monto": 1000,
    "categoria": "Prueba",
    "comentario": "Test desde debugging"
  }
}
```

5. Ejecuta el workflow completo
6. Si funciona → el problema está en el Workflow 1 (AI Agent)
7. Si falla → el problema está en el Workflow 2

---

## 📞 Siguiente Paso

**Dime:**
1. ¿Probaste el test manual del Workflow 2?
2. ¿Qué datos aparecen en el nodo de debugging?
3. ¿El error ocurre al llamar desde el chat o al probar manualmente?

Con esa información puedo darte la solución exacta.
