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
if(!require("nortest")) {
  install.packages("nortest", repos="https://cloud.r-project.org/",
         quiet=TRUE, type="binary")
  library("normtest")
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
#' <div style="font-size:1.4em;font-weight:500;color:#333333;">Análisis de los sistemas de medida (MSA)</div>
#' <div style="font-size:1.2em;margin-top:40px;color:#333333;">Jordi Cuadros, Lucinio González</div>
#' <div style="margin-top:80px;color:#333333;">Octubre de 2018</div>
#' 
#' 
#' # Análisis de los sistemas de medida
#' 
#' ## El problema de la medida
#' 
#' Tanto el estudio de la capacidad/rendimiento (control de producto) como el del control del proceso se basan en la variabilidad de los valores obtenidos en determinadas variables (o atributos). Sin embargo, sin un sistema de medida adecuado y contrastado, es imposible saber si la variabilidad observada corresponde al producto o proceso, o bien al sistema de medida.
#' 
#' $$\\\sigma^2_{obs} = \sigma^2_{proceso} + \sigma^2_{medicion}$$
#' 
#' ----
#' 
#' ![](img001.png){style=width:80%;margin-left:-40%;}
#' 
#' <p class="bibref">AIAG (Automotive Industry Action Group)(2010). *Measurement Systems Analysis. Reference Manual*. </p>
#' 
#' 
#' ## *Measurement Systems Analysis*
#' 
#' El análisis de los sistemas de medida (MSA) corresponde al conjunto de técnicas y métodos estadísticos destinados a estudiar la variabilidad producida por las mediciones.
#' 
#' Incluye el estudio de los siguientos aspectos de la medición:
#' 
#' - discriminación
#' - estabilidad
#' - sesgo o exactitud
#' - linealidad
#' - precisión (repetibilidad y reproducibilidad)
#' 
#' ----
#' 
#' Se presentan en este apartado algunos métodos para estudiar estos aspectos de la variabilidad de las medidas, para el caso de variables en el caso de medidas replicables.
#' 
#' Para el caso de atributos o de medidas no replicables, puede encontrarse información en:
#' 
#' - <span class="bibref">AIAG (Automotive Industry Action Group)(2010). *Measurement Systems Analysis. Reference Manual*. </span>
#' - <span class="bibref">http://www.asq-1302.org/wp-content/uploads/2011/08/Attribute-Gage-RR-Ridgway.pdf</span>
#' 
#' 
#' # Discriminación
#' 
#' ## ¿Qué significa?
#' 
#' La discriminación, o resolución de un sistema de medida, es el mínimo cambio de valor de la propiedad que el sistema puede detectar (o dar como resultado de forma fidedigna).
#' 
#' En un instrumento graduado, a menudo se considera la mitad del paso (si este es fácil de apreciar).
#' 
#' Un sistema de medida es adecuado si permite determinar un número suficiente de categorías (valores distintos) en el rango de trabajo (tolerancia, LSE - LIE, o variablidad del proceso, LSC- LIC).
#' 
#' 
#' ## Procedimiento
#' 
#' ### A priori
#' 
#' El sistema de medida deben permitir establecer 10 categorías de distintas. El error de medida esperado debe ser inferior o igual a la décima parte del rango de trabajo.
#' 
#' 
#' ### A posteriori
#' 
#' La discriminación del sistema de medida se puede calcular a partir de los estudios de precisión (*Gauge/Gage R&R*) como
#' 
#' $$\\ndc = \sqrt{2} \  {\sigma_{total} \over \sigma_{GRR}}$$
#' 
#' ----
#' 
#' ![](img002.png){style=width:70%;margin-left:-35%;}
#' 
#' <p class="bibref">AIAG (Automotive Industry Action Group)(2010). *Measurement Systems Analysis. Reference Manual*. </p>
#' 
#' 
#' ## Ejemplo
#' 
#' En una planta donde se fabrican agujas de máquinas de coser se ha decidido establecer un sistema de control automático del grosor de las mismas. 
#' 
#' Si las especificaciones para el grosor de la aguja indican que el diámetro debe ser de entre 0,655 y 0,665 mm, y la capacidad del proceso es de 1,45, determina si un instrumento cuya tolerancia sea de 10 &mu;m es adecuado para el sistema de medida. 
#' 
#' 
#' # Estabilidad y exactitud
#' 
#' ## ¿Qué significan?
#' La *estabilidad* de una medida indica la independencia de su valor con el tiempo. Es sistema de medición es estable si, dada una pieza de referencia, el resultado de su media está control estadístico.
#' 
#' La *exactitud* se refiere a la proximidad del valor observado como resultado de una medición, con el valor real de la propiedad estudiada.
#' 
#' La estabilidad es una condición necesaria para la exactitud.
#' 
#' 
#' ## Procedimiento para la determinación de la estabilidad
#' 
#' 1. Se obtiene un individuo (muestra), a ser posible de valor certificado/conocido en la propiedad a determinar, de la zona central del rango de trabajo.
#' 2. De forma periódica, se determina 3-5 veces la propiedad de interés con el sistema de medida. Estas determinaciones deben incluir toda la variabilidad de las condiciones en las que el instrumento es usado.
#' 3. Se analizan estos valores mediante un gráfico de control de Shewhart (Xbarra-R).
#' 
#' Puede ser adecuado repetir el estudio en los extremos superior e inferior del rango de trabajo.
#' 
#' 
#' ## Procedimiento para la determinación de la exactitud
#' 
#' 1. Comprobada la estabilidad del sistema de medida, se toma un individuo (muestra) de la zona central del rango de trabajo, cuyo valor en la propiedad esté certificado/sea conocido (trazable a una referencia estándar), $x_{referencia}$.
#' 2. Se determina el valor de la propiedad (*n* veces, al menos 10) por parte de un único operador.
#' 3. Se calcula el sesgo para cada uno de los resultados
#' 
#' $$\\d_i = x_i - x_{referencia}$$
#' 
#' 4. Se representan estos valores en un histograma o un diagrama de caja para descartar la presencia de puntos anómalos. Si no hay, se prosigue el estudio.
#' 
#' ----
#' 
#' 5. Se determina el sesgo medio, $\bar d$.
#' 6. Se determina la desviación estándar asociada a la repetibilidad (a través de un estudio *Gauge/Gage R&R*) o como $\sigma_d$.
#' 7. Se comprueba que la repetibilidad sea aceptable.
#' 
#' $$\\ \%EV = 100 \  \dfrac {\sigma_{repetibilidad}} {\sigma_{total}}$$
#' 
#' Si no se dispone de la desviación estándar total, se usa como estimación una sexta parte del rango de trabajo.
#' 
#' $\%EV$ debe ser inferior al 10% para que la repetibilidad sea aceptable. Si es así, se prosigue con el estudio de sesgo.
#' 
#' ----
#' 
#' 8. Se contrasta la hipótesis de sesgo igual a cero, a través de una prueba *t* (asumida normalidad de los valores obtenidos).
#' 
#' $$\\t = \dfrac {\bar d \sqrt{n}} {\sigma_d}$$
#' 
#' 
#' ## Ejemplo
#' 
#' En el control de calidad de un vidrio para aplicaciones en microelectrónica, se ha decidido establecer como variable de control, la constante dieléctrica (permititividad relativa) a 599 MHz. Las especificaciones se han establecido en el rango de 7,50 a 7,70.
#' 
#' Para evaluar el sesgo de un determinado sistema de medida, se ha tomado una referencia de valor 7,60, y esta ha sido evaluada por un mismo operario 20 veces de acuerdo con la norma técnica en vigor.
#' 
#' ----
#' 
#' Los valores obtenidos se muestran en tabla adjunta (y en el fichero <a href="constante.txt">constante.txt</a>).
#' 
## ---- echo = FALSE, results = 'asis'-------------------------------------
datos <- read.table("constante.txt", header=FALSE, dec=",")
kable_styling(kable(matrix(datos[,1],ncol=5)), font_size=24)

#' 
#' Estudia la exactitud del sistema de medida.
#' 
#' 
#' # Linealidad
#' 
#' ## ¿Qué significa?
#' 
#' Se dice que un sistema de medición es **lineal** cuando el sesgo es indepediente del valor de la determinación; es decir, es constante en todo en el rango de trabajo.
#' 
#' No incluiremos en este desarrollo los estudios de linealidad. Puede encontrarse información sobre el desarrollo de los mismos en
#' 
#' - <span class="bibref">AIAG (Automotive Industry Action Group)(2010). *Measurement Systems Analysis. Reference Manual*. </span>
#' 
#' 
#' <!-- # Precisión (*Gauge/Gage R&R*) -->
#' 
#' <!-- ## ¿Qué significa? -->
#' 
#' 
#' <!-- ## Procedimiento -->
#' 
#' 
#' <!-- ## Ejemplo -->
#' 
#' 
#' 
#' # Referencias normativas
#' 
#' ##
#' 
#' - AIAG (Automotive Industry Action Group)(2010). Measurement Systems Analysis. Reference Manual. http://www.aiag.org/
#' - ASTM E2782 - Standard Guide for Measurement Systems Analysis
#' 
#' 
#' 
#' 
