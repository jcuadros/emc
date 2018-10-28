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
#' Un sistema de medida es adecuado si permite determinar un número suficiente de categorías (valores distintos) en el rango de trabajo (tolerancia, $LSE - LIE$, o variablidad del proceso, $(LSC- LIC) \sqrt{n}$).
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
#' Los valores obtenidos se muestran en tabla adjunta, de arriba a abajo y de izquierda a derecha ,y en el fichero <a href="constante.txt">constante.txt</a>.
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
#' # Precisión (*Gauge/Gage R&R*)
#' 
#' ## ¿Qué significa?
#' 
#' Se refiere a la **variabilidad aleatoria** del sistema de medida, es decir la variabilidad que queda una vez eliminado cualquier de estabilidad, de sesgo y de linealidad que pudiese presentar el sistema.
#' 
#' Se descompone una componente de repetibilidad y una de reproducibilidad.
#' 
#' $$\\\sigma^2_{medicion} = \sigma^2_{GRR} = \sigma^2_{repetibilidad} + \sigma^2_{reproducibilidad}$$
#' 
#' ----
#' 
#' La **repetibilidad** es la variabilidad inherente al instrumento, es decir aquella que se observa cuando instrumento y operador son constantes.
#' 
#' La **reproducibilidad** es la variabilidad asociada al cambio de operador y/o de instrumento.
#' 
#' Los estudios de repetibilidad y reproducibilidad se denominan *Gauge/Gage R&R*.
#' 
#' ----
#' 
#' <div style="font-style:italic;">
#' D.1.1.2 repeatability (of results of measurements) [VIM 3.6] closeness of the agreement between the results of successive measurements of the same measurand carried out under the same conditions of measurement.
#' 
#' - the same measurement procedure
#' - the same observer
#' - the same measuring instrument, used under the same conditions
#' - the same location
#' - repetition over a short period of time.
#' </div>
#' 
#' <p class="bibref">Taylor, B. N., & Kuyatt, C. E. (1994). *Guidelines for evaluating and expressing the uncertainty of NIST measurement results*. NIST Technical Note 1297. https://www.nist.gov/pml/nist-technical-note-1297</p>
#' 
#' ----
#' 
#' <div style="font-style:italic;">
#' D.1.1.3 reproducibility (of results of measurements) [VIM 3.7] closeness of the agreement between the results of measurements of the same measurand carried out under changed conditions of measurement
#' 
#' - principle of measurement
#' - method of measurement
#' - observer
#' - measuring instrument
#' - reference standard
#' - location
#' - conditions of use
#' - time.
#' 
#' </div>
#' 
#' <p class="bibref">Taylor, B. N., & Kuyatt, C. E. (1994). *Guidelines for evaluating and expressing the uncertainty of NIST measurement results*. NIST Technical Note 1297. https://www.nist.gov/pml/nist-technical-note-1297</p>
#' 
#' 
#' ## Estudios *Gauge/Gage R&R*
#' 
#' Existen dos tipus de estudios *Gauge/Gage R&R*:
#' 
#' - Diseño cruzado (*Crossed*): Aquellos donde cada operario mide cada pieza un número de veces.
#' - Diseño anidado (*Nested*): Aquellos en los que cada operario mide solo parte de las piezas.
#' 
#' Solo veremos los diseños cruzados con un solo instrumento de medida.
#' 
#' 
#' ## Procedimiento -- Diseño cruzado (*Crossed*)
#' 
#' <div style="font-size:30px;">
#' 1. Se recogen medidas para *n* piezas y *k* operadores de forma balanceada, *r* repeticiones para cada pieza y operador. Estas se toman en orden aleatorio para evitar sesgos.
#' 2. Se analizan gráficamente los datos. Existen distintas opciones de gráficos. Se sugieren entre otros:
#'     - Gráfico de variabilidad
#'     - Gráfico de interacción: Permite comprobar la existencia de interacciones operador-parte.
#'     - Gráfico de residuales: Permite comprobar las condiciones de aplicación del análisis de varianza: normalidad y homocedasticidad de los residuales.
#' 3. Se calculan los componentes de variabilidad asociados a la precisión (*R&R*).
#' </div>
#' 
#' ----
#' 
#' ### Gráfico de variabilidad
#' 
#' ![](img004.png){style=width:70%;margin-left:-35%;}
#' 
#' <span class="bibref">https://www.spcforexcel.com/knowledge/measurement-systems-analysis/anova-gage-rr-part-1</span>
#' 
#' ----
#' 
#' ### Gráfico de interacción
#' 
#' ![](img005.png){style=width:80%;margin-left:-40%;}
#' 
#' <p class="bibref">AIAG (Automotive Industry Action Group)(2010). *Measurement Systems Analysis. Reference Manual*. </p>
#' 
#' ----
#' 
#' ### Gráfico de residuales
#' 
#' ![](img006.png){style=width:70%;margin-left:-35%;}
#' 
#' <p class="bibref">AIAG (Automotive Industry Action Group)(2010). *Measurement Systems Analysis. Reference Manual*. </p>
#' 
#' ----
#' 
#' ### Cálculos de los componentes de la variabilidad (método del ANOVA)
#' 
#' Existen distintos métodos para el cálculo de los componentes de la variabilidad del sistema de medida. El más recomendado actualmente es el método basado en el análisis de la varianza (ANOVA).
#' 
#' El análisis de la varianza se basa en la descomposición de la varianza del conjunto de los datos.
#' 
#' El cálculo está detallado en
#' 
#' - <span class="bibref">https://www.spcforexcel.com/knowledge/measurement-systems-analysis/anova-gage-rr-part-1</span>
#' - <span class="bibref">https://www.spcforexcel.com/knowledge/measurement-systems-analysis/anova-gage-rr-part-2</span>
#' - <span class="bibref">https://www.spcforexcel.com/knowledge/measurement-systems-analysis/anova-gage-rr-part-3</span>
#' 
#' ----
#' 
#' ![](img008.png){style=width:70%;margin-left:-35%;}
#' 
#' <span class="bibref">https://www.spcforexcel.com/knowledge/measurement-systems-analysis/anova-gage-rr-part-1</span>
#' 
#' ----
#' 
#' <div style="font-size:20px;">
#' 
#' $$ \begin{align}
#'    \\ \sigma^2_{repetibilidad}  &= MS_{Equipment}
#'    \\ \sigma^2_{interaccion}  &=  \max \Bigg(0;{ {MS_{Operators*Parts} - \sigma^2_{repetibilidad}}
#'       \over r}\Bigg)
#'    \\ \sigma^2_{proceso} &= { {MS_{Parts} - MS_{Operators*Parts} } \over {k\ r} }
#'    \\ \sigma^2_{operadores} &= { {MS_{Operators} - MS_{Operators*Parts} } \over {n\ r} }
#'    \\
#'    \\ \sigma^2_{reproducibilidad} &= \sigma^2_{operadores} + \sigma^2_{interaccion}
#'    \\ \sigma^2_{GRR} &= \sigma^2_{reproducibilidad} + \sigma^2_{repetibilidad}
#'    \\ \sigma^2_{total} &= \sigma^2_{obs} = \sigma^2_{proceso} + \sigma^2_{GRR}
#'    \end{align}
#' $$
#' 
#' </div>
#' 
#' ----
#' 
#' <div style="font-size:20px;">
#' 
#' $$ \begin{align}
#'    \\ \%ContribVarianza(x) &= 100 \  \dfrac {\sigma^2_{x}}{\sigma^2_{total}}
#'    \\ \sigma_{x}  &= \sqrt {\sigma^2_{x}}
#'    \\ StudyVariation(x) &= 6 \  \sigma_{x}
#'    \\ \%StudyVariation(x) &= 100 \  \dfrac {\sigma_{x}}{\sigma_{total}}
#'    \\ \%Tolerance(x) &= 100 \ 
#'    \\ &\ \dfrac {6 \ \sigma_{x}}{min(LSE - LIE; (LSC -LIC) \sqrt{n}) }
#'    \end{align}
#' $$
#' 
#' </div>
#' 
#' 
#' ## Criterios de análisis de los estudios R&R
#' 
#' - El sistema de medida es **aceptable** cuando la variabilidad asociada (como desviación estándar, *Study Variation*) del componente R&R es inferior al 10% de la total (o de la tolerancia).
#' - El sistema de medida **NO** es aceptable cuando la variabilidad asociada (*Study Variation*) del componente R&R es superior al 30% de la total (o de la tolerancia).
#' 
#' ----
#' 
#' ![](img007.png){style=width:80%;margin-left:-40%;}
#' 
#' <p class="bibref">AIAG (Automotive Industry Action Group)(2010). *Measurement Systems Analysis. Reference Manual*. </p>  
#' 
#' 
#' ## Ejemplo
#' 
#' Suppose the ABC Company needs to evaluate a gasket thickness gauge. Three operators (George, Jane, and Robert) are selected for this study. Using the same gauge, each operator measures ten parts (gaskets) in a random order. Each part is measured by each operator twice (two trials). The following statements create a data set called ABC that contains the measurements (gasket thicknesses) collected by each operator (<a href="thickness.txt">thickness.txt</a>).
#' 
#' Ejemplo adaptado de SAS/QC(R) 13.1 User's Guide. http://support.sas.com/documentation/cdl/en/qcug/66857/HTML/default/viewer.htm#qcug_grr_sect011.htm
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
