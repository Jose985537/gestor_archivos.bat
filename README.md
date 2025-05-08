<p align="center">
  <a href="https://skillicons.dev">
    <img src="https://skillicons.dev/icons?i=windows,powershell" />
  </a>
</p>

# Gestor Avanzado de Archivos v0.1
## ¡Tu Espacio Digital Organizado y Privado, a Tu Manera!

**¿Sientes que los métodos de organización de archivos de Windows son un poco... caóticos o fáciles de olvidar?** ¿Necesitas un lugar *realmente* privado para guardar ciertos documentos o herramientas digitales sin que estén a la vista o se mezclen con todo lo demás?

Este Gestor Avanzado de Archivos v5.0 está **diseñado específicamente para darte más control y una capa extra de privacidad** sobre tus archivos y carpetas importantes. No se trata solo de hacer clic en "ocultar"; es un sistema donde **tú defines y gestionas activamente** lo que quieres mantener fuera del alcance casual y dónde encontrarlo fácilmente después.

---

### **El Problema Solucionado (¿Por Qué Necesitas Esto?)**

El sistema estándar de "ocultar" de Windows (usando el **atributo de archivo `+H`**) puede ser insuficiente:
* Los archivos siguen siendo visibles si cambias una simple configuración de la carpeta.
* Es fácil olvidar dónde pusiste algo "oculto".
* No ofrece diferentes niveles o métodos de ocultamiento.

Este Gestor va más allá. Te da un sistema centralizado para **saber exactamente qué está oculto y cómo**, facilitando la recuperación y añadiendo una capa de **seguridad por oscuridad** más efectiva.

---

### **Propósito y Contexto Técnico**

El objetivo principal es ofrecer una herramienta **fiable y controlada** para la **gestión de la visibilidad de archivos** fuera de los mecanismos de interfaz gráfica de usuario (GUI) más comunes de Windows.

Técnicamente, esta herramienta utiliza **scripting de procesamiento por lotes (`.bat`)** para interactuar directamente con el **sistema de archivos NTFS** de Windows a un nivel más bajo. En lugar de depender únicamente del atributo `+H`, implementa lógicas personalizadas (prefijos, movimientos a ubicaciones ofuscadas, renombrado) que son más resistentes a la simple activación de "ver archivos ocultos" en el Explorador de Archivos. La "lista centralizada" actúa como un **registro privado** (probablemente un archivo de texto o una estructura de carpetas específica) que almacena las **rutas de archivo** originales y los métodos de ocultamiento aplicados, permitiéndote rastrear y restaurar tus elementos sin tener que recordar manualmente dónde los pusiste o cómo los renombraste. Es una interfaz de **línea de comandos (CLI)** simplificada que ejecuta operaciones complejas del sistema de archivos por ti.

---

### **¿Quién Puede Implementarlo y Dónde?**

Esta herramienta es increíblemente útil en diversos contextos, especialmente cuando necesitas **segmentar y proteger información digital sensible** o simplemente reducir el desorden visual en tu espacio de trabajo digital.

**En el Ámbito Laboral (Uso Profesional):**
* **Técnicos de Sistemas/Administradores:** Oculta archivos de **configuración crítica** (ej. archivos `.conf`, `.ini`), **scripts de automatización** (ej. `.ps1`, `.bat`, `.sh`), **credenciales** (¡úsalo con extrema precaución y conocimiento de seguridad!) o **herramientas administrativas** que no deben ser accesibles o visibles para usuarios estándar o personal con menos permisos. Ayuda a mantener un **directorio de trabajo limpio** mientras tienes acceso rápido a utilidades importantes.
* **Profesionales de TI:** Protege **información sensible** de proyectos, **documentación interna** confidencial, o **prototipos de código** a los que solo tú o un equipo reducido debéis acceder. Ideal para entornos donde compartes estación de trabajo o pantalla.
* **Desarrolladores/DevOps:** Oculta **claves SSH**, archivos `.env` con variables de entorno sensibles, **configuraciones de despliegue** o **scripts de bases de datos** temporales.

**En el Ámbito Personal (Uso Doméstico):**
* **Gestión de Documentos:** Mantén tus **documentos financieros** (declaraciones de impuestos, extractos bancarios), **documentos legales**, o **información médica** en un lugar seguro y fuera de la vista general de otros usuarios del ordenador.
* **Archivos Multimedia Privados:** Oculta colecciones de **fotos o videos personales** a los que prefieres acceder de forma controlada.
* **Proyectos Personales/Hobbies:** Guarda **ideas, notas o archivos** relacionados con proyectos personales que quieres mantener organizados y separados de tu trabajo o archivos generales.
* **Limpieza Digital:** Reduce el **desorden visual** en tus carpetas más usadas moviendo archivos a los que no accedes a diario pero que necesitas conservar a un lugar "oculto" y fácil de recuperar a través de la lista centralizada.

---

### **Ventajas Clave (¡Lo Que la Hace Diferente!)**

* **Control Total a Tu Alcance:** Tú decides qué se oculta y *cómo*. La lista centralizada te da una vista clara de todo.
* **Métodos Robustos:** No depende solo de un simple *flag* como el atributo `+H`. Usa técnicas que requieren el Gestor para ser deshechas.
* **Lista de Seguimiento Integrada:** Nunca más olvidarás dónde guardaste ese archivo "oculto". La herramienta lo registra y te muestra dónde está.
* **Flexibilidad:** Elige el método de ocultamiento que mejor se adapte a la sensibilidad del archivo y tu necesidad de acceso.

---

### **Instalación (¡Paso a Paso Simple!)**

1.  **Descarga:** Obtén el archivo `gestor_archivos.bat`.
2.  **Ubica:** Cópialo a una ubicación que te resulte fácil de recordar (ej. `C:\Herramientas\`).
3.  **Ejecuta como Administrador:** **Click derecho** sobre el archivo `gestor_archivos.bat` y selecciona "**Ejecutar como administrador**". Esto es necesario para que el script pueda manipular archivos del sistema y acceder a ciertas ubicaciones.

---

### **Características Principales (¡Qué Puedes Hacer!)**

1.  **Manejo Básico (Sistema Estándar Windows):**
    * Controlar la visibilidad global de archivos ocultos.
    * Activar/desactivar modos de seguridad o desarrollador (relacionados con la visibilidad de archivos).
    * Ocultar/mostrar usando los atributos estándar de Windows.
2.  **Manejo Avanzado (Sistema Personalizado):**
    * **Ocultar con Método Personalizado:** Aplica una de las técnicas de ocultamiento más robustas.
    * **Recuperar Elementos Ocultos:** Utiliza la lista centralizada para encontrar y restaurar tus archivos.
    * **Ver Lista Centralizada:** Consulta todos los elementos que has ocultado con el sistema personalizado.
    * **Configurar Métodos:** Elige el método de ocultamiento por defecto.

---

### **Métodos de Ocultamiento Explicados**

* **Prefijo Personalizado:** **Renombra** el archivo añadiendo un prefijo que tú defines (ej. de `documento.txt` a `_OCULTO_documento.txt`). Simple para ocultar a simple vista sin mover el archivo.
* **Carpeta Segura:** **Mueve** el archivo a una ubicación específica, a menudo oculta o de difícil acceso, y **renombra** el archivo con un código o nombre ilegible. Ideal para archivar y proteger archivos importantes pero que no usas constantemente.
* **Cifrado Básico (Experimental):** Realiza una **modificación simple en los datos del archivo** que lo vuelve ilegible sin pasar por el proceso de "descifrado" del Gestor. **Importante: ¡Esto NO es criptografía fuerte!** Es una capa extra de ofuscación para privacidad básica.

---

### **Guía Rápida de Uso (¡Ve Directo al Grano!)**

Aquí están los pasos clave para las acciones más comunes:

* **Para Ocultar un Archivo/Carpeta:**
    1.  **Ejecuta** el programa (`gestor_archivos.bat` como administrador).
    2.  Selecciona la opción `7` (`[NUEVO] Ocultar elemento con método personalizado`).
    3.  **Ingresa la ruta completa** del archivo o carpeta que quieres ocultar (ej. `C:\Usuarios\TuUsuario\Documentos\InformeConfidencial.docx`).
    4.  El sistema aplicará el método configurado y **lo registrará automáticamente** en tu lista privada. ¡Listo!
* **Para Recuperar un Archivo/Carpeta Oculto:**
    1.  **Ejecuta** el programa (`gestor_archivos.bat` como administrador).
    2.  Selecciona la opción `8` (`[NUEVO] Mostrar elemento ocultado personalmente`).
    3.  Verás la lista de elementos ocultos con un número asignado a cada uno. **Elige el número** del elemento que quieres recuperar e ingrésalo.
    4.  El sistema **restaurará** el archivo a su ubicación y nombre originales. ¡Hecho!
* **Para Ver Tu Lista de Archivos Ocultos:**
    1.  **Ejecuta** el programa (`gestor_archivos.bat` como administrador).
    2.  Selecciona la opción `9` (`[NUEVO] Ver lista de elementos ocultados personalmente`).
    3.  Revisa el listado completo con detalles sobre cada elemento oculto y su método.

---

### **Advertencias Importantes (¡Por Favor, Lee!)**

* **NO es Cifrado Fuerte:** El método de "Cifrado Básico" es solo para **privacidad de bajo nivel**. No lo uses para proteger datos contra atacantes decididos o acceso no autorizado profesional. Es más una **ofuscación** que criptografía real.
* **Capa Extra, No Invulnerabilidad:** Esta herramienta añade una barrera para el acceso casual o accidental, pero no protege contra malware, accesos rootkit o usuarios con conocimientos avanzados y permisos elevados.
* **¡Haz Copias de Seguridad!** Aunque el sistema está diseñado para ser seguro, siempre es una buena práctica tener copias de seguridad de cualquier archivo importante antes de usar herramientas que modifican su estado o ubicación.

---

### **Compatibilidad Técnica**

* **Sistemas Operativos:** Diseñado para Windows 7, 8, 10 y 11.
* **Permisos:** Requiere **permisos de administrador** para funcionar correctamente, ya que modifica propiedades del sistema de archivos y accede a ubicaciones restringidas.
* **Sistema de Archivos:** Compatible con **NTFS**, el sistema de archivos estándar de Windows.
* **Fundamento:** Basado en scripting de procesamiento por lotes (`.bat`), ejecutado a través de la **línea de comandos de Windows (cmd.exe)**.

---

Este Gestor Avanzado de Archivos te ofrece una forma **estructurada y fiable** de tomar el control de la privacidad y organización de tus archivos digitales más importantes, tanto en tu trabajo técnico como en tu vida personal. ¡Experimenta la tranquilidad de saber exactamente dónde está todo y que está justo donde tú lo pusiste!
