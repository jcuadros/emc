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
#' editor_options: 
#'   chunk_output_type: console
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
if(!require("car")) {
  install.packages("car", repos="https://cloud.r-project.org/",
         quiet=TRUE, type="binary")
  library("car")
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
#' <div style="font-size:1.4em;font-weight:500;color:#333333;">Diseño de experimentos</div>
#' <div style="font-size:1.2em;margin-top:40px;color:#333333;">Jordi Cuadros, Lucinio González</div>
#' <div style="margin-top:80px;color:#333333;">Noviembre de 2018</div>
#' 
#' 
#' # Análisis y mejora del proceso
#' 
#' ## Pasos en la mejora del proceso
#' 
#' - Caracterización del problema de mejora
#'     - Identificación del problema o la variable de respuesta
#'     - *Root-cause analysis*, identificación de las posibles causas
#'     - Priorización de las posibles causas
#' - Investigación: Obtención de datos y toma de decisiones
#'     - Diseño de experimentos
#'         - Estudios de un factor
#'         - Diseños de múltiples factores
#'     - Experimentos *ex-post-facto*: Minería de datos y análisis correlacionales.
#' 
#' 
#' # Caracterización del problema de mejora
#' 
#' ## Identificación del problema o la variable de respuesta
#' 
#' - Todo proceso de mejora empieza identificando el objeto de esta mejora
#'     - Incidente
#'     - Valor de una característica del proceso o del producto
#'     - Petición de mejora
#'     - ...
#' - Para su análisis cuantitativo, esta variable tendrá que ser cuantificada de una forma u otra. Es conveniente por tanto, dotar la misma de una expresión numérica.
#' 
#' 
#' ## *Root-cause Analysis*
#' 
#' - Una vez identificada la respuesta objeto de estudio o mejora, debe analizarse qué variables/factores pueden estar influyendo en el valor de la misma.
#' - Para ello se usan distintas técnicas de tipo cualitativo que conforman lo que se conoce como RCA (*Root-cause analysis*). Todas ellas pretenden llegar a obtener un listado relativamente exhaustivo de aquello que pueda haber producido un determinado resultado o efecto o bien a la causa cuya eliminación permite evitar que pueda repetirse el problema.
#' 
#' ----
#' 
#' ### Técnicas para el RCA
#' 
#' - 5 Why's
#' - Diagrama de espina de pez, *Fishbone diagram* (or diagrama de Ishikawa)
#' - FMEA/FMECA (*Failure mode, effects and criticality analysis*)
#' 
#' 
#' ## 5 Why's
#' 
#' <iframe width="642" height="361" src="https://www.youtube.com/embed/JmrAkHafwHI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
#' 
#' <span class="bibref">https://www.youtube.com/watch?v=JmrAkHafwHI</span>
#' 
#' 
#' ## 5 Why's
#' 
#' - Establecer un equipo de trabajo.
#' - Preguntarse el porqué hasta encontrar causas actuables (últimas).
#' - Seguir varias causas si aparecen más de una.
#' - Identificar actuaciones a los distintos niveles. Distribuir esfuerzos y costes en los distintos niveles.
#' - **NUNCA** dejar como causas últimas errores individuales. Las causas siempre estan en los procesos.
#' 
#' ----
#' 
#' ### Referencias adicionales
#' 
#' - https://www.adb.org/sites/default/files/publication/27641/five-whys-technique.pdf 
#' - https://www.mindtools.com/pages/article/newTMC_5W.htm
#' - https://www.bulsuk.com/2009/03/5-why-finding-root-causes.html 
#' - https://open.buffer.com/5-whys-process/
#' - https://www.youtube.com/watch?v=51aKj3MYBvs
#' 
#' 
#' ## Diagrama de espina de pez
#' 
#' <iframe width="642" height="361" src="https://www.youtube.com/embed/RkPBiAUGo-M" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
#' 
#' <span class="bibref">https://www.youtube.com/watch?v=RkPBiAUGo-M</span>
#' 
#' 
#' ## Diagrama de espina de pez
#' 
#' ![](im001.png) 
#' 
#' <span class="bibref">https://sites.ualberta.ca/~yreshef/orga432/fishbone.html</span>
#' 
#' 
#' 
#' ### Referencias adicionales
#' 
#' - https://www.isixsigma.com/tools-templates/cause-effect/cause-and-effect-aka-fishbone-diagram/
#' - http://asq.org/learn-about-quality/cause-analysis-tools/overview/fishbone.html 
#' - https://sixsigmastudyguide.com/six-ms-6ms-or-5ms-and-one-p-5m1p/
#' - https://www.youtube.com/watch?v=ZS8Re23Z_4k
#' 
#' 
#' ## Priorización de causas o *Criticality analysis*
#' 
#' Estrategias como el diagrama de espina de pez generan un número generalmente importante de posibles causas ante un fenómeno. Es necesario a continuación priorizar de forma reflexiva su estudio y/o resolución.
#' 
#' Existen distintas estrategias de priorización:
#' 
#' - Frecuencia
#' - Matriz de causas y efectos, http://www.six-sigma-material.com/Correlation-Matrix.html
#' - FMEA / FMECA (*Failure Mode, Effects and Criticality Analysis*), http://www.six-sigma-material.com/FMEA.html 
#'     - SEVERITY · OCCURRENCE · DETECTION = RPN
#' 
#' ----
#' 
#' ![](im002.png) 
#' 
#' <span class="bibref">MIL-STD-882E. System Safety.</span>
#' 
#' ----
#' 
#' ![](im003.png) 
#' 
#' <span class="bibref">MIL-STD-882E. System Safety.</span>
#' 
#' ----
#' 
#' ![](im004.png) 
#' 
#' <span class="bibref">MIL-STD-882E. System Safety.</span>
#' 
#' 
#' # Investigación
#' 
#' ## Necesidad de investigar
#' 
#' Una vez identificadas las causas potenciales de un determinado suceso o efecto a menudo es necesario recopilar más datos o más información para...
#' 
#' - Determinar si una causa potencial tiene efecto real en el resultado
#' - Establecer la importancia relativa de distintos factores
#' - Determinar valores óptimos de cada factor
#' - ...
#' 
#' Ello implica investigar.
#' 
#' 
#' ## Tipos de investigación
#' 
#' En este curso se discutirán
#' 
#' - Investigación experimental: Diseño de experimentos
#' - Investigación *ex-post-facto*: Análisis correlacional
#' 
#' 
#' # Investigación experimental
#' 
#' ## Objetivos en un diseño experimental
#' 
#' - MAXIMIZAR el efecto
#'     - MAXIMIZAR la variabilidad de la variable independiente
#' - MINIMIZAR el error de medida
#'     - Detallar el proceso de determinación de la variable dependiente
#'     - Usar instrumentos fiables
#'     - Tamaño de muestra grande
#'     - Homogeneidad de las muestras
#' - CONTROLAR las variables intervinientes
#'     - CONSTANCIA
#'     - ALEATORIZACIÓN
#'     - BLOQUEO
#'     - TRATAMIENTO ESTADÍSTICO
#' 
#' 
#' ## Proceso de un diseño experimental
#' 
#' - Identificar las variables experimentales
#' - Establecer los niveles de las variables
#' - Establecer el proceso experimental
#' - Establecer la hipótesis experimental y las hipótesis estadísticas
#' - Recoger datos
#' - Ejecutar la prueba estadística más adecuada 
#' - Concluir
#' 
#' 
#' ## Identificar las variables experimentales
#' 
#' - Pasos previos
#'     - Identificada la variable o función respuesta
#'     - Identificados los posibles factores
#'     - Priorizados los más importantes
#' 
#' - De los factores priorizados
#'     - ¿Cuáles pueden ser controlados y van a ser incluidos en el diseño experimental?
#'     - ¿Cuáles pueden ser constantes?
#'     - ¿Cuáles pueden ser aleatorizados?
#'     - ¿Cuáles pueden bloquearse?
#' 
#' 
#' ## Establecer los niveles de las variables
#' 
#' - Se denominan niveles los distintos valores de la variables experimental que van a ser incluidos en el experimento. Se suelen tratar como variable discreta (factor).
#' 
#' - Debe considerarse:
#'     - El rango de validez del factor
#'     - El número de niveles a usar (habitualmente 2 a no ser que haya sospechas de no-linealidad)
#'     - El coste; da más información la realización secuencial de experimentos que la realización de un experimento con más niveles.
#' 
#' ----
#' 
#' - Si la variable es cualitativa, se usan los valores habituales (más comunes) de la variable.
#' - Si la variable es cuantitativa,
#'     - Se suele establecer niveles equiespaciados (si son más de 2) y suficientemente separados en el dominio de validez del factor (MAX),
#'     - Es habitual evitar los extremos para minimizar el riesgo de estar fuera del dominio experimental.
#' 
#' 
#' ## Establecer el proceso experimental
#' 
#' - El número de variables experimentales y bloqueadas (y el número de experiencias que es posible realizar) establecerá el tipo de diseño experimental a usar
#' - Veremos en esta sesión y en las siguientes:
#'     - Diseños de un factor
#'     - Diseños factoriales completos de varios factores
#'     - Diseños factoriales fraccionados y saturados
#' 
#' 
#' ## Establecer las hipótesis y ejecutar la prueba estadística más adecuada
#' 
#' - Para resolver el experimento, debe concretarse una hipótesis experimental.
#' - Esta hipótesis experimental se traduce a dos hipótesis estadísticas:
#'     - la hipótesis nula, y
#'     - la hipótesis alternativa.
#' - El diseño usado, las hipótesis estadísticas y la naturaleza de los datos, permiten establecer una prueba estadística adecuada.
#' - Se comprueban los supuestos de la prueba y se lleva a cabo la misma (si los supuestos se cumplen) .
#' 
#' 
#' # Diseños experimentales de un factor
#' 
#' ## Aspectos generales y tipos
#' 
#' - Criterios generales
#'     - Con repetición
#'     - Balanceados
#'     - Completamente aleatorizados (orden aleatorio de los experimentos)
#' - Diseños de un factor
#'     - Dos niveles con datos apareados
#'     - Dos niveles con muestras independientes
#'     - Más de dos niveles
#' 
#' 
#' ## Diseño de un factor con dos niveles - datos apareados
#' 
#' Corresponde a aquella situación en la que cada observación puede hacerse para los dos niveles del factor manteniéndose constantes todas las variables que corresponden al individuo evaluado. Ello permite reducir la variabilidad experimental.
#' 
#' ----
#' 
#' El análisis de este diseño se realiza en dos pasos:
#' 
#' 1. Estudio de la normalidad de las diferencias
#'     - Prueba de Shapiro-Wilk,  ```shapiro.test(...)```
#'     - Gráfico QQ,  ```ggplot(... aes(sample=...)) + geom_qq(...)```
#' 2. Inferencia sobre la media (o la mediana) de la distribución de las diferencias
#'     - Prueba t (para variables normalmente distribuidas),  ```t.test(...)```
#'     - Prueba de Wilcoxon,  ```wilcox.test(...)```
#' 
#' 
#' ## Ejemplo
#' 
#' En el control de calidad de una industria de fabricación de jácenas, se ha decidido comparar dos métodos para determinar la resistencia a la cizalla de las bigas producidas. 
#' 
#' De acuerdo con los datos que figuran en el fichero 'vigas.txt', determina si ambos métodos de determinación pueden considerarse equivalentes.
#' 
#' ----
#' 
## ---- echo = FALSE, results = 'asis'-------------------------------------
datos <- read.table("vigas.txt", header=TRUE, dec=".", sep=";")
kable_styling(kable(datos), font_size=28)

#' 
#' ----
#' 
## ---- echo = TRUE--------------------------------------------------------
datos$Dif <- datos$Metodo1 - datos$Metodo2
shapiro.test(datos$Dif)

#' 
## ---- eval=FALSE, echo = TRUE--------------------------------------------
## ggplot(datos, aes(sample=Dif)) +
##   geom_qq() + geom_qq_line() + theme_classic()

#' 
#' ----
#' 
## ---- echo = FALSE-------------------------------------------------------
ggplot(datos, aes(sample=Dif)) +
  geom_qq() + geom_qq_line() + theme_classic()

#' 
#' ----
#' 
## ---- echo = TRUE--------------------------------------------------------
t.test(datos$Dif)

#' 
#' ----
#' 
## ---- echo = TRUE--------------------------------------------------------
wilcox.test(datos$Dif)

#' 
#' 
#' ## Diseño de un factor con dos niveles - datos independientes
#' 
#' Corresponde a aquella situación en que las observaciones para un nivel no tienen relación con las observaciones para el segundo nivel.
#' 
#' En este caso, es frecuente querer comparar los valores centrales o/y las variabilidades correspondientes a ambos niveles de la variable independiente.
#' 
#' ----
#' 
#' El análisis para la comparación de los valores centrales se realiza en dos pasos:
#' 
#' 1. Estudio de la normalidad para cada nivel
#'     - Prueba de Shapiro-Wilk,  ```shapiro.test(...)```
#'     - Gráfico QQ,  ```ggplot(... aes(sample=...)) + geom_qq(...)```
#' 2. Inferencia sobre las medias (o las medianas) de los niveles
#'     - Prueba t de Welch (para variables normalmente distribuidas),  ```t.test(...)```
#'     - Prueba de Mann-Whitney (o de Wilcoxon),  ```wilcox.test(...)```
#' 
#' ----
#' 
#' Para la comparación de las variabilidades se procede del modo siguiente:
#' 
#' 1. Estudio de la normalidad para cada nivel
#'     - Prueba de Shapiro-Wilk,  ```shapiro.test(...)```
#'     - Gráfico QQ,  ```ggplot(... aes(sample=...)) + geom_qq(...)```
#' 2. Inferencia sobre las varianzas de los resultados de ambos niveles
#'     - Prueba F (para variables normalmente distribuidas),  ```var.test(...)```
#'     - Prueba de Levene (o de Brown–Forsythe),  ```car::leveneTest(...)```
#' 
#' 
#' ## Ejemplo
#' 
#' En una papelera, se ha decidido modificar la composición de las fibras usadas para la fabricación del papel para valorar si una mayor proporción de fibras de eucalipto, da lugar a un papel con mejores propiedades mecánicas (y menor variabilidad en las mismas).
#' 
#' Los resultados de la resistencia a la tracción para distintas producciones (en psi) se muestran en el fichero 'papel.txt'.
#' 
#' ¿Qué conclusiones puedes sacar de los mismos?
#' 
#' ----
#' 
#' <style>
#' .container{
#'     display: flex;
#' }
#' .col{
#'     flex: 1;
#' }
#' </style>
#' 
#' <div class="container">
#' 
#' <div class="col">
#' 
## ---- echo = FALSE, results = 'asis'-------------------------------------
datos <- read.table("papel.txt", sep="\t", header=TRUE)
datos$Prop <- factor(datos$Prop)
kable_styling(kable(datos[1:11,],row.names=FALSE), font_size=28)

#' 
#' </div>
#' <div class="col">
#' 
## ---- echo = FALSE, results = 'asis'-------------------------------------
kable_styling(kable(datos[12:22,],row.names=FALSE), font_size=28)

#' 
#' </div>
#' </div>
#' 
#' ----
#' 
## ---- eval = FALSE, echo = TRUE------------------------------------------
## datos <- read.table("papel.txt", sep="\t", header=TRUE)
## datos$Prop <- factor(datos$Prop)
## ggplot(datos, aes(x=Prop,y=Resist)) +
##   geom_boxplot() +
##   theme_classic()

#' 
#' ----
#' 
## ---- echo = FALSE-------------------------------------------------------
ggplot(datos, aes(x=Prop,y=Resist)) +
  geom_boxplot() +
  theme_classic()

#' 
#' ----
#' 
## ---- echo = TRUE--------------------------------------------------------
by(datos$Resist,datos$Prop,shapiro.test)

#' 
#' ----
#' 
## ---- echo = TRUE--------------------------------------------------------
t.test(datos$Resist ~ datos$Prop,
       alternative = "less")

#' 
#' ----
#' 
## ---- echo = TRUE--------------------------------------------------------
var.test(datos$Resist ~ datos$Prop,
       alternative = "greater")

#' 
#' ----
#' 
#' ### Conclusiones
#' 
#' Un mayor proporción de fibras de eucalipto parece dar lugar a un papel más resistente.
#' La variabilidad del proceso, respecto a esta propiedad, no parece disminuir.
#' 
#' 
#' ## Diseño de un factor con más de dos niveles
#' 
#' Corresponde a aquella situación en que se desea establecer si más de dos valores de la variable independiente llevan a resultados equivalentes.
#' 
#' Estos resultados pueden ser equivalentes en cuanto a sus valores centrales o/y  sus variabilidades.
#' 
#' ----
#' 
#' El análisis para la comparación de los valores centrales se realiza en dos pasos:
#' 
#' 1. Estudio de la normalidad para cada nivel
#'     - Prueba de Shapiro-Wilk,  ```shapiro.test(...)```
#'     - Gráfico QQ,  ```ggplot(... aes(sample=...)) + geom_qq(...)```
#' 
#' Esta prueba se puede substituir por una prueba de normalidad de los residuales *a posteriori*.
#'   
#' ----
#'   
#' 2. Inferencia sobre las medias (o las medianas) de los niveles
#'     - Anova de Welch (para variables normalmente distribuidas),  ```oneway.test(...)```
#'     - Prueba de Kruskal-Wallis,   ```kruskal.test(...)```
#' 
#' ----
#' 
#' Para la comparación de las variabilidades se procede del modo siguiente:
#' 
#' 1. Estudio de la normalidad para cada nivel
#'     - Prueba de Shapiro-Wilk,  ```shapiro.test(...)```
#'     - Gráfico QQ, ```ggplot(... aes(sample=...)) + geom_qq(...)```
#' 2. Inferencia sobre las varianzas de los resultados de ambos niveles
#'     - Prueba de Bartlett (para variables normalmente distribuidas),  ```bartlett.test(...)```
#'     - Prueba de Levene (o de Brown–Forsythe),  ```car::leveneTest(...)```
#' 
#' 
#' ## Ejemplo
#' 
#' En la empresa donde estás haciendo las prácticas, estan evaluando la posibilidad de cambiar el proveedor de los pernos que usáis en el proceso de fabricación.
#' 
#' Han recibido ofertas de tres proveedores y entre las distintas consideraciones a tener en cuenta está la resistencia a la tracción de los mismos. Hechos los experimentos pertinentes para muestras aleatorias de 12 pernos de cada proveedor, fichero 'pernos.txt', ¿se puede afirmar que tienen la misma resistencia a la tracción (en MN m<sup>-2</sup>)? ¿y la misma variabilidad en esta propiedad?
#' 
#' 
#' # Diseños experimentales de más de un factor
#' 
#' ## Diseño factor a factor (*OFAT*)
#' 
#' El diseño consiste en realizar distintos experimentos de un factor manteniendo constantes los demás factores que desea estudiarse.
#' 
#' 
#' ## Diseño factor a factor - Problemas
#' 
#' Cuando el proceso tiene más de un factor identificado como variable experimental (o como bloqueo), el análisis factor a factor (diseños de 1 factor) resulta demasiado costoso y poco eficiente
#' 
#' - Requiere demasiado experimentos
#' - No aprovecha toda la experimentación para reducir el error de medida
#' - No permite evaluar el efecto de las interacciones
#' - No facilita la reutilización de experiencias para la ampliación de los estudios experimentales
#' 
#' 
#' ## Objetivos de los diseños factoriales
#' 
#' Se denominan diseños factoriales, aquellos diseños experimentales que incorporan más de un factor (variable experimental).
#' 
#' ----
#' 
#' ![](im006.png){style=width:60%;margin-left:-30%;}
#' 
#' <span class="bibref">https://www.itl.nist.gov/div898/handbook/pri/section3/pri33.htm</span>
#' 
#' 
#' ## Tipos de diseños factoriales
#' 
#' - Diseños factoriales completos
#'     - ... de 2 niveles, con y sin repetición
#'     - ... con más de 2 niveles en algun factor
#' - Diseños factoriales fraccionados
#'     - Diseños factoriales saturados
#'     - Diseños de Plackett-Burman
#' - Diseños para superfícies de respuestas
#'     - Diseños centrales compuestos
#'     - Diseños de Box-Behnken
#'     
#' 
#' ## Diseños factoriales completos de dos niveles
#' 
#' Simbología y terminología
#' 
#' - Se indican como 2<sup>*k*</sup>, donde *k* es el número de factores y el resultado de 2<sup>*k*</sup>, el número de experimentos a realizar.
#' - Se suelen usar letras mayúsculas (A-Z) para identificar los **factores**.
#' - Para cada factor, existe un nivel bajo (que no se indica) y un nivel alto (que se indica en minúsculas).
#' Un conjunto de niveles para cada factor establece unas **condiciones experimentales**.
#' 
#' ----
#' 
#' Matriz de diseño
#' 
#' - Consiste en el conjunto de condiciones experimentales que deben ser experimentadas.
#' - En un diseño factorial completo, corresponde a todas las combinaciones de niveles de los distintos factores.
#' - Suele construirse de acuerdo con el orden de Yates...
#' 
#' ----
#' 
#' Para 2<sup>3</sup>...
#' 
#' |     |  A  |  B  |  C  |
#' |:---:|:---:|:---:|:---:|
#' |  -  |  -  |  -  |  -  |
#' |  a  |  +  |  -  |  -  |
#' |  b  |  -  |  +  |  -  |
#' |  ab |  +  |  +  |  -  |
#' |  c  |  -  |  -  |  +  |
#' |  ac |  +  |  -  |  +  |
#' |  bc |  -  |  +  |  +  |
#' | abc |  +  |  +  |  +  |
#' 
#' ----
#' 
#' <p>&nbsp;</p>
#' 
#' En estos diseños se cumple que
#' 
#' - En el análisis de cada factor, es el resto de los factores están bloqueados.
#' - Cada nivel de cada factor, se experimenta más de una vez.
#' - Para cada factor, los dos niveles están balanceados.
#' 
#' 
#' ## Interacciones
#' 
#' - Las interacciones corresponden a la presencia/ausencia simultánea de dos o más factores.
#' - Se calculan multiplicando las columnas correspondientes a los factores implicados.
#' - En un diseño factorial completo las columnas de los factores y de las interacciones son todas ortogonales entre sí. Es decir que puede estudiarse el efecto de todos los factores y de todas las interacciones.
#' - El estudio de cada interacción también está balanceado, implica múltiples observaciones en cada nivel y mantiene bloqueados los demás factores e interacciones.
#' 
#' 
#' ## Diseño factorial - Realización de los experimentos
#' 
#' - En orden aleatorio, para evitar problemas de autocorrelación
#' - Si se hacen réplicas estas deben ser completamente genuinas. Deben abordarse como ensayos independientes
#' 
#' Los resultados se añaden a la matriz de diseño del diseño experimental.
#' 
#' 
#' ## Análisis de un diseño factorial - Método de los efectos
#' 
#' - Para cada nivel de cada factor se calcula el promedio de los resultados experimentales
#' - El efecto (de un factor, *efecto principal*, o de una interacción) se estima como 
#' 
#' $$ \\
#'   Ef_{FoI} = {\bar y}_{FoI+} - {\bar y}_{FoI-}$$
#' 
#' ----
#' 
#' Para facilitar el análisis se suelen usar tres tipos de representaciones gráficas
#' 
#' - Gráficos de los efectos (principales)
#' - Gráficos de las interacciones de primer orden
#' - Diagrama de Pareto
#' 
#' 
#' ## Análisis de un diseño factorial - Consideraciones
#' 
#' Son consideraciones habituales en el análisis de los diseños factoriales completos
#' 
#' - Las interacciones de más de dos factores no son relevantes
#'     … aunque cuidado con las combinaciones críticas
#' - Las interacciones de dos factores solo son relevantes si lo son los factores (principio de la herencia)
#'     … aunque cuidado con los óptimos
#' - Cuando un efecto no es relevante puede excluirse del análisis y tratar los resultados como si se tratara de réplicas.
#' 
#' 
#' ## Ejemplo
#' 
#' Estudia el efecto de los distintos factores en el rendimiento de plantas de pallar (*Phaseolus lunatus*). Los datos están recogidos en el archivo 'bean.csv'.
#' 
#' Los factores considerados son:
#' 
#' - A: profundidad de plantado: -, 0,5 in; +, 1,5 in
#' - B: número de riegos por día: -, 1; +, 2
#' - C: tipo de semilla: -, baby; +, grande
#' 
#' 
#' Problema adaptado de Box, G. E., Hunter, J. S., & Hunter, W. G. (2005). *Statistics for experimenters: design, innovation, and discovery*. 2nd edition. New York: Wiley-Interscience.
#' 
#' ----
#' 
## ---- echo = FALSE, results = 'asis'-------------------------------------
datos <- read.table("bean.csv", sep=";", header=TRUE)
colnames(datos)[1] <- "A"
kable_styling(kable(datos,row.names=FALSE), font_size=28)

#' 
#' ----
#' 
#' ### Matriz de diseño con interacciones y respuestas
#' 
## ---- echo = TRUE, eval = FALSE------------------------------------------
## datos <- gather(datos,"rep","yield",Rep1:Rep3)
## 
## datos$AB <- datos$A * datos$B
## datos$AC <- datos$A * datos$C
## datos$BC <- datos$B * datos$C
## datos$ABC <- datos$A * datos$B * datos$C
## 
## datos$rep <- NULL
## datos <- cbind(datos[,-4],yield=datos[,4])

#' 
#' ----
#' 
## ---- echo = FALSE-------------------------------------------------------
datos <- gather(datos,"rep","yield",Rep1:Rep3)

datos$AB <- datos$A * datos$B
datos$AC <- datos$A * datos$C
datos$BC <- datos$B * datos$C
datos$ABC <- datos$A * datos$B * datos$C

datos$rep <- NULL
datos <- cbind(datos[,-4],yield=datos[,4])

kable_styling(kable(head(datos,12),row.names=FALSE), font_size=28)

#' 
#' ----
#' 
#' ### Cálculo de los efectos
#' 
## ---- echo = TRUE--------------------------------------------------------
efectos <- datos[,1:7] * datos[,8]
efectos <- colSums(efectos) / 12
efectos

#' 
#' ----
#' 
## ---- echo = TRUE--------------------------------------------------------
mediasA <- datos %>% group_by(A) %>% summarise(media=mean(yield))
colnames(mediasA)[1] <- "nivel"
mediasA$factor <- "A"

mediasB <- datos %>% group_by(B) %>% summarise(media=mean(yield))
colnames(mediasB)[1] <- "nivel"
mediasB$factor <- "B"

mediasC <- datos %>% group_by(C) %>% summarise(media=mean(yield))
colnames(mediasC)[1] <- "nivel"
mediasC$factor <- "C"

medias <- rbind(mediasA,mediasB,mediasC)

#' 
#' ----
#' 
## ---- eval = FALSE, echo = TRUE------------------------------------------
## ggplot(medias,aes(x=factor(nivel),y=media,group=1))+
##   geom_point() +
##   geom_line() +
##   facet_grid(.~factor)+
##   theme_classic()

#' 
#' ----
#' 
## ---- echo = FALSE-------------------------------------------------------
ggplot(medias,aes(x=factor(nivel),y=media,group=1))+
  geom_point() +
  geom_line() +
  facet_grid(.~factor)+
  theme_classic()

#' 
#' ----
#' 
## ---- echo = TRUE, eval = FALSE------------------------------------------
## interacciones <- datos %>% group_by(A,B) %>%
##   summarise(media=mean(yield))
## 
## ggplot(interacciones,
##        aes(x=factor(A),y=media,color=factor(B),group=factor(B))) +
##   geom_point() +
##   geom_line() +
##   theme_classic()

#' 
#' ----
#' 
## ---- echo = FALSE-------------------------------------------------------
interacciones <- datos %>% group_by(A,B) %>% 
  summarise(media=mean(yield))

ggplot(interacciones, 
       aes(x=factor(A),y=media,color=factor(B),group=factor(B))) +
  geom_point() +
  geom_line() +
  theme_classic()

#' 
#' ----
#' 
## ---- echo = TRUE, eval = FALSE------------------------------------------
## efectosO <- efectos[order(abs(efectos))]
## efectosO <- data.frame(variable=factor(names(efectosO),
##                                        levels=names(efectosO)),
##                        efecto=efectosO)
## 
## ggplot(efectosO,aes(x=variable,y=abs(efecto),fill=efecto>0)) +
##   geom_bar(stat="identity",color="black")+
##   coord_flip()+
##   theme_classic()+
##   theme(legend.position="none")

#' 
#' ----
#' 
## ---- echo = FALSE-------------------------------------------------------
efectosO <- efectos[order(abs(efectos))]
efectosO <- data.frame(variable=factor(names(efectosO),
                                       levels=names(efectosO)),
                       efecto=efectosO)

ggplot(efectosO,aes(x=variable,y=abs(efecto),fill=efecto>0)) +
  geom_bar(stat="identity",color="black")+
  coord_flip()+
  theme_classic()+
  theme(legend.position="none")

#' 
#' 
#' ## Estimación del error de los efectos
#' 
#' El error estándar de los efectos ($\ s_{ef}\ $) puede estimarse medinate distintas estrategias
#' 
#' - media de las desviación estándar de las repeticiones, dividida por $\ \sqrt{2^{k-2}·r} \ $ 
#' - desviación estandár de los residuales, dividido por $\ \sqrt {2^{k-2}·r} \ $
#' - desviación estándar de los efectos menos significativos o de las interacciones de mayor orden
#' - 1,5 veces la mediana del valor absoluto de los efectos cuyo valor absoluto es inferior a 3,75 (2,5 · 1,5) veces la mediana del valor absoluto de todos los efectos
#' 
#' <p class="bibref">
#' https://onlinecourses.science.psu.edu/stat503/node/36/ <br />
#' https://www.weibull.com/hotwire/issue113/relbasics113.htm 
#' </p>
#' 
#' ----
#' 
#' Un efecto es significativo si es mayor, en valor absoluto, que 
#' 
#' $$ \\
#' Ef_{c} = s_{ef} * t_{1-\frac{\alpha}{2}, r·2^k - 2^k}$$
#' 
#' ----
#' 
## ---- echo = TRUE--------------------------------------------------------
(sef <- 1.5 * median(abs(efectos[abs(efectos) < 
          3.75 * median(abs(efectos))])))
(efc <- sef * qt(0.975, 24 - 8))

#' 
#' ----
#'   
## ---- echo = TRUE, eval = FALSE------------------------------------------
## ggplot(efectosO,aes(x=variable,y=abs(efecto),fill=efecto>0)) +
##   geom_bar(stat="identity",color="black")+
##   geom_hline(yintercept=efc)+
##   coord_flip()+
##   theme_classic()+
##   theme(legend.position="none")

#' 
#' ----
#' 
## ---- echo = FALSE-------------------------------------------------------
ggplot(efectosO,aes(x=variable,y=abs(efecto),fill=efecto>0)) +
  geom_bar(stat="identity",color="black")+
  geom_hline(yintercept=efc)+
  coord_flip()+
  theme_classic()+
  theme(legend.position="none")

#' 
#' ## Análisis de un diseño factorial - Regresión multilineal
#' 
#' Los mismos resultados que se obtienen por el método de los efectos se pueden obtener mediante una regresión lineal multivariante.
#' 
#' Si los factores se codifican como -1 y 1 (como enteros), los coeficientes que se obtienen son la mitad de los efectos correspondientes. 
#' 
#' ----
#' 
#' Las fórmulas más comunes son
#' 
#' - ```y ~ A+B+C+...``` , solo efectos principales,
#' - ```y ~ (A+B+C+...)^2``` , efectos principales e interacciones de primer orden,
#' - ```y ~ (A+B+C+...)^k``` , efectos principales e interacciones hasta orden *k*-1 (debe sustituirse *k*),
#' - ```y ~ ...+A:B+...``` , incluir una interacción concreta
#' 
#' ----
#' 
#' También puede analizarse el experimento mediante el uso de regresiones con variables ficticias, pero los resultados suelen ser más difíciles de interpretar debido al uso de referencias distintas al promedio experimental.
#' 
#' ----
#' 
## ---- echo = TRUE--------------------------------------------------------
ajuste <- lm(yield~(A+B+C)^3,datos)
summary(ajuste)

#' 
#' ----
#' 
## ---- echo = TRUE--------------------------------------------------------
ajuste <- lm(yield~A+B+C,datos)
summary(ajuste)

#' 
#' ## Ejemplo
#' 
#' Con el objetivo de estudiar el efecto de temperatura (A), pH (B) y velocidad de agitación (C) en el rendimiento de un proceso químico, el ingeniero de planta ha realizado un diseño factorial completo 2<sup>3</sup>.
#' 
#' Los rendimientos obtenidos, en orden de Yates, son los siguientes: 60; 61; 54; 75; 58; 61; 55; 75.
#' 
#' Determina los efectos principales y las interacciones e interpreta los resultados obtenidos.
#' 
#' 
#' Problema adaptado de Box, G. E., Hunter, J. S., & Hunter, W. G. (2005). *Statistics for experimenters: design, innovation, and discovery*. 2nd edition. New York: Wiley-Interscience.
#' 
#' 
#' ## Diseños factoriales completos de más de 2 niveles por factor
#' 
#' La misma lógica de construcción usada para diseños factoriales completos de 2 niveles puede para diseños en los que intervienen factores con más niveles. 
#' 
#' Sin embargo, el coste se incrementa de forma notable y el análisis suele ser algo más complejo.
#' 
#' Si las variables son cuantitativas, suelen evitarse y reservar el estudio de curvaturas para diseño experimental posterior, via diseños específicos o la adición de puntos centrales.
#' 
#' ----
#' 
#' ![](im007.png){style=width:60%;margin-left:-30%;}
#' 
#' <p class="bibref">https://www.itl.nist.gov/div898/handbook/pri/section3/pri339.htm</p>
#' 
#' 
#' ## Diseños factoriales fraccionados
#' 
#' Habida cuenta que en muchos casos consideramos como menos relevantes las interacciones, podemos usar las combinaciones de niveles asociadas a una interacción (ortogonales a los factores) para añadir un nuevo factor y determinar su efecto >>> DISEÑOS FRACCIONADOS
#' 
#' $$ \\
#' 2^{f-c}\\$$
#' 
#' *f*: factores, *c*: factores confundidos
#' 
#' 
#' ## Diseños factoriales fraccionados - Matriz del diseño
#' 
#' Ejemplo: 2<sup>5-1</sup>
#' 
#' - 5 factores
#' - 1 de los cuales confundido
#' - 2<sup>4</sup> condiciones experimentales: 16 experimentos, si no hay repetición
#' - E = ABCD
#' 
#' ----
#' 
#' ![](im008.png){style=width:80%;margin-left:-40%;}
#' 
#' 
#' ## Diseños factoriales fraccionados - Relación de definición
#' 
#' Al incorporar un factor como confundido, se producen efectos que no pueden ser diferenciados.
#' 
#' **Relación de definición de un diseño fraccionado**: Corresponde al producto de factores que da lugar al vector de unidades
#' 
#' - Para 2<sup>5-1</sup> y E = ABCD, I = ABCDE
#' - Para 2<sup>5-2</sup> y E = ABC y D = AB, I = ABD = ABCE = CDE
#' - Para 2<sup>5-2</sup> y E = AB y D = AC, I = ABE = ACD = BCDE
#' - Para 2<sup>7-4</sup> y E = AB, D = AC, F = BC, G = ABC, I = ABE = ACD = BCF = ABCG = BCDE = ACEF = ABDF = CEG = BDG = AFG
#' 
#' ----
#' 
#' <p>&nbsp;</p>
#' 
#' **Resolución de un diseño fraccionado**: Número de factores de la relación de definición del diseño más corta: III, IV, V…
#' 
#' <p>&nbsp;</p>
#' 
#' |     |                                                                                  |
#' |:---:|:---------------------------------------------------------------------------------|
#' | III |Factores principales confundidos con interacciones de dos factores                |
#' | IV  |Factores principales confundidos con interacciones de tres factores. Las interacciones de dos factores estan confundidas entre sí.                                                 |
#' |  V  |Factores principales confundidos son interacciones de cuatro factores. Las interacciones de dos factores pueden determinarse.                                                        |
#' 
#' 
#' ## Diseños factoriales fraccionados - Principales diseños
#' 
#' <style>
#' .container{
#'     display: flex;
#' }
#' .col{
#'     flex: 1;
#' }
#' </style>
#' 
#' <div class="container">
#' 
#' <div class="col">
#' 
#' <table BORDER=3 COLS=3 WIDTH="90%" style="font-size:20px;">
#'   <tr>
#'   <td>
#'   <center><b>Number of Factors, *k*</b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b>Design Specification</b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b>Number of Runs, *N*</b></center>
#'   </td>
#'   </tr>
#'   
#'   <tr>
#'   <td>
#'   <center><b>3</b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b><a href="https://www.itl.nist.gov/div898/handbook/pri/section3/eqns/2to3m1.txt">2<sub>III</sub><sup>3-1</sup></a></b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b>4</b></center>
#'   </td>
#'   </tr>
#'   
#'   <tr>
#'   <td>
#'   <center><b>4</b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b><a href="https://www.itl.nist.gov/div898/handbook/pri/section3/eqns/2to4m1.txt">2<sub>IV</sub><sup>4-1</sup></a></b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b>8</b></center>
#'   </td>
#'   </tr>
#'   
#'   <tr>
#'   <td>
#'   <center><b>5</b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b><a href="https://www.itl.nist.gov/div898/handbook/pri/section3/eqns/2to5m1.txt">2<sub>V</sub><sup>5-1</sup></a></b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b>16</b></center>
#'   </td>
#'   </tr>
#'   
#'   <tr>
#'   <td>
#'   <center><b>5</b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b><a href="https://www.itl.nist.gov/div898/handbook/pri/section3/eqns/2to5m2.txt">2<sub>III</sub><sup>5-2</sup></a></b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b>8</b></center>
#'   </td>
#'   </tr>
#'   
#'   <tr>
#'   <td>
#'   <center><b>6</b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b><a href="https://www.itl.nist.gov/div898/handbook/pri/section3/eqns/2to6m1.txt">2<sub>VI</sub><sup>6-1</sup></a></b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b>32</b></center>
#'   </td>
#'   </tr>
#'   
#'   <tr>
#'   <td>
#'   <center><b>6</b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b><a href="https://www.itl.nist.gov/div898/handbook/pri/section3/eqns/2to6m2.txt">2<sub>IV</sub><sup>6-2</sup></a></b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b>16</b></center>
#'   </td>
#'   </tr>
#'   
#'   <tr>
#'   <td>
#'   <center><b>6</b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b><a href="https://www.itl.nist.gov/div898/handbook/pri/section3/eqns/2to6m3.txt">2<sub>III</sub><sup>6-3</sup></a></b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b>8</b></center>
#'   </td>
#'   </tr>
#' </table>
#' 
#' </div>
#' <div class="col">
#' 
#' <table BORDER=3 COLS=3 WIDTH="90%" style="font-size:20px;">
#'   <tr>
#'   <td>
#'   <center><b>Number of Factors, *k*</b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b>Design Specification</b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b>Number of Runs, *N*</b></center>
#'   </td>
#'   </tr>
#' 
#'   <tr>
#'   <td>
#'   <center><b>7</b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b><a href="https://www.itl.nist.gov/div898/handbook/pri/section3/eqns/2to7m1.txt">2<sub>VII</sub><sup>7-1</sup></a></b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b>64</b></center>
#'   </td>
#'   </tr>
#'   
#'   <tr>
#'   <td>
#'   <center><b>7</b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b><a href="https://www.itl.nist.gov/div898/handbook/pri/section3/eqns/2to7m2.txt">2<sub>IV</sub><sup>7-2</sup></a></b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b>32</b></center>
#'   </td>
#'   </tr>
#'   
#'   <tr>
#'   <td>
#'   <center><b>7</b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b><a href="https://www.itl.nist.gov/div898/handbook/pri/section3/eqns/2to7m3.txt">2<sub>IV</sub><sup>7-3</sup></a></b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b>16</b></center>
#'   </td>
#'   </tr>
#'   
#'   <tr>
#'   <td>
#'   <center><b>7</b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b><a href="https://www.itl.nist.gov/div898/handbook/pri/section3/eqns/2to7m4.txt">2<sub>III</sub><sup>7-4</sup></a></b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b>8</b></center>
#'   </td>
#'   </tr>
#'   
#'   <tr>
#'   <td>
#'   <center><b>8</b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b><a href="https://www.itl.nist.gov/div898/handbook/pri/section3/eqns/2to8m1.txt">2<sub>VIII</sub><sup>8-1</sup></a></b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b>128</b></center>
#'   </td>
#'   </tr>
#'   
#'   <tr>
#'   <td>
#'   <center><b>8</b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b><a href="https://www.itl.nist.gov/div898/handbook/pri/section3/eqns/2to8m2.txt">2<sub>V</sub><sup>8-2</sup></a></b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b>64</b></center>
#'   </td>
#'   </tr>
#'   
#'   <tr>
#'   <td>
#'   <center><b>8</b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b><a href="https://www.itl.nist.gov/div898/handbook/pri/section3/eqns/2to8m3.txt">2<sub>IV</sub><sup>8-3</sup></a></b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b>32</b></center>
#'   </td>
#'   </tr>
#'   
#'   <tr>
#'   <td>
#'   <center><b>8</b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b><a href="https://www.itl.nist.gov/div898/handbook/pri/section3/eqns/2to8m4.txt">2<sub>IV</sub><sup>8-4</sup></a></b></center>
#'   </td>
#'   
#'   <td>
#'   <center><b>16</b></center>
#'   </td>
#'   </tr>
#' </table>
#' 
#' </div>
#' </div>
#' 
#' <p class="bibref">https://www.itl.nist.gov/div898/handbook/pri/section3/pri3347.htm</p>
#' 
#' 
#' ## Ejemplo
#' 
#' En un determinado proceso, se está estudiando el rendimiento de la reacción en función de los parámetros siguientes:
#' 
#' - A: velocidad de alimentación (10 o 15 L/min)
#' - B: catalizador (1 o 2 %)
#' - C: velocidad de agitación (100 o 120 rpm)
#' - D: temperatura (140 o 180 ºC)
#' - E: concentración del reactivo  (30 o 40 %)
#' 
#' ----
#' 
#' <p>&nbsp;</p>
#' 
#' Los valores de los distintos experimentos se encuentran en el archivo 'reactor.csv'.
#' 
#' Selecciona, de estos experimentos, los que corresponden al mínimo diseño que permitiría realizar el estudio, analizalo y compara los resultados con los que se obtienen con el diseño factorial completo.
#' 
#' Problema adaptado de Box, G. E., Hunter, J. S., & Hunter, W. G. (2005). *Statistics for experimenters: design, innovation, and discovery*. 2nd edition. New York: Wiley-Interscience.
#' 
#' 
#' ## Diseños factoriales saturados
#' 
#' Son aquellos diseños factoriales fraccionados de resolución III construidos para la evaluación del mayor número posible de factores
#' 
#' - 2<sup>3-1</sup>  ⇒ 3 factores, 4 experimentos
#' - 2<sup>7-4</sup>  ⇒ 7 factores, 8 experimentos
#' - 2<sup>15-11</sup>  ⇒ 15 factores, 16 experimentos
#' 
#' 
#' ## Diseños de Plackett-Burman
#' 
#' Consisten en diseños saturados (solo permiten evaluar efectos principales) con 4 *k* experimentos
#' 
#' - Se construyen a partir de columnas ortogonales
#'     - Balanceadas
#'     - Bloqueo de los demás factores
#' - Permiten evaluar los efectos de de 4 *k* - 1 factores
#' - Para números de experimentos que son potencias de 2, coinciden con los diseños factoriales fraccionados saturados
#' - En aquellos diseños que no son potencias de 2, las interacciones no se confunden directamente con un factor sino con una combinación lineal de los mismos.
#' 
#' <p class="bibref">https://en.wikipedia.org/wiki/Plackett%E2%80%93Burman_design</p>
#' 
#' 
#' ## Diseños factoriales fraccionados - Siguientes pasos
#' 
#' - Eliminar los factores cuyo efecto no es diferenciable del ruido estadístico
#' - Desplegar (foldover) el diseño fraccionado ampliando el número de experimentos para resolver las confusiones
#'     - En resolución III, imagen especular del diseño
#'     - Cambiar signos en columna/factor
#' - Otros diseños más específicos
#' 
#' <p class="bibref">https://www.itl.nist.gov/div898/handbook/pri/section3/pri338.htm</p>
#' 
#' 
#' <!-- ## Diseños para superfícies de respuesta -->
#' 
#' 
#' <!-- # Investigación *ex-post-facto* -->
#' 
#' 
#' # Referencias
#' 
#' ## 
#' 
#' - ARP9136. Aerospace Series - Root Cause Analysis and Problem Solving (9S Methodology)
#' - Box, G. E., Hunter, J. S., & Hunter, W. G. (2005). *Statistics for experimenters: design, innovation, and discovery*. 2nd edition. New York: Wiley-Interscience.
#' - IEC 60812. Analysis techniques for system reliability – Procedure for failure mode and effects analysis (FMEA)
#' - MIL-STD-1629A. Procedures for performing a failure mode, effects and criticality analysis . http://www.barringer1.com/mil_files/MIL-STD-1629RevA.pdf
#' - MIL-STD-882E. System Safety.
#' https://www.system-safety.org/Documents/MIL-STD-882E.pdf
#' - Montgomery, D. C. (2017). Design and analysis of experiments. John Wiley & Sons.
#' 
#' ----
#' 
#' - NIST/SEMATECH e-Handbook of Statistical Methods, http://www.itl.nist.gov/div898/handbook/, 5-dic-2018
#' - Oehlert, G. W. (2010). A first course in design and analysis of experiments. https://conservancy.umn.edu/bitstream/handle/11299/168002/A%20First%20Course%20in%20Design%20and%20Analysis%20of%20Experiments_OehlertG_2010.pdf
#' - The Pennsylvania State University. STAT 503. https://onlinecourses.science.psu.edu/stat503. 5-dic-2018
#' - TIBCO Software Inc (2018). Design of Experiments: Science, Industrial DOE. http://www.statsoft.com/Textbook/Experimental-Design. 9-dic-2018
#' 
#' 
