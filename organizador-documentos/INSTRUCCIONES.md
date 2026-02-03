# 📁 Organizador de Documentos para Windows

Sistema automático de organización de documentos para tu PC con Windows.

## 🎯 ¿Qué hace este script?

Crea una estructura completa de carpetas en tu carpeta "Documentos" de Windows con:

- **10 categorías principales**: Personal, Trabajo, Proyectos, Finanzas, Educación, Salud, Legal, Referencias, Archivos y Temporal
- **45+ subcarpetas** organizadas por tipo de documento
- **Archivo de guía** con instrucciones de uso y mantenimiento

## 📥 Cómo usar

### Opción 1: Script Batch (Recomendado - Más fácil)

1. **Descarga el archivo** `organizar_documentos.bat` a tu carpeta de Descargas
   - Ruta: `C:\Users\rayas\Downloads\organizar_documentos.bat`

2. **Haz doble clic** en el archivo `organizar_documentos.bat`

3. Si Windows te pregunta "¿Desea permitir que esta aplicación realice cambios en el dispositivo?", haz clic en **Sí**

4. El script creará automáticamente todas las carpetas y abrirá tu carpeta de Documentos

5. ¡Listo! Ya puedes empezar a organizar tus archivos

### Opción 2: Script PowerShell (Más completo)

1. **Descarga el archivo** `organizar_documentos.ps1` a tu carpeta de Descargas

2. **Abre PowerShell**:
   - Presiona `Windows + X`
   - Selecciona "Windows PowerShell" o "Terminal"

3. **Navega a tu carpeta de Descargas**:
   ```powershell
   cd C:\Users\rayas\Downloads
   ```

4. **Si es la primera vez que ejecutas scripts de PowerShell**, necesitas habilitar la ejecución:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```
   - Escribe **S** y presiona Enter para confirmar

5. **Ejecuta el script**:
   ```powershell
   .\organizar_documentos.ps1
   ```

6. El script mostrará el progreso y al final te pedirá presionar una tecla para salir

## 📂 Estructura creada

```
C:\Users\rayas\Documents\
│
├── Personal/
│   ├── Identificacion/
│   ├── Certificados/
│   ├── CV/
│   ├── Fotos/
│   └── Cartas/
│
├── Trabajo/
│   ├── Contratos/
│   ├── Nominas/
│   ├── Reportes/
│   ├── Presentaciones/
│   └── Reuniones/
│
├── Proyectos/
│   ├── Activos/
│   ├── Completados/
│   ├── Ideas/
│   └── Plantillas/
│
├── Finanzas/
│   ├── Facturas/
│   ├── Recibos/
│   ├── Impuestos/
│   ├── Presupuestos/
│   └── Inversiones/
│
├── Educacion/
│   ├── Cursos/
│   ├── Certificaciones/
│   ├── Libros/
│   ├── Apuntes/
│   └── Investigacion/
│
├── Salud/
│   ├── Historiales/
│   ├── Recetas/
│   ├── Seguros/
│   └── Examenes/
│
├── Legal/
│   ├── Contratos/
│   ├── Escrituras/
│   ├── Testamentos/
│   └── Poderes/
│
├── Referencias/
│   ├── Manuales/
│   ├── Guias/
│   ├── Tutoriales/
│   └── Contactos/
│
├── Archivos/
│   ├── 2024/
│   ├── 2025/
│   └── 2026/
│
└── Temporal/
```

## 💡 Consejos de uso

### 1. Nomenclatura de archivos
Usa nombres descriptivos y fechas:
- ✅ `2026-01-15_Contrato_Trabajo_Microsoft.pdf`
- ✅ `2026-01_Nomina_Enero.pdf`
- ✅ `CV_Rayas_Actualizado_2026.pdf`
- ❌ `documento.pdf`
- ❌ `archivo1.docx`

### 2. Flujo de trabajo diario
1. Descarga un documento nuevo → Lo pones en la carpeta `Temporal/`
2. Una vez a la semana, organiza todo lo que hay en `Temporal/`
3. Mueve cada archivo a su carpeta correspondiente

### 3. Mantenimiento
- **Diario**: Guarda nuevos documentos en sus carpetas
- **Semanal**: Limpia la carpeta `Temporal/`
- **Mensual**: Revisa y reorganiza si es necesario
- **Anual**: Archiva documentos viejos en `Archivos/YYYY/`

### 4. Backups
Configura copias de seguridad automáticas:
- **OneDrive**: Ya sincroniza automáticamente tu carpeta Documentos
- **Google Drive**: Descarga la app y configura sincronización
- **Disco externo**: Copia manual mensual recomendada

## 🔍 Buscar documentos

### Método 1: Búsqueda de Windows
1. Presiona `Windows + S`
2. Escribe el nombre del documento o palabra clave
3. Selecciona "Documentos" como ubicación

### Método 2: Explorador de archivos
1. Abre `C:\Users\rayas\Documents`
2. Usa la barra de búsqueda arriba a la derecha
3. Filtra por fecha, tipo de archivo, etc.

## ❓ Preguntas frecuentes

**¿Puedo ejecutar el script varias veces?**
Sí, no hay problema. Si las carpetas ya existen, el script las respetará.

**¿Se borrarán mis documentos existentes?**
No. El script solo crea carpetas nuevas, nunca borra nada.

**¿Puedo personalizar las carpetas?**
Sí, después de ejecutar el script puedes:
- Agregar más subcarpetas
- Renombrar carpetas
- Eliminar carpetas que no uses

**¿Funciona en Windows 11?**
Sí, funciona en Windows 10 y Windows 11.

## 🆘 Solución de problemas

**"No se puede ejecutar el script porque está deshabilitada la ejecución de scripts"**
- Solución: Usa el archivo `.bat` en lugar del `.ps1`, o sigue las instrucciones de la Opción 2, paso 4

**"Acceso denegado"**
- Solución: Ejecuta el script haciendo clic derecho → "Ejecutar como administrador"

**El script no hace nada**
- Verifica que descargaste el archivo completo
- Asegúrate de estar en la carpeta correcta al ejecutarlo

## 📧 Soporte

Si tienes problemas o preguntas, revisa:
1. Este archivo de instrucciones
2. El archivo `ORGANIZACION_README.txt` que se crea en tu carpeta Documentos
3. Busca en Google el mensaje de error específico

---

**Creado para**: rayas
**Fecha**: 2026-02-03
**Sistema**: Windows 10/11
**Idioma**: Español
