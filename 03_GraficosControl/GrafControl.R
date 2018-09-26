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
#' <div style="font-size:1.4em;font-weight:500;color:#333333;">Gráficos de control</div>
#' <div style="font-size:1.2em;margin-top:40px;color:#333333;">Jordi Cuadros, Lucinio González</div>
#' <div style="margin-top:80px;color:#333333;">Setiembre de 2018</div>
#' 
#' 
#' # Introducción a los gráficos de control
#' 
#' ## Variabilidad y control estadístico
#' 
#' - Todo proceso tiene una **variabilidad natural** inherente al mismo.
#' - Un proceso que solo presenta variabilidad natural se dice que está **bajo control estadístico**.
#' - Si existen **causas especiales de variabilidad**, se deben **eliminar** una a una, de forma que al final solo quede la variabilidad natural del proceso y el proceso esté bajo control estadístico.
#' - Si se han eliminado los errores sistemáticos (que derivan de causas especiales), **la media de un conjunto de medidas repetidas** (muestra) es la mejor estimación que se puede realizar del verdadero valor de la medida (valor real).
#' 
#' 
#' ## Gráficos de control
#' 
#' Un gráfico de control es una representación gráfica (gráfico de secuencia) de un característica (cuantitativa -variable- o cualitativa -atributo-) de un proceso en función de un índice de secuencia (tiempo).
#' 
#' Fueron propuestos por Shewhart en 1924.
#' 
#' <p>&nbsp;</p>
#' 
#' <p class="bibref">Shewhart, W. A. (1924). Some applications of statistical methods to the analysis of physical and engineering data. *Bell System Technical Journal*, 3(1), 43-87</p>
#' 
#' ----
#' 
#' ![](im001.png)
#' 
#' 
#' <!-- LC: Línea central<br /> -->
#' <!-- LSC: Límite superior de control<br /> -->
#' <!-- LIC: Límite inferior de control<br /> -->
#' 
#' 
#' ## Funciones de los gráficos de control
#' 
#' - Ayudan a mejorar la productividad (menos no conformes)
#' - Ayudan a prevenir defectos
#' - Evitan ajustes innecesarios del proceso (es capaz de distinguir entre variabilidad natural y variabilidad por causas especiales)
#' - Facilitan información para la detección de causas especiales (formas no aleatorias características)
#' - Permiten la evaluación de la capacidad del proceso
#' 
#' 
#' ## Tipos de gráficos de control
#' 
#' 
#' - Para variables (numéricas)
#'   
#'   | Tendencia central | Dispersión        |
#'   |:------------------|:------------------|
#'   | Gráfico Xbarra    | Gráfico s         |
#'   | Gráfico I         | Gráfico R (MR)    |
#'   
#'   
#' - Para atributos
#'   
#'   | Unidades defectuosas  | Defectos          |
#'   |:----------------------|:------------------|
#'   | Gráfico np            | Gráfico c         |
#'   | Gráfico p             | Gráfico u         |
#'   
#' 
#' ## Criterios de selección
#' 
#' ![](im002.png)
#' 
#' <p class="bibref">https://www.isixsigma.com/tools-templates/control-charts/a-guide-to-control-charts/</p>
#' 
#' 
#' ## Subgrupos racionales
#' 
#' Casi todos los gráficos de Shewhart se basan en subgrupos (subgrupos racionales o muestras)
#' 
#' El tamaño de los subgrupos debe ser tal que si hay causas asignables no se manifiesten dentro de los subgrupos y su efecto sea máximo entre grupos.
#' 
#' Habitualmente se trabaja con muestras de tamaño entre 2 y 10 (siendo 4 o 5, los tamaños de muestra más habituales).
#' 
#' ----
#' 
#' ![](im003.png)
#' 
#' <p class="bibref">https://www.isixsigma.com/tools-templates/control-charts/a-guide-to-control-charts/</p>
#' 
#' ----
#' 
#' ![](im004.png)
#' 
#' <p class="bibref">https://www.isixsigma.com/tools-templates/control-charts/a-guide-to-control-charts/</p>
#' 
#' 
#' # Uso e interpretación de un gráfico de control
#' 
#' ## Control estadístico
#' 
#' ![](im005.gif)
#' 
#' ----
#' 
#' Si el proceso está bajo control estadístico en su gráfico de control se puede observar que:
#' 
#' - Los valores individuales no son constantes, pero se distribuyen al azar (distribución normal)
#' - Se mantienen constantes a largo plazo la **media** (nivel) y la **desviación estándar** (variabilidad) 
#' 
#' No se observan:
#' 
#' -	valores atípicos,
#' - cambios en el nivel, 
#' - cambios en la variabilidad
#' - tendencias, movimientos periódicos, autocorrelación...
#' 
#' 
#' ## Límites de control
#' 
#' ![](im006.png)
#' 
#' <p class="bibref">https://www.isixsigma.com/tools-templates/control-charts/using-control-charts-or-pre-control-charts/</p>
#' 
#' 
#' ## Reglas de Western Electric
#' 
#' ![](im007.png)
#' 
#' <p class="bibref">Western Electric Company. (1956). *Statistical quality control handbook*. Western Electric Company.</p>
#' 
#' 
#' ## Reglas de Nelson
#' 
#' ![](im008.png)
#' 
#' 
#' ----
#' 
#' ![](im009.png)
#' 
#' <p class="bibref">Nelson, L. S. (1984). The Shewhart control chart—tests for special causes. *Journal of quality technology*, 16(4), 237-239.</p>
#' 
#' 
#' ## Más reglas (o menos)
#' 
#' ![](im010.png)
#' 
#' <p class="bibref">https://www.qimacros.com/control-chart/western-electric-rules/</p>
#' 
#' 
#' ## ¿Qué reglas usar?
#' 
#' - Las reglas (1 y 2 de Nelson) suelen usarse siempre tanto para nivel como para variabilidad.
#' - Las reglas basadas en zonas no suelen aplicarse a los gráficos de variabilidad.
#' - Añadir más reglas o disminuir el nivel de alerta, incrementa el riesgo de error de tipo I y disminuye el riesgo de error de tipo II.
#' 
#' ![](im011.png){style=width:80%;margin-left:-40%;}
#' 
#' 
#' ## ¿Cuándo actuar?
#' <p class="bibref">Western Electric Company. (1956). *Statistical quality control handbook*. Western Electric Company.</p>
#' 
#' ![](im012.png){style=width:50%;margin-left:-25%;}
#' 
#' 
#' <!-- # Construcción de gráficos de control -->
#' 
#' 
#' 
#' 
#' 
