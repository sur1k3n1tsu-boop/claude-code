# Script para organizar documentos en Windows
# Creado para: rayas
# Ejecutar con PowerShell

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "   Sistema de Organización de Documentos" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# Obtener la ruta de Documentos del usuario
$DocumentosPath = [Environment]::GetFolderPath("MyDocuments")
Write-Host "Creando estructura en: $DocumentosPath" -ForegroundColor Yellow
Write-Host ""

# Crear carpetas principales
$carpetasPrincipales = @(
    "Personal",
    "Trabajo",
    "Proyectos",
    "Finanzas",
    "Educacion",
    "Salud",
    "Legal",
    "Referencias",
    "Archivos",
    "Temporal"
)

Write-Host "Creando carpetas principales..." -ForegroundColor Green
foreach ($carpeta in $carpetasPrincipales) {
    $rutaCarpeta = Join-Path $DocumentosPath $carpeta
    if (!(Test-Path $rutaCarpeta)) {
        New-Item -Path $rutaCarpeta -ItemType Directory -Force | Out-Null
        Write-Host "  ✓ $carpeta" -ForegroundColor Green
    } else {
        Write-Host "  → $carpeta (ya existe)" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Creando subcarpetas..." -ForegroundColor Green

# Personal
$subcarpetas = @{
    "Personal" = @("Identificacion", "Certificados", "CV", "Fotos", "Cartas")
    "Trabajo" = @("Contratos", "Nominas", "Reportes", "Presentaciones", "Reuniones")
    "Proyectos" = @("Activos", "Completados", "Ideas", "Plantillas")
    "Finanzas" = @("Facturas", "Recibos", "Impuestos", "Presupuestos", "Inversiones")
    "Educacion" = @("Cursos", "Certificaciones", "Libros", "Apuntes", "Investigacion")
    "Salud" = @("Historiales", "Recetas", "Seguros", "Examenes")
    "Legal" = @("Contratos", "Escrituras", "Testamentos", "Poderes")
    "Referencias" = @("Manuales", "Guias", "Tutoriales", "Contactos")
    "Archivos" = @("2024", "2025", "2026")
}

foreach ($carpetaPrincipal in $subcarpetas.Keys) {
    Write-Host "  $carpetaPrincipal:" -ForegroundColor Cyan
    foreach ($subcarpeta in $subcarpetas[$carpetaPrincipal]) {
        $rutaCompleta = Join-Path (Join-Path $DocumentosPath $carpetaPrincipal) $subcarpeta
        if (!(Test-Path $rutaCompleta)) {
            New-Item -Path $rutaCompleta -ItemType Directory -Force | Out-Null
            Write-Host "    ✓ $subcarpeta" -ForegroundColor Green
        } else {
            Write-Host "    → $subcarpeta (ya existe)" -ForegroundColor Yellow
        }
    }
}

# Crear archivo README
Write-Host ""
Write-Host "Creando archivo README..." -ForegroundColor Green

$readmeContent = @"
# Sistema de Organización de Documentos

Esta estructura te ayudará a mantener tus documentos organizados de manera eficiente.

## 📁 Estructura de Carpetas

### 🏠 **Personal**
Documentos personales e información privada
- Identificacion/ - DNI, pasaporte, licencias
- Certificados/ - Certificados de nacimiento, matrimonio, etc.
- CV/ - Currículums y portfolios
- Fotos/ - Fotografías de documentos importantes
- Cartas/ - Correspondencia personal

### 💼 **Trabajo**
Todo relacionado con tu vida laboral
- Contratos/ - Contratos de trabajo
- Nominas/ - Recibos de nómina
- Reportes/ - Reportes y análisis laborales
- Presentaciones/ - Presentaciones profesionales
- Reuniones/ - Actas y notas de reuniones

### 🚀 **Proyectos**
Gestión de proyectos personales y profesionales
- Activos/ - Proyectos en curso
- Completados/ - Proyectos finalizados
- Ideas/ - Conceptos y propuestas
- Plantillas/ - Templates reutilizables

### 💰 **Finanzas**
Gestión financiera y contabilidad
- Facturas/ - Facturas recibidas y emitidas
- Recibos/ - Comprobantes de pago
- Impuestos/ - Declaraciones y documentos fiscales
- Presupuestos/ - Planificación financiera
- Inversiones/ - Documentos de inversiones

### 📚 **Educacion**
Aprendizaje y desarrollo profesional
- Cursos/ - Material de cursos
- Certificaciones/ - Certificados de cursos completados
- Libros/ - eBooks y material de lectura
- Apuntes/ - Notas y resúmenes
- Investigacion/ - Papers y artículos de investigación

### 🏥 **Salud**
Información médica y de salud
- Historiales/ - Historiales médicos
- Recetas/ - Prescripciones médicas
- Seguros/ - Pólizas de seguro médico
- Examenes/ - Resultados de exámenes

### ⚖️ **Legal**
Documentos legales importantes
- Contratos/ - Contratos legales
- Escrituras/ - Escrituras de propiedad
- Testamentos/ - Documentos testamentarios
- Poderes/ - Poderes notariales

### 📖 **Referencias**
Material de consulta
- Manuales/ - Manuales de usuario
- Guias/ - Guías de referencia
- Tutoriales/ - Tutoriales guardados
- Contactos/ - Información de contactos importantes

### 📦 **Archivos**
Documentos antiguos organizados por año
- 2024/ - Documentos del año 2024
- 2025/ - Documentos del año 2025
- 2026/ - Documentos del año 2026

### ⏱️ **Temporal**
Archivos temporales que necesitan ser clasificados o eliminados

## 💡 Consejos de Uso

1. **Nomenclatura**: Usa nombres descriptivos para tus archivos
   - Ejemplo: 2026-01-Contrato_Trabajo_EmpresaXYZ.pdf
   - Formato: YYYY-MM-Descripcion.extension

2. **Limpieza regular**: Revisa la carpeta Temporal/ semanalmente

3. **Archivo anual**: Al final de cada año, mueve documentos antiguos a la carpeta correspondiente en Archivos/

4. **Backups**: Realiza copias de seguridad periódicas de tu carpeta Documentos

5. **Privacidad**: Mantén documentos sensibles protegidos

## 🔍 Búsqueda Rápida en Windows

Usa la barra de búsqueda de Windows (tecla Windows + S) y busca:
- Por nombre de archivo
- Por contenido (si el archivo es de texto)
- Por fecha de modificación

## 📝 Mantenimiento

- **Diario**: Coloca nuevos documentos en sus carpetas correspondientes
- **Semanal**: Limpia la carpeta Temporal/
- **Mensual**: Revisa y reorganiza si es necesario
- **Anual**: Archiva documentos del año anterior

---
Creado el: $(Get-Date -Format "yyyy-MM-dd")
Usuario: $env:USERNAME
"@

$readmePath = Join-Path $DocumentosPath "ORGANIZACION_README.txt"
$readmeContent | Out-File -FilePath $readmePath -Encoding UTF8 -Force

Write-Host "  ✓ ORGANIZACION_README.txt creado" -ForegroundColor Green

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "   ¡Estructura creada exitosamente!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Ubicación: $DocumentosPath" -ForegroundColor Yellow
Write-Host ""
Write-Host "Lee el archivo ORGANIZACION_README.txt para más información." -ForegroundColor Cyan
Write-Host ""
Write-Host "Presiona cualquier tecla para salir..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
