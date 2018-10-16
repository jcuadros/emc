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
#' <div style="font-size:1.4em;font-weight:500;color:#333333;">Especificaciones y capacidad</div>
#' <div style="font-size:1.2em;margin-top:40px;color:#333333;">Jordi Cuadros, Lucinio González</div>
#' <div style="margin-top:80px;color:#333333;">Octubre de 2018</div>
#' 
#' 
#' # Especificaciones
#' 
#' ## ¿Qué son las especificaciones?
#' 
#' **Especificación**
#' 
#' Información proporcionada por el fabricante de un producto, la cual describe sus componentes, características y funcionamiento. A menudo constituye el compromiso con el cliente.
#' 
#' - Características
#'     - Atributos: conformidad
#'     - Variables: valor dentro de unos límites (LIE, LSE)
#' - Las especificaciones no estan especificadas por el proceso productivo ni se determinan estadísticamente.
#' 
#' 
#' ## ¿Cómo se relacionan con el proceso productivo?
#' 
#' - La probabilidad con la que se cumplirán unas especificaciones depende de las características del proceso.
#'     - Valor central
#'     - Variabilidad natural
#' 
#' - Distintos procesos productivos pueden tolerar distintos niveles de no conformidad.
#' 
#' 
#' ## El concepto de capacidad
#' 
#' La capacidad del proceso es la aptitud que tiene éste para producir dentro del intervalo fijado por las especificaciones.
#' 
#' ![](im001.png){style=width:60%;margin-left:-30%;}
#' 
#' ----
#' 
#' Para realizar un estudio de capacidad de un proceso, se ha de cumplir las siguientes condiciones:
#' 
#' - El proceso debe estar bajo control estadístico, es decir media y variabilidad estable a lo largo del tiempo.
#' - Los datos deben seguir una distribución normal.
#' - La muestra debe ser representativa (materiales de partida, ajustes de máquina, cambio de operarios, condiciones ambientales, desgaste...).
#' 
#' ----
#' 
#' En estas condiciones, se puede usar la distribución normal para establecer la capacidad del proceso y relacionar
#' 
#' - las características del mismo (valor central y variabilidad natural), con
#' - las especificaciones (valor nominal, límite inferior/superior de la especificación).
#' 
#' 
#' A partir de la misma puede también determinarse la probabilidad de obtener unidades no conformes con una determinada especificación.
#' 
#' 
#' # Distribución normal
#' 
#' ## Definición
#' 
#' La **distribución normal** es una distribución teórica simétrica comúnmente usada para la modelización matemática de valores afectados de error aleatorio.
#' 
#' ![](im002.svg){style=width:60%;margin-left:-30%;}
#' 
#' <span style="font-size:18pt;">https://commons.wikimedia.org/wiki/File:Standard_deviation_diagram_micro.svg</span>
#' 
#' 
#' ## Ejemplos
#' 
#' Sea un proceso productivo en el que se fabrican láminas de acero. Se ha establecido que la dureza promedio de las piezas producidas es 316 HB y la desviación estándar de las mismas es 25 HB.
#' 
#' Asumiendo que esta variable sigue una distribución normal, determina:
#' 
#' - ¿Qué proporción de piezas tienen un dureza inferior a 250 HB? ¿Y una superior a 350 HB?
#' - Si se establecen una especificaciones de 320 ± 40 HB, ¿qué proporción de piezas quedarán fuera de especificaciones?
#' - ¿Qué valor de dureza corresponde es superior al del 95 % de las piezas producidas? 
#' 
#' 
#' ## Inferencia sobre la normalidad
#' 
#' Para contrastar la hipótesis de si un conjunto de datos sigue una distribución normal se usan distintas pruebas y técnicas estadísticas:
#' 
#' - Prueba de Shapiro-Wilk
#' - Prueba de Anderson-Darling
#' - Gráfico cuantil-cuantil (QQ) o gráfico de normalidad
#' 
#' 
#' ## Pruebas de normalidad
#' 
#' Las pruebas de hipótesis para la normalidad de uso más común son las de:
#' 
#' - Shapiro-Wilk
#' - Anderson-Darling
#' 
#' Ambas pruebas son muy parecidas y la elección de una sobre la otra depende de las costumbres en el campo de aplicación.
#' 
#' En ambos casos, la hipótesis nula corresponde a asumir que la variable sigue una distribución normal de media y varianza iguales a la media y a la varianza de los datos de la muestra.
#' 
#' 
#' ## Gráfico de normalidad
#' 
#' El gráfico cuantil-cuantil permite comparar dos distribuciones comparando los cuantiles de cada dato de acuerdo con las mismas. Si ambas distribuciones son iguales, los cuantiles deben quedar alineados entorno a una recta.
#' 
#' El gráfico de normalidad usa la misma idea representando *y* vs *z*<sub>norm</sub> en los ejes. Esta es una de las formas más habituales de contrastar la normalidad.
#' 
#' ----
#' 
#' ![](im003.gif){style=width:60%;margin-left:-30%;}
#' 
#' <span style="font-size:18pt;">https://www.itl.nist.gov/div898/handbook/eda/section3/eda33l.htm</span>
#' 
#' 
#' ## Ejemplo
#' 
#' Determina si los datos que figuran en https://www.itl.nist.gov/div898/handbook/datasets/MONITOR-6_5_2.DAT estan normalmente distribuidos.
#' 
## ---- echo = FALSE-------------------------------------------------------
df <- read.table("https://www.itl.nist.gov/div898/handbook/datasets/MONITOR-6_5_2.DAT",
                 skip=25)
datos <- df[,1]

kable_styling(kable(matrix(datos,ncol=6)), font_size=20)

#' 
#' ----
#' 
## ---- echo = TRUE--------------------------------------------------------
shapiro.test(datos)

#' 
#' ----
#' 
## ---- echo = TRUE, eval = FALSE------------------------------------------
## if(!require("nortest")) {
##   install.packages("nortest", repos="https://cloud.r-project.org/",
##          quiet=TRUE, type="binary")
##   library("normtest")
## }
## 

## ---- echo = TRUE--------------------------------------------------------
ad.test(datos)

#' 
#' ----
#' 
## ---- echo = TRUE--------------------------------------------------------
qqnorm(datos)
qqline(datos)

#' 
#' 
#' # Índices de capacidad
#' 
#' ## Capacidad
#' 
#' *Process capability compares the output of an in-control process to the specification limits by using capability indices. The comparison is made by forming the ratio of the spread between the process specifications (the specification "width") to the spread of the process values, as measured by 6 process standard deviation units (the process "width").*
#' 
#' <span style="font-size:18pt;">https://www.itl.nist.gov/div898/handbook/pmc/section1/pmc16.htm</span>
#' 
#' 
#' ## *Cp*
#' 
#' Se define como **índice de capacidad Cp**, la relación entre la amplitud de la especificación y la variabilidad del proceso, establecida como 6 veces la desviación estándar de la variable de proceso en control.
#' $$\\C_p = {{LSE - LIE} \over {6 \hat \sigma}}$$
#' 
#' donde $\hat \sigma$ es la estimación desviación estándar de la variable de control.
#' 
#' ----
#' 
#' El índice de capacidad *Cp* es un buen indicador para procesos centrados en el valor nominal (VN), con dos límites de especificación.
#' 
#' El valor 1 del índice corresponde a un nivel de calidad 3$\sigma$ y suele ser un criterio mínimo para cualquier proceso productivo. 
#' 
#' ----
#' 
#' $\hat \sigma$ se determina como la desviación estándar de una muestra suficiente (*n* $>=$ 50) de valores de la variable de control tomados de forma representativa estando el proceso bajo control estadístico.
#' 
#' Se han calculado previamente gráficos de control Xbarra o I, el valor de $\hat \sigma$  se puede calcular a partir de las líneas de control.
#' $$\\\hat \sigma = {{(LSC - LC) \ \sqrt{n}}  \over {3}}$$
#' 
#' 
#' siendo *n* = 1 para el gráfico de individuos.
#' 
#' 
#' ## *Cpk*
#' 
#' Si el proceso no está centrado en el valor nominal (*target*) del proceso, o no tiene especificaciones simétricas, el capacidad debe tener en cuenta el valor central del proceso (LC o $\hat \mu$).
#' 
#' ----
#' 
#' En estos casos, se usa el **índice de capacidad Cpk** que se evalúa de acuerdo con la expresión siguiente.
#' $$\\C_{pk} = {{\min(LSE - \hat \mu ; \hat \mu - LIE)} \over {3 \hat \sigma}}$$
#' 
#' - Si el *Cpk* resulta inferior a 0, se toma como 0.
#' - Si el proceso está centrado, LC = VN, entonces *Cp* = *Cpk*. Si no está centrado, *Cp* > *Cpk*.
#' 
#' 
#' ## Procesos con una sola especificación (LIE o LSE)
#' 
#' En algunos procesos y para algunas variables solo uno de los límites de control resulta significativo. Por ejemplo, pureza, riqueza de un componente de interés, opacidad/transparencia, flujo luminoso, rugosidad, composición en una impureza...
#' 
#' En estos casos, la capacidad se define considerando solo uno de los dos límites de especificación.
#' 
#' ----
#' 
#' <p>&nbsp;</p>
#' 
#' $$C_{pl} = {{\hat \mu - LIE} \over {3 \hat \sigma}} \\ \\
#' C_{pu} = {{LSE - \hat \mu} \over {3 \hat \sigma}}$$
#' 
#' ## Interpretación de la capacidad
#' 
#' <p>&nbsp;</p>
#' 
#' 
#' | Para procesos              |  Bilateral   |   Unilateral  |
#' |:---------------------------|:------------:|:-------------:|
#' | ... existentes  					 |1,33          |1,25           |
#' | ... nuevos                 |1,50          |1,45           |
#' | ... críticos existentes    |1,50          |1,45           |
#' | ... críticos nuevos        |1,67          |1,45           |
#' 
#' <p>&nbsp;</p>
#' 
#' <p class="bibref">Montgomery, Douglas (2004). *Introduction to Statistical Quality Control*. New York, New York: John Wiley & Sons, Inc. p. 776</p>
#' 
#' ----
#' 
#' - En un proceso *Six Sigma*, el índice de capacidad debe ser superior o igual a 2.
#' - En cualquier caso, un índice de capacidad superior a 2,5 puede indicar un consumo excesivo de recursos en pro de la calidad y reflejar una oportunidad para la reducción de costes.
#' 
#' ----
#' 
#' - Si *Cp* ≥ 1 y *Cpk* ≥ 1
#'     - El proceso es capaz, no necesita mejora.
#' - Si *Cp* > 1 y *Cpk* < 1
#'     - El proceso es capaz, pero requiere corrección para centrar los resultados.
#' - Si *Cp* < 1
#'     - El proceso no es capaz.
#'     - Se puede trabajar con un proceso incapaz, estableciendo un control 100% de las unidades fabricadas (control automático o manual).
#'     - Es aconsejable, rediseñar el proceso para reducir la variabilidad y aumentar la capacidad del proceso.
#' 
#' 
#' ## Ejemplo
#'  
#' Se desea establecer la capacidad de una línea de envasado de un perfume en botellines de 50 ml. Los datos de las últimas muestras tomadas están en el archivo <a href="perfume.txt">perfume.txt</a>.
#' 
#' ¿Es el proceso capaz si se ha establecido que el volumen debe estar entre 49,9 y 50,1 mL?
#' 
#' ----
#' 
#' <p>&nbsp;</p>
#' 
## ---- echo = FALSE, results = 'asis'-------------------------------------
datos <- read.table("perfume.txt")
colnames(datos) <- c("x")

kable_styling(kable(matrix(datos[,1],ncol=6)), font_size=22)

#' 
#' 
#' ## Capacidad y número de defectos (en control)
#' 
#' El número de unidades no conformes con la especificación se establecen calculando la probablidad de obtener un valor superior a LSE o un valor inferior a LIE.
#' 
#' Para un proceso con ambos límites de especificación
#' 
#' $$P(nc) = P(x > LSE) + P(x < LIE) \\ \\
#' P(nc) = P(z > 3 C_{pk}) + P(z < -3 C_{pk})$$
#' 
#' Se suele indicar en DPMO (*defects per milion oportunities*).
#' 
#' 
#' ## Otros índices de capacidad
#' 
#' Existen otros índices, de aplicación menos común que incorporan consideraciones adicionales sobre *Cp* y *Cpk*.
#' 
#' Pueden encontrarse descritos en la bibliografia. Por ejemplo, en
#' 
#' <p class="bibref">Kotz, S., & Johnson, N. L. (2002). Process capability indices—a review, 1992–2000. *Journal of quality technology*, 34(1), 2-19.</p>
#' <p class="bibref">Wu, C. W., Pearn, W. L., & Kotz, S. (2009). An overview of theory and practice on process capability indices for quality assurance. *International journal of production economics*, 117(2), 338-359.</p>
#' <p class="bibref">Senvar, O., & Tozan, H. (2010). Process capability and six sigma methodology including fuzzy and lean approaches. In *Products and Services; from R&D to Final Solutions*. InTech.</p>
#' 
#' 
#' ## Relación entre capacidad y control
#' 
#' En un proceso ideal...
#' 
#' ![](im004.png)
#' 
#' ----
#' 
#' <p>&nbsp;</p>
#' 
#' Debe tenerse en cuenta que:
#' 
#' - El proceso puede estar en control y no cumplir especificaciones.
#' - El proceso puede cumplir especificaciones y no estar en control.
#' 
#' 
#' ¿Cómo serían en estos casos los gráficos de control de individuos (si añadimos las líneas de especificación)?
#' 
#' 
#' # Capacidad y rendimiento
#' 
#' ## Límites de la capacidad
#' 
#' La capacidad definida, tal y como se ha discutido más arriba, incluye en el cálculo solo la variabilidad intragrupo o variabilidad natural. Por ello, debe interpretarse como la aptitud **potencial** del proceso para cumplir con los requerimientos del cliente (las especificaciones).
#' 
#' Si el proceso es estable y esta en control, esta es una medida adecuada y por ello, a veces, es denominada **capacidad a corto plazo**.
#' 
#' 
#' ## Rendimiento o capacidad a largo plazo
#' 
#' Para describir, la aptitud del proceso para cumplir con las especificaciones de forma más **real** o **a largo plazo**, se establecen los índices *Pp* y *Ppk*. Estos se calculan usando la variabilidad calculada usando todas las observaciones del proceso, la variabilidad global, independientemente de si este está en control o no.
#' 
#' $$P_p = { {LSE - LIE} \over {6 \sigma_{global} } } \\ \\
#' P_{pk} = { {\min(LSE - \hat \mu ; \hat \mu - LIE)} \over {3 \sigma_{global} } }$$
#' 
#' ----
#' 
#' Si se observa divergencia entre los valores de *Cpk* y *Ppk*, ello indica que el proceso no está bajo control estadístico.
#' 
#' Puede encontrarse más información en
#' 
#' - <span style="word-break:break-all;">https://c.ymcdn.com/sites/casss.site-ym.com/resource/resmgr/CMC_No_Am_Jul_Spkr_Slds/2015_CMCS_DiMartinoMark.pdf</span>
#' - http://blog.minitab.com/blog/michelle-paret/process-capability-statistics-cpk-vs-ppk
#' 
#' 
#' ## Ejemplo
#' 
#' <div style="font-size:20pt;">En un horno de una incineradora de residuos urbanos es quemado el contenido de los camiones que llegan con los residuos previamente seleccionados. La escoria producida por el horno como resultado de la combustión, es analizada en el laboratorio de control de calidad que para determinar su composición y supervisar que la combustión haya sido correcta.
#' 
#' Se sabe que una combustión correcta necesita que la temperatura del horno no sea inferior a 850 ºC. Para no incrementar los costes de combustible, se ha establecido que el horno debe trabajar entre 840 ºC y 860 ºC. 
#' 
#' Hoy es su primer dia de trabajo como ingeniero y le encargan que supervise la temperatura del horno, entre otras cosas; para ello le entregan el registro de temperaturas de los últimos días (ver fichero <a href="horno.csv">horno.csv</a>). El fichero que ha recibido tiene registrado la temperatura media del horno cada diez minutos.
#' 
#' Estudia la capacidad del proceso.
#' </div>
#' 
#' 
#' ## Proporción de no conformes a largo plazo
#' 
#' Cunado el proceso está en control, el número de unidades no conformes con la especificación se establece como
#' $$\\P(nc) = P(z > 3 C_{pk}) + P(z < -3 C_{pk}) \\$$
#' 
#' A largo plazo y atendiendo que el proceso puede tener una deriva de 1,5 desviaciones estándar sin ser detectado como fuera de control, se considera la proporción de no conformes como
#' $$P(nc) = P(z > 3 C_{pk}-1,5) + \\ P(z < -3 C_{pk}-1,5)$$
#' 
#' <span style="font-size:18pt;">https://www.isixsigma.com/new-to-six-sigma/dmaic/15-sigma-process-shift/</span>
#' 
#' ----
#' 
#' <p class="bibref">Rudisill, F., & Druley, S. (2004). Which Six Sigma Metric Should I Use?. *Quality Progress*, 37(3), 104.<p>
#' 
#' ![](im005.png)
#' 
#' 
#' # Estimación de la capacidad en procesos no normales
#' 
#' ## ¿Qué hacemos si los datos no están normalmente distribuidos?
#' 
#' En este caso, hay dos alternativas:
#' 
#' - usar estimadores no paramétricos para la dispersión (cuantiles),
#' - usar transformaciones de variables:
#'     - logaritmo, inversa, cuadrado...
#'     - transformada de Box-Cox (1964),
#'         - <span style="word-break:break-all;">https://www.encyclopediaofmath.org/index.php/Box%E2%80%93Cox_transformation</span>
#'     - transformada de Johnson (1949)
#'         - <span style="word-break:break-all;">https://rexplorations.wordpress.com/2015/11/03/johnson-transformation-for-non-normal-data/</span>
#' 
#' 
#' ## Estimadores no parámetricos
#' 
#' A partir de los cuantiles de los datos o de la distribución que estos siguen, puede calcularse *Cp* y *Cpk* de acuerdo con las fórmulas siguientes
#' 
#' $$C_p = { {LSE - LIE} \over {X_{0,99865} - X_{0,00135}}}\\ \\
#' C_{pk} = \min \Bigg( {{LSE - X_{0,5}} \over {X_{0,99865} - X_{0,5}}} ; {X_{0,5} - LIE \over {X_{0,5} - X_{0,00135}}}\Bigg)$$
#' 
#'         
#' # Referencias normativas
#' 
#' ##
#' 
#' - ASTM E2281-15. Standard Practice for Process Capability and Performance Measurement. https://www.astm.org/Standards/E2281.htm
#' - AIAG (Automotive Industry Action Group). Statistical Process Control. Reference Manual. http://www.aiag.org/
#' - ISO 22514-2:2017. Statistical methods in process management -- Capability and performance -- Part 2: Process capability and performance of time-dependent process models https://www.iso.org/standard/71617.html
#' - UNE-ISO 22514-1:2017. Métodos estadísticos en la gestión de procesos. Capacidad y rendimiento. Parte 1: Principios y conceptos generales. https://www.une.org/encuentra-tu-norma/busca-tu-norma/norma/?c=N0057911
#' 
#' 
