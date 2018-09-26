#' ---
#' output:
#'   revealjs::revealjs_presentation:
#'     theme: simple
#'     slide_level: 2
#'     highlight: pygments
#'     center: false
#'     self_contained: true
#'     css: "../css/styles.css"
#'     reveal_options:
#'       slideNumber: true
#'       previewLinks: false
#'       transition: 0
#'       background_transition: 0
#' ---
#' 
## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = FALSE, dev="svg")

#' 
## ----include=FALSE-------------------------------------------------------
if(!require("tidyverse")) {
  install.packages("tidyverse", repos="https://cloud.r-project.org/",
         quiet=TRUE, type="binary")
  library("tidyverse")
}
if(!require("kableExtra")) {
  install.packages("kableExtra", repos="https://cloud.r-project.org/",
         quiet=TRUE, type="binary")
  library("kableExtra")
}

#' 
#' ##
#' 
#' <img src="../images/IQSlogo.png" style="border-style:none;box-shadow:none;
#' position:absolute;margin:0;top:20px;left:20px;max-width:200px;height:auto;" />
#' 
#' <div style="font-size:1.5em;font-weight:700;margin-top:200px;">Control estadístico de procesos</div>
#' <div style="font-size:1.4em;font-weight:500;color:#333333;">Introducción a la calidad</div>
#' <div style="font-size:1.2em;margin-top:40px;color:#333333;">Jordi Cuadros, Lucinio González</div>
#' <div style="margin-top:80px;color:#333333;">Septiembre de 2018</div>
#' 
#' 
#' # Negocios y calidad
#' 
#' ## ¿Qué es un negocio?
#' Un **negocio** es un proceso **repetitivo** que crea **riqueza**.
#' 
#' ![](im001.png){style=width:80%;left-margin:-40%;}
#' 
#' <p class="bibref">Kaufman, J. (2010). *The personal MBA: Master the art of business*. Penguin.</p>
#' 
#' ----
#' 
#' **Un negocio es un conjunto de procesos que pueden repetirse de manera fiable para conseguir un resultado concreto y generar riqueza.**
#' 
#' - *Si no es capaz de describir su trabajo como un proceso, no ha entendido en qué consiste.* (W.E. Deming)
#' - *Conseguir la satisfacción del cliente es la mejor estrategia de negocios posible* (Michael Leboeuf)
#' - *Siempre he creído que para un negocio o un servicio prosperen, tienen que ofrecer calidad. Un producto o un servicio excelente son su mejor punto de venta.* (Victor Kiam)
#' 
#' *RAE: Conjunto de las fases sucesivas de un fenómeno natural o de una operación artificial.*
#' 
#' 
#' ## Calidad
#' 
#' Grado en el que un conjunto de características inherentes a un objeto (producto, servicio, proceso, persona, organización, sistema o recurso) cumple con los requisitos. (ISO 9000)
#' 
#' ¿Quién decide los requisitos?   **El cliente**
#' 
#' **Hay un único jefe: el cliente.**
#' 
#' *Es capaz de despedir a todo el personal de la empresa, desde el más alto cargo hasta el último de la fila, solo con gastarse el dinero en otra parte.* (Sam Walton, fundador de Walmart)
#' 
#' 
#' ## Los negocios de éxito…
#' 
#' 1.  crean o nos ofrecen algo de **valor**, 
#' 2.  que los demás **queremos** o **necesitamos**
#' 3.  a un **precio** que estamos dispuestos a pagar,
#' 4.  porque satisface nuestras necesidades y **expectativas** como compradores 
#' 5.  y genera suficientes **ingresos** a la empresa de modo que a los propietarios les resulte rentable seguir operando.
#' 
#' *El **precio** es lo que se paga, el **valor** es lo que se obtiene* (Warren Buffet)
#' 
#' 
#' ## Productos de valor
#' 
#' - Crear un artículo tangible que la gente desee.
#' - Producir ese artículo con el menor coste posible y con un nivel de **calidad aceptable**.
#' - Vender tantas unidades como sea posible al máximo precio que el mercado permita.
#' - Conservar un inventario de productos acabados para poder satisfacer los pedidos que vayan llegando.
#' 
#' 
#' ## Servicios de valor
#' 
#' - Tener empleados que dominen una técnica o tengan una capacidad para hacer algo que los demás necesiten pero que no puedan o no quieran hacer, en el presente o en el futuro.
#' - Ofrecer un servicio de **gran calidad**.
#' - Atraer y retener clientes dispuestos a pagar.
#' - Los servicios dependen de la inversión de tiempo y energía de la persona que facilita el servicio y estos dos recursos son finitos.
#' 
#' Es fundamental cobrar el **precio adecuado**. 
#' 
#' 
#' ## Historia de la calidad
#' 
#' ### Etapa artesanal
#' 
#' **Hacer las cosas bien** independientemente del coste o esfuerzo necesario para ello.
#' 
#' Finalidades:
#' 
#' - Satisfacer al cliente.
#' - Satisfacer al artesano, por el trabajo bien hecho
#' - Crear un producto único.
#' 
#' ----
#' 
#' ### Revolución Industrial
#' 
#' **Hacer muchas cosas** no importando que sean de calidad (Se identifica producción con calidad).
#' 
#' Finalidades:
#' 
#' - Satisfacer una gran demanda de bienes.
#' - Obtener beneficios.
#' 
#' ----
#' 
#' ### Segunda Guerra Mundial
#' 
#' **Asegurar la eficacia del armamento** sin importar el costo, con la mayor y más **rápida producción** (eficacia + plazo = calidad)
#' 
#' Finalidad:
#' 
#' - Garantizar la disponibilidad de un armamento eficaz en la cantidad y el momento preciso.
#' 
#' ----
#' 
#' ### Posguerra -- Japón
#' 
#' **Hacer las cosas bien a la primera**
#' 
#' Finalidades:
#' 
#' - Minimizar costes
#' - Satisfacer al cliente
#' - Ser competitivo
#' 
#' ----
#' 
#' ### Posguerra -- Resto del mundo
#' 
#' Producir, **cuanto más mejor**
#' 
#' Finalidad: 
#' 
#' - Satisfacer la gran demanda de bienes causada por la guerra
#' 
#' ----
#' 
#' ### Etapa del control de calidad
#' 
#' Técnicas de **inspección** en la producción para **evitar la salida** de bienes defectuosos
#' 
#' Finalidades:
#' 
#' - Satisfacer las necesidades técnicas del producto
#' 
#' ----
#' 
#' ### Etapa del aseguramiento (garantía) de la calidad
#' 
#' Sistemas y **procedimientos** de la organización para evitar que se produzcan bienes defectuosos
#' 
#' Finalidades:
#' 
#' - Satisfacer al cliente
#' - Prevenir errores
#' - Reducir costes
#' - Ser competitivo
#' 
#' ----
#' 
#' ### Calidad total
#' 
#' Teoría de la **administración** empresarial centrada en la permanente **satisfacción de las expectativas** del cliente
#' 
#' Finalidades:
#' 
#' - Satisfacer tanto al cliente externo como interno
#' - Ser competitivo
#' - Mejora contínua
#' 
#' 
#' # Calidad total (TQM, Total Quality Management)
#' 
#' ##  Definición
#' 
#' Es una **estrategia de gestión** a través de la cual la empresa satisface las necesidades y expectativas
#' 
#' - de sus clientes,
#' - de sus empleados,
#' - de los accionistas, y
#' - de toda la sociedad en general,
#' 
#' utilizando los recursos de que dispone:
#' 
#' - personas,
#' - materiales,
#' - tecnología,
#' - sistemas de producción, etc.
#' 
#' 
#' ----
#' 
#' <p>&nbsp;</p>
#' <p>&nbsp;</p>
#' 
#' 
## ---- echo = FALSE, results = 'asis'-------------------------------------
df <- data.frame(c("QUÉ", "CÓMO", "MÉTODO", "DÓNDE", "QUIÉN", "CUÁNDO" ),
                 c("Satisfacción de clientes externos e internos", "Utilización eficiente de reursos", "Mejora contínua", "Aplicación de todos los procesos y actividades", "Participación de todas las personas de la empresa", "Siempre"))
tb <- kable_styling(kable(df))
gsub("<thead>.*</thead>", "", tb)


#' 
#' ----
#' 
#' La calidad total alcanza toda la empresa.
#' 
#' ![](im002.png)
#' 
#' Implica una necesidad de una calidad contrastada a través de
#' 
#' - Sistemas de gestión de la calidad (SGC)
#' - Normas (*Standards*)
#' - Certificaciones
#' 
#' 
#' ## Sistema de gestión de la calidad
#' 
#' Un sistema de gestión de la calidad es un método para conseguir el objetivo de que el producto o servicio que se ofrece siempre satisfaga las necesidades del cliente (se considere de calidad). 
#' 
#' ----
#' 
#' Para ello se hace valer de todos los recursos que dispone la empresa. Su estructura y funcionamiento depende de 
#' 
#' - La organización de la que se dispone.
#' - La naturaleza propia de la actividad a la que se dedica la empresa.
#' - Medios con los se cuenta tanto materiales como humanos y económicos.
#' - Tendencias del mercado.
#' - Exigencias de los clientes.
#' 
#' 
#' ## Normas
#' 
#' Una *norma* es un documento técnico de aplicación voluntaria, fruto del consenso, basado en los resultados de la experiencia y del desarrollo tecnológico y aprobado por un organismo de normalización reconocido.
#' 
#' - ISO (International Organization for Standardization)
#' - AENOR
#' - ASTM
#' 
#' 
#' ## Normas ISO 9000
#' 
#' ISO 9000 es un conjunto de normas sobre **calidad y gestión de calidad**.
#' 
#' Se pueden aplicar en cualquier tipo de organización o actividad orientada a la producción de bienes o servicios. 
#' 
#' Las normas recogen tanto el contenido mínimo como las guías y herramientas específicas de implantación como los métodos de auditoría.
#' 
#' ----
#' 
#' ### Ventajas
#' 
#' - Estandarizar las actividades del personal de la organización por medio de la documentación.
#' - Incrementar la satisfacción del cliente al asegurar la calidad de manera consistente.
#' - Medir y monitorear el desempeño de los procesos.
#' - Incrementar la eficacia y/o eficiencia en el logro de sus objetivos.
#' - Mejorar continuamente en los procesos, productos, eficacia, entre otros.
#' - Reducir las incidencias negativas.
#' - Mantener la calidad.
#' 
#' ----
#' 
#' ### Desventajas
#' 
#' - Los esfuerzos y costos para preparar la documentación e implantación de los sistemas.
#' 
#' 
#' ## ISO 9001:2015
#' 
#' La principal norma de la familia es la **ISO 9001:2015: Sistemas de Gestión de la Calidad - Requisitos**.
#' 
#' ### Siete principios de gestión de la calidad
#' 1. **Enfoque al cliente**. Debemos siempre comprender sus necesidades actuales y futuras, satisfacer sus requisitos y esforzarse por exceder sus expectativas.
#' 2. **Liderazgo**. Debemos crear y mantener un ambiente interno, en el cual el personal pueda llegar a involucrarse totalmente con el logro de los objetivos de la organización. (Dirigir, Delegar, Desarrollar)
#' 
#' ----
#' 
#' 3. **Compromiso y competencias de las personas**. El total compromiso del personal permite que sus habilidades sean usadas para el beneficio de la organización.
#' 4. **Enfoque basado en procesos**. Un resultado deseado se alcanza eficientemente cuando las actividades y los recursos relacionados se administran como un proceso.
#' 5. **Mejora**. La mejora continua del desempeño global de la organización debería ser un objetivo permanente de esta.
#' 6. **Toma de decisiones informadas**. Las decisiones eficaces se basan en hechos y **DATOS** para tomar dichas decisiones.
#' 7. **Gestión de las relaciones**. Una relación de beneficio mutuo aumenta la capacidad de ambos para crear valor.
#' 
#' https://www.iso.org/publication/PUB100080.html
#' 
#' 
#' ## Certificación acreditada
#' 
#' Los procesos de certificación acreditada aportan la confianza de que una organización cumple con los requesitos de una norma.
#' 
#' En el caso de la norma ISO 9001, se certifica:
#' 
#' - que la organización tiene un sistema de gestión de calidad que cumple los requisitos aplicables de la norma.
#' - la capacidad de la organización para, consecuentemente, suministrar productos que cumplan los requisitos de los clientes y los requisitos legales y reglamentarios.
#' 
#' ----
#' 
#' Esto no significa: 
#' 
#' - que se asegure que la organización siempre consiga el 100% de productos conformes.
#' - no implica que la organización esté suministrando un producto superior o que el producto propiamente dicho esté certificado.
#' 
#' 
#' # Six Sigma
#' 
#' ## Six Sigma
#' 
#' Es un conjunto de metodologías para resolver problemas de forma rigurosa a partir de datos, usando para ello herramientas y métodos estadísticos.
#' 
#' - Fue desarrollada por Bill Smith & Mikel Harry mientras trabajaban Motorola in 1986. "Six Sigma" se registró como marca en 1991.
#' - En 2005 Motorola estimó en 17 mil millones de dólares los ahorros conseguidos con Six Sigma.
#' - Persigue un nivel de calidad de 6 $\sigma$, que equivale a no más de 3,4 defectos por millón de oportunidades.
#' 
#' ----
#' 
#' <p class="bibref">Rudisill, F., & Druley, S. (2004). Which Six Sigma Metric Should I Use?. *Quality Progress*, 37(3), 104.<p>
#' 
#' ![](im004.png)
#' 
#' ## Six Sigma -- DMAIC
#' 
#' ![](im003.png){style=width:80%;margin-left:-40%;}
#' 
#' <p class="bibref">http://www.sixsigma-institute.org/What_Is_Six_Sigma.php<p>
#' 
#' 
#' ## Six Sigma -- Roles principales
#' 
#' <p>&nbsp;</p>
#' <p>&nbsp;</p>
#' 
## ---- echo = FALSE, results = 'asis'-------------------------------------
df <- data.frame(c("YELLOW BELT", "GREEN BELT", "BLACK BELT"),
                 c("Miembros de proyecto Six Sigma. Implementa y da soporte en los proyectos.",
                   "Apoya en la recogida y análisis de datos en proyecto Six Sigma. Puede liderar pequeños proyectos.",
                   "Lidera proyectos de resolución de problemas en la metodología Six Sigma. Participa en la formación de los equipos de proyecto."))
tb <- kable_styling(kable(df))
gsub("<thead>.*</thead>", "", tb)


#' 
#' <p class="bibref">http://asq.org/learn-about-quality/six-sigma/overview/belts-executives-champions.html<p>
#' 
#' ----
#' 
#' <p class="bibref">Hoerl, R. W., (2001). Six Sigma black belts: What do they need to know? *Journal of Quality Technology*, 33(4), 399.<p>
#' 
#' ![](im005.png)
#' 
#' ----
#' 
#' ![](im006.png)
#' 
#' ----
#' 
#' ![](im007.png)
#' 
#' ----
#' 
#' ![](im008.png)
#' 
#' 
#' ## Estadística para la mejora de la calidad
#' 
#' 1. Herramientas para la gestión de la calidad 
#' 2. **Control estadístico de procesos**
#' 3. **Especificaciones y capacidad de un proceso**
#' 4. **Muestreo de aceptación**
#' 5. **Diseño y análisis de experimentos**
