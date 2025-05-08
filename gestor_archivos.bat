@echo off
setlocal enabledelayedexpansion

::: CONFIGURACIÓN GLOBAL :::
set "COLOR_TITLE=0B"     &:: Cyan para encabezados
set "COLOR_MENU=07"      &:: Gris claro para menús
set "COLOR_INPUT=0F"     &:: Blanco brillante para entradas
set "COLOR_SUCCESS=0A"   &:: Verde para operaciones exitosas
set "COLOR_ERROR=0C"     &:: Rojo para errores
set "COLOR_LIST=0E"      &:: Amarillo para listados

::: CONFIGURACIÓN PERSONALIZADA :::
set "REGISTRO_PRIVADO=%USERPROFILE%\.archivo_ocultos.dat"
set "CLAVE_CIFRADO=MiClaveSecreta123"
set "PREFIJO_OCULTO=.hidden_"
set "METODO_OCULTAMIENTO=2"
:: Metodos de ocultamiento:
:: 1 = Añadir prefijo personalizado
:: 2 = Renombrar + mover a carpeta segura
:: 3 = Cifrado XOR básico (experimental)

::: INICIALIZACIÓN :::
if not exist "%REGISTRO_PRIVADO%" (
    echo. > "%REGISTRO_PRIVADO%"
    attrib +h +s "%REGISTRO_PRIVADO%" >nul
)

if "%METODO_OCULTAMIENTO%"=="2" (
    if not exist "%USERPROFILE%\.archivos_seguros\" (
        mkdir "%USERPROFILE%\.archivos_seguros\" >nul
        attrib +h +s "%USERPROFILE%\.archivos_seguros" >nul
    )
)

::: MENÚ PRINCIPAL :::
:menu_principal
cls
color %COLOR_TITLE%
echo ================================================
echo      GESTOR AVANZADO DE ARCHIVOS [v5.0]
echo ================================================
color %COLOR_MENU%
echo 1. Alternar visibilidad global de archivos ocultos
echo 2. Modo seguro (ocultar protegidos + elementos)
echo 3. Modo desarrollador (mostrar protegidos)
echo 4. Ocultar elemento con metodo estandar (+H +S)
echo 5. Mostrar elemento con metodo estandar (-H -S)
echo 6. Explorador de archivos ocultos (TIEMPO REAL)
echo ------------------------------------------------
echo 7. [NUEVO] Ocultar elemento con metodo personalizado
echo 8. [NUEVO] Mostrar elemento ocultado personalmente
echo 9. [NUEVO] Ver lista de elementos ocultados personalmente
echo 0. [NUEVO] Configurar metodo de ocultamiento personalizado
echo X. Salir
echo ================================================
choice /C 1234567890X /N /M "Seleccione opcion [1-0,X]: "

set "opt=%errorlevel%"
if "%opt%"=="11" exit
if "%opt%"=="10" goto config_metodo_ocultamiento
if "%opt%"=="9" goto ver_lista_personalizada
if "%opt%"=="8" goto mostrar_personalizado
if "%opt%"=="7" goto ocultar_personalizado
if "%opt%"=="6" call :explorador_ocultos
if "%opt%"=="5" call :gestion_elementos -h -s "MOSTRAR"
if "%opt%"=="4" call :gestion_elementos +h +s "OCULTAR"
if "%opt%"=="3" call :modificar_registro ShowSuperHidden 1 "Modo desarrollador activado" Hidden 1
if "%opt%"=="2" call :modificar_registro ShowSuperHidden 0 "Modo seguro activado" Hidden 0
if "%opt%"=="1" call :toggle_ocultos
goto menu_principal

::: MÓDULO DE OCULTAMIENTO PERSONALIZADO :::
:ocultar_personalizado
cls
color %COLOR_INPUT%
echo [ SISTEMA DE OCULTAMIENTO PERSONALIZADO ]
echo.
echo Ingrese la ruta completa del archivo/carpeta a ocultar:
set /p "ruta_objetivo=>> "

if not exist "!ruta_objetivo!" (
    call :mostrar_error "La ruta especificada no existe"
    goto menu_principal
)

:: Extraer nombre base y ruta padre
for %%F in ("!ruta_objetivo!") do (
    set "nombre_original=%%~nxF"
    set "ruta_padre=%%~dpF"
)

:: Generar identificador único
set "timestamp=%time::=_%"
set "timestamp=%timestamp: =0%"
set "id_unico=%random%%timestamp%"

:: Aplicar método de ocultamiento seleccionado
if "%METODO_OCULTAMIENTO%"=="1" (
    :: Método 1: Renombrar con prefijo
    set "nuevo_nombre=%PREFIJO_OCULTO%%nombre_original%"
    set "nueva_ruta=%ruta_padre%%nuevo_nombre%"
    
    ren "!ruta_objetivo!" "!nuevo_nombre!" >nul 2>&1
    if !errorlevel! neq 0 (
        call :mostrar_error "Error al renombrar el archivo"
        goto menu_principal
    )
    
    :: Aplicar atributos para ocultar aun mas
    attrib +h +s "!nueva_ruta!" >nul
    
    :: Registrar en la lista privada
    echo %id_unico%^|1^|!ruta_objetivo!^|!nueva_ruta!>> "%REGISTRO_PRIVADO%"
    
    call :mostrar_exito "Elemento ocultado con método de prefijo"
    
) else if "%METODO_OCULTAMIENTO%"=="2" (
    :: Método 2: Mover a carpeta segura y renombrar
    set "nombre_codificado=%id_unico%_!nombre_original!"
    set "ruta_segura=%USERPROFILE%\.archivos_seguros\!nombre_codificado!"
    
    move "!ruta_objetivo!" "!ruta_segura!" >nul 2>&1
    if !errorlevel! neq 0 (
        call :mostrar_error "Error al mover el archivo a ubicacion segura"
        goto menu_principal
    )
    
    :: Registrar en la lista privada
    echo %id_unico%^|2^|!ruta_objetivo!^|!ruta_segura!>> "%REGISTRO_PRIVADO%"
    
    call :mostrar_exito "Elemento movido a carpeta segura y ocultado"
    
) else if "%METODO_OCULTAMIENTO%"=="3" (
    :: Método 3: Cifrado XOR básico (experimental)
    set "nombre_cifrado=%id_unico%.enc"
    set "ruta_cifrada=%ruta_padre%%nombre_cifrado%"
    
    :: Simulación de cifrado (en un script real se usaría un módulo externo)
    copy "!ruta_objetivo!" "!ruta_cifrada!" >nul
    
    :: En realidad, aquí se llamaría a un programa de cifrado
    attrib +h +s "!ruta_cifrada!" >nul
    
    :: Eliminar original después de "cifrar"
    del "!ruta_objetivo!" >nul
    
    :: Registrar en la lista privada
    echo %id_unico%^|3^|!ruta_objetivo!^|!ruta_cifrada!>> "%REGISTRO_PRIVADO%"
    
    call :mostrar_exito "Elemento cifrado (simulacion) y ocultado"
)

timeout /t 2 >nul
goto menu_principal

:mostrar_personalizado
cls
color %COLOR_LIST%
echo [ RECUPERAR ELEMENTO OCULTADO PERSONALMENTE ]
echo.

:: Verificar si hay elementos ocultados
findstr /r /c:"." "%REGISTRO_PRIVADO%" >nul 2>&1
if %errorlevel% neq 0 (
    call :mostrar_error "No hay elementos ocultados personalmente"
    timeout /t 2 >nul
    goto menu_principal
)

:: Mostrar lista de elementos ocultados
echo Lista de elementos ocultados personalmente:
echo [ID] Ruta Original
echo ------------------------------------------------

set "contador=0"
for /f "tokens=1-4 delims=^|" %%a in ('type "%REGISTRO_PRIVADO%"') do (
    set /a contador+=1
    echo [!contador!] %%c
    set "id_!contador!=%%a"
    set "metodo_!contador!=%%b"
    set "orig_!contador!=%%c"
    set "nuevo_!contador!=%%d"
)

echo ------------------------------------------------
echo 0. Volver al menú principal
echo.
set /p "seleccion=Ingrese número de elemento a recuperar [1-%contador%] o 0: "

if "!seleccion!"=="0" goto menu_principal

:: Validar selección
if !seleccion! LSS 1 (
    call :mostrar_error "Seleccion invalida"
    timeout /t 2 >nul
    goto mostrar_personalizado
)
if !seleccion! GTR %contador% (
    call :mostrar_error "Selección invalida"
    timeout /t 2 >nul
    goto mostrar_personalizado
)

:: Recuperar información del elemento seleccionado
set "id_sel=!id_%seleccion%!"
set "metodo_sel=!metodo_%seleccion%!"
set "orig_sel=!orig_%seleccion%!"
set "nuevo_sel=!nuevo_%seleccion%!"

:: Aplicar metodo de recuperacion segun el método de ocultamiento
if "!metodo_sel!"=="1" (
    :: Método 1: Quitar prefijo
    for %%F in ("!nuevo_sel!") do (
        set "dir_padre=%%~dpF"
        set "nombre_actual=%%~nxF"
    )
    
    for %%F in ("!orig_sel!") do set "nombre_original=%%~nxF"
    
    ren "!nuevo_sel!" "!nombre_original!" >nul 2>&1
    if !errorlevel! neq 0 (
        call :mostrar_error "Error al restaurar el nombre original"
        timeout /t 2 >nul
        goto menu_principal
    )
    
    :: Quitar atributos de ocultamiento
    attrib -h -s "!orig_sel!" >nul
    
) else if "!metodo_sel!"=="2" (
    :: Método 2: Restaurar desde carpeta segura
    move "!nuevo_sel!" "!orig_sel!" >nul 2>&1
    if !errorlevel! neq 0 (
        call :mostrar_error "Error al restaurar desde carpeta segura"
        timeout /t 2 >nul
        goto menu_principal
    )
    
) else if "!metodo_sel!"=="3" (
    :: Método 3: Descifrar (simulado)
    copy "!nuevo_sel!" "!orig_sel!" >nul
    del "!nuevo_sel!" >nul
)

:: Actualizar lista privada (eliminar la entrada)
type nul > "%TEMP%\temp_registro.dat"
for /f "tokens=1-4 delims=^|" %%a in ('type "%REGISTRO_PRIVADO%"') do (
    if not "%%a"=="!id_sel!" echo %%a^|%%b^|%%c^|%%d>> "%TEMP%\temp_registro.dat"
)
move /y "%TEMP%\temp_registro.dat" "%REGISTRO_PRIVADO%" >nul
attrib +h +s "%REGISTRO_PRIVADO%" >nul

call :mostrar_exito "Elemento restaurado correctamente"
timeout /t 2 >nul
goto menu_principal

:ver_lista_personalizada
cls
color %COLOR_LIST%
echo [ LISTA DE ELEMENTOS OCULTADOS PERSONALMENTE ]
echo.

:: Verificar si hay elementos ocultados
findstr /r /c:"." "%REGISTRO_PRIVADO%" >nul 2>&1
if %errorlevel% neq 0 (
    echo No hay elementos ocultados personalmente.
    echo.
    echo Presione cualquier tecla para volver al menú principal...
    pause >nul
    goto menu_principal
)

:: Mostrar lista detallada
echo ID^|Método^|Ruta Original^|Estado Actual
echo ------------------------------------------------

for /f "tokens=1-4 delims=^|" %%a in ('type "%REGISTRO_PRIVADO%"') do (
    set "estado=ACTIVO"
    if not exist "%%d" set "estado=ERROR: NO ENCONTRADO"
    
    set "metodo_desc=Desconocido"
    if "%%b"=="1" set "metodo_desc=Prefijo"
    if "%%b"=="2" set "metodo_desc=Carpeta Segura"
    if "%%b"=="3" set "metodo_desc=Cifrado"
    
    echo %%a^|!metodo_desc!^|%%c^|!estado!
)

echo ------------------------------------------------
echo.
echo Presione cualquier tecla para volver al menu principal...
pause >nul
goto menu_principal

:config_metodo_ocultamiento
cls
color %COLOR_INPUT%
echo [ CONFIGURAR MÉTODO DE OCULTAMIENTO ]
echo.
echo Método actual: %METODO_OCULTAMIENTO%
echo.
echo Métodos disponibles:
echo 1. Añadir prefijo personalizado
echo 2. Renombrar + mover a carpeta segura
echo 3. Cifrado XOR básico (experimental)
echo.
echo 0. Volver sin cambios
echo.
set /p "nuevo_metodo=Seleccione nuevo metodo [0-3]: "

if "%nuevo_metodo%"=="0" goto menu_principal
if "%nuevo_metodo%"=="1" set "METODO_OCULTAMIENTO=1" & goto confirmar_metodo
if "%nuevo_metodo%"=="2" set "METODO_OCULTAMIENTO=2" & goto confirmar_metodo
if "%nuevo_metodo%"=="3" set "METODO_OCULTAMIENTO=3" & goto confirmar_metodo

call :mostrar_error "Selección inválida"
timeout /t 2 >nul
goto config_metodo_ocultamiento

:confirmar_metodo
if "%METODO_OCULTAMIENTO%"=="1" (
    echo.
    echo Ha seleccionado el metodo de prefijo personalizado.
    echo Prefijo actual: %PREFIJO_OCULTO%
    echo.
    set /p "nuevo_prefijo=Ingrese nuevo prefijo o presione ENTER para mantener el actual: "
    if not "!nuevo_prefijo!"=="" set "PREFIJO_OCULTO=!nuevo_prefijo!"
)

call :mostrar_exito "Metodo de ocultamiento actualizado"
timeout /t 2 >nul
goto menu_principal

::: MÓDULO CORE - EXPLORADOR INTERACTIVO :::
:explorador_ocultos
cls
color %COLOR_INPUT%
echo [ EXPLORADOR DE ARCHIVOS OCULTOS - TIEMPO REAL ]
echo Ingrese ruta base (ej: C:\Users\Public):
set /p "ruta=>> "
call :validar_ruta "!ruta!" || goto menu_principal

:relistado
cls
color %COLOR_LIST%
echo Directorio actual: !ruta!
echo [0] Volver  [1] Subir nivel  [2] Refrescar
echo ------------------------------------------------

set "counter=0"
for /f "delims=" %%a in ('dir /a:h /b "!ruta!" 2^>nul') do (
    set /a counter+=1
    echo [!counter!] %%~a
    set "item_!counter!=%%~a"
)

if %counter% equ 0 (
    call :mostrar_error "No hay elementos ocultos"
    goto menu_principal
)

echo ------------------------------------------------
choice /C 012 /N /M "Seleccione archivo [1-!counter!] o accion [0-2]: "
set "respuesta=%errorlevel%"

if %respuesta% equ 1 goto menu_principal
if %respuesta% equ 2 (
    set "ruta=!ruta!\.."
    goto relistado
)
if %respuesta% equ 3 goto relistado

:: Procesar selección de elemento
set /a selected=%respuesta%-3
if !selected! gtr !counter! (
    call :mostrar_error "Seleccion invalida"
    goto relistado
)

for %%i in (!selected!) do set "target=!item_%%i!"

:gestion_elemento
cls
color %COLOR_INPUT%
echo [!target!]
echo 1. Mostrar permanentemente
echo 2. Ocultar nuevamente
echo 3. Ver contenido (si es carpeta)
echo 4. Volver
choice /C 1234 /N /M "Accion: "

if %errorlevel% equ 1 (
    attrib -h -s "!ruta!\!target!" >nul
    call :mostrar_exito "Elemento visible en Explorer"
)
if %errorlevel% equ 2 (
    attrib +h +s "!ruta!\!target!" >nul
    call :mostrar_exito "Elemento ocultado"
)
if %errorlevel% equ 3 (
    if exist "!ruta!\!target!\" (
        set "ruta=!ruta!\!target!"
        goto relistado
    ) else (
        call :mostrar_error "No es una carpeta"
    )
)
if %errorlevel% equ 4 goto relistado

::: FUNCIONES REUTILIZABLES :::
:validar_ruta
if not exist "%~1\" (
    call :mostrar_error "Ruta no valida: %~1"
    exit /b 1
)
exit /b 0

:modificar_registro  <Clave> <Valor> <Mensaje> [Clave2] [Valor2]
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v %~1 /t REG_DWORD /d %~2 /f >nul
if not "%~4"=="" reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v %~4 /t REG_DWORD /d %~5 /f >nul
taskkill /f /im explorer.exe >nul & start explorer.exe >nul
call :mostrar_exito "%~3"
exit /b 0

:toggle_ocultos
for /f "tokens=3" %%v in ('reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden') do set /a new_state=1-%%v
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /d !new_state! /f >nul
taskkill /f /im explorer.exe >nul & start explorer.exe >nul
call :mostrar_exito "Visibilidad global actualizada"
exit /b 0

:gestion_elementos  <Atributo1> <Atributo2> <Mensaje>
cls
color %COLOR_INPUT%
echo Ingrese ruta completa (ej: "C:\Data\Confidencial"):
set /p "ruta=>> "
call :validar_ruta "!ruta!" || exit /b 1
attrib %~1 %~2 "!ruta!" >nul
call :mostrar_exito "%~3"
timeout /t 2 >nul
exit /b 0

:mostrar_exito
color %COLOR_SUCCESS%
echo [✔] %~1
exit /b 0

:mostrar_error
color %COLOR_ERROR%
echo [✘] %~1
exit /b 1

endlocal