@echo off
chcp 65001 >nul
title Sistema de Organización de Documentos

echo ================================================
echo    Sistema de Organización de Documentos
echo ================================================
echo.

:: Crear carpetas principales
echo Creando carpetas principales...
mkdir "%USERPROFILE%\Documents\Personal" 2>nul
mkdir "%USERPROFILE%\Documents\Trabajo" 2>nul
mkdir "%USERPROFILE%\Documents\Proyectos" 2>nul
mkdir "%USERPROFILE%\Documents\Finanzas" 2>nul
mkdir "%USERPROFILE%\Documents\Educacion" 2>nul
mkdir "%USERPROFILE%\Documents\Salud" 2>nul
mkdir "%USERPROFILE%\Documents\Legal" 2>nul
mkdir "%USERPROFILE%\Documents\Referencias" 2>nul
mkdir "%USERPROFILE%\Documents\Archivos" 2>nul
mkdir "%USERPROFILE%\Documents\Temporal" 2>nul

echo   √ Personal
echo   √ Trabajo
echo   √ Proyectos
echo   √ Finanzas
echo   √ Educacion
echo   √ Salud
echo   √ Legal
echo   √ Referencias
echo   √ Archivos
echo   √ Temporal
echo.

echo Creando subcarpetas...
echo.

:: Personal
echo   Personal:
mkdir "%USERPROFILE%\Documents\Personal\Identificacion" 2>nul
mkdir "%USERPROFILE%\Documents\Personal\Certificados" 2>nul
mkdir "%USERPROFILE%\Documents\Personal\CV" 2>nul
mkdir "%USERPROFILE%\Documents\Personal\Fotos" 2>nul
mkdir "%USERPROFILE%\Documents\Personal\Cartas" 2>nul
echo     √ Identificacion, Certificados, CV, Fotos, Cartas

:: Trabajo
echo   Trabajo:
mkdir "%USERPROFILE%\Documents\Trabajo\Contratos" 2>nul
mkdir "%USERPROFILE%\Documents\Trabajo\Nominas" 2>nul
mkdir "%USERPROFILE%\Documents\Trabajo\Reportes" 2>nul
mkdir "%USERPROFILE%\Documents\Trabajo\Presentaciones" 2>nul
mkdir "%USERPROFILE%\Documents\Trabajo\Reuniones" 2>nul
echo     √ Contratos, Nominas, Reportes, Presentaciones, Reuniones

:: Proyectos
echo   Proyectos:
mkdir "%USERPROFILE%\Documents\Proyectos\Activos" 2>nul
mkdir "%USERPROFILE%\Documents\Proyectos\Completados" 2>nul
mkdir "%USERPROFILE%\Documents\Proyectos\Ideas" 2>nul
mkdir "%USERPROFILE%\Documents\Proyectos\Plantillas" 2>nul
echo     √ Activos, Completados, Ideas, Plantillas

:: Finanzas
echo   Finanzas:
mkdir "%USERPROFILE%\Documents\Finanzas\Facturas" 2>nul
mkdir "%USERPROFILE%\Documents\Finanzas\Recibos" 2>nul
mkdir "%USERPROFILE%\Documents\Finanzas\Impuestos" 2>nul
mkdir "%USERPROFILE%\Documents\Finanzas\Presupuestos" 2>nul
mkdir "%USERPROFILE%\Documents\Finanzas\Inversiones" 2>nul
echo     √ Facturas, Recibos, Impuestos, Presupuestos, Inversiones

:: Educacion
echo   Educacion:
mkdir "%USERPROFILE%\Documents\Educacion\Cursos" 2>nul
mkdir "%USERPROFILE%\Documents\Educacion\Certificaciones" 2>nul
mkdir "%USERPROFILE%\Documents\Educacion\Libros" 2>nul
mkdir "%USERPROFILE%\Documents\Educacion\Apuntes" 2>nul
mkdir "%USERPROFILE%\Documents\Educacion\Investigacion" 2>nul
echo     √ Cursos, Certificaciones, Libros, Apuntes, Investigacion

:: Salud
echo   Salud:
mkdir "%USERPROFILE%\Documents\Salud\Historiales" 2>nul
mkdir "%USERPROFILE%\Documents\Salud\Recetas" 2>nul
mkdir "%USERPROFILE%\Documents\Salud\Seguros" 2>nul
mkdir "%USERPROFILE%\Documents\Salud\Examenes" 2>nul
echo     √ Historiales, Recetas, Seguros, Examenes

:: Legal
echo   Legal:
mkdir "%USERPROFILE%\Documents\Legal\Contratos" 2>nul
mkdir "%USERPROFILE%\Documents\Legal\Escrituras" 2>nul
mkdir "%USERPROFILE%\Documents\Legal\Testamentos" 2>nul
mkdir "%USERPROFILE%\Documents\Legal\Poderes" 2>nul
echo     √ Contratos, Escrituras, Testamentos, Poderes

:: Referencias
echo   Referencias:
mkdir "%USERPROFILE%\Documents\Referencias\Manuales" 2>nul
mkdir "%USERPROFILE%\Documents\Referencias\Guias" 2>nul
mkdir "%USERPROFILE%\Documents\Referencias\Tutoriales" 2>nul
mkdir "%USERPROFILE%\Documents\Referencias\Contactos" 2>nul
echo     √ Manuales, Guias, Tutoriales, Contactos

:: Archivos
echo   Archivos:
mkdir "%USERPROFILE%\Documents\Archivos\2024" 2>nul
mkdir "%USERPROFILE%\Documents\Archivos\2025" 2>nul
mkdir "%USERPROFILE%\Documents\Archivos\2026" 2>nul
echo     √ 2024, 2025, 2026

echo.
echo Creando archivo de instrucciones...

:: Crear archivo README
(
echo # Sistema de Organizacion de Documentos
echo.
echo Esta estructura te ayudara a mantener tus documentos organizados de manera eficiente.
echo.
echo ## Estructura de Carpetas
echo.
echo ### Personal - Documentos personales e informacion privada
echo   - Identificacion/ - DNI, pasaporte, licencias
echo   - Certificados/ - Certificados de nacimiento, matrimonio, etc.
echo   - CV/ - Curriculos y portfolios
echo   - Fotos/ - Fotografias de documentos importantes
echo   - Cartas/ - Correspondencia personal
echo.
echo ### Trabajo - Todo relacionado con tu vida laboral
echo   - Contratos/ - Contratos de trabajo
echo   - Nominas/ - Recibos de nomina
echo   - Reportes/ - Reportes y analisis laborales
echo   - Presentaciones/ - Presentaciones profesionales
echo   - Reuniones/ - Actas y notas de reuniones
echo.
echo ### Proyectos - Gestion de proyectos personales y profesionales
echo   - Activos/ - Proyectos en curso
echo   - Completados/ - Proyectos finalizados
echo   - Ideas/ - Conceptos y propuestas
echo   - Plantillas/ - Templates reutilizables
echo.
echo ### Finanzas - Gestion financiera y contabilidad
echo   - Facturas/ - Facturas recibidas y emitidas
echo   - Recibos/ - Comprobantes de pago
echo   - Impuestos/ - Declaraciones y documentos fiscales
echo   - Presupuestos/ - Planificacion financiera
echo   - Inversiones/ - Documentos de inversiones
echo.
echo ### Educacion - Aprendizaje y desarrollo profesional
echo   - Cursos/ - Material de cursos
echo   - Certificaciones/ - Certificados de cursos completados
echo   - Libros/ - eBooks y material de lectura
echo   - Apuntes/ - Notas y resumenes
echo   - Investigacion/ - Papers y articulos de investigacion
echo.
echo ### Salud - Informacion medica y de salud
echo   - Historiales/ - Historiales medicos
echo   - Recetas/ - Prescripciones medicas
echo   - Seguros/ - Polizas de seguro medico
echo   - Examenes/ - Resultados de examenes
echo.
echo ### Legal - Documentos legales importantes
echo   - Contratos/ - Contratos legales
echo   - Escrituras/ - Escrituras de propiedad
echo   - Testamentos/ - Documentos testamentarios
echo   - Poderes/ - Poderes notariales
echo.
echo ### Referencias - Material de consulta
echo   - Manuales/ - Manuales de usuario
echo   - Guias/ - Guias de referencia
echo   - Tutoriales/ - Tutoriales guardados
echo   - Contactos/ - Informacion de contactos importantes
echo.
echo ### Archivos - Documentos antiguos organizados por ano
echo   - 2024/ - Documentos del ano 2024
echo   - 2025/ - Documentos del ano 2025
echo   - 2026/ - Documentos del ano 2026
echo.
echo ### Temporal - Archivos temporales que necesitan ser clasificados o eliminados
echo.
echo ## Consejos de Uso
echo.
echo 1. Nomenclatura: Usa nombres descriptivos para tus archivos
echo    - Ejemplo: 2026-01-Contrato_Trabajo_EmpresaXYZ.pdf
echo    - Formato: YYYY-MM-Descripcion.extension
echo.
echo 2. Limpieza regular: Revisa la carpeta Temporal/ semanalmente
echo.
echo 3. Archivo anual: Al final de cada ano, mueve documentos antiguos a Archivos/
echo.
echo 4. Backups: Realiza copias de seguridad periodicas de tu carpeta Documentos
echo.
echo 5. Privacidad: Manten documentos sensibles protegidos
echo.
echo ## Mantenimiento
echo.
echo - Diario: Coloca nuevos documentos en sus carpetas correspondientes
echo - Semanal: Limpia la carpeta Temporal/
echo - Mensual: Revisa y reorganiza si es necesario
echo - Anual: Archiva documentos del ano anterior
echo.
echo ---
echo Creado el: %DATE%
echo Usuario: %USERNAME%
) > "%USERPROFILE%\Documents\ORGANIZACION_README.txt"

echo   √ ORGANIZACION_README.txt creado
echo.

echo ================================================
echo    ¡Estructura creada exitosamente!
echo ================================================
echo.
echo Ubicacion: %USERPROFILE%\Documents
echo.
echo Lee el archivo ORGANIZACION_README.txt para mas informacion.
echo.
echo Presiona cualquier tecla para abrir la carpeta Documentos...
pause >nul

:: Abrir la carpeta de Documentos
start "" "%USERPROFILE%\Documents"
