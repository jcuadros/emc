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
#' <div style="font-size:1.4em;font-weight:500;color:#333333;">Previsión</div>
#' <div style="font-size:1.2em;margin-top:40px;color:#333333;">Jordi Cuadros, Lucinio González</div>
#' <div style="margin-top:80px;color:#333333;">Noviembre de 2018</div>
#' 
#' 
#' # Fundamentos de la previsión
#' 
#' ## Previsión
#' 
#' En la práctica de la gestión (aunque no solo en la industria) a menudo es necesario poder anticipar cuál será el resultado de una determinada situación para poder actuar en previsión.
#' 
#' - Prever las ventas o las compras, es decir, necesidades de producción del próximo periodo.
#' - Prever que pasará ante un cambio de las condiciones de producción.
#' - Anticipar la duración de una pieza o evaluar la posibilidades de fallo de un proceso en función de datos observables.
#' 
#' 
#' ## Aproximaciones metodológicas
#' 
#' - Usar métodos que no requieren el uso de funciones matemáticas porque se basan en el conocimiento de expertos (técnicas cualitativas).
#' - Utilización de procedimientos estadísticos para predecir valores futuros de una serie temporal en base a tendencias históricas (técnicas cuantitativas).
#'     - Uso de funciones modelo: Ajustar una función a los datos y usar esta función para hacer la previsión.
#'     - Técnicas que no usan funciones modelo.
#' - Combinar técnicas cualitativas y cuantitativas
#' 
#' 
#' ## Recomendaciones generales
#' 
#' - Comprobar que la ventana de modelización no incluye cambios estructurales. 
#' - Preferir modelos simples.
#' - No inferir relaciones causa-efecto de los modelos.
#' - El pronóstico siempre lleva asociado un cierto error, esta incertidumbre es mayor cuanto más alejado del momento actual se haga el pronóstico.
#' 
#' ##
#' 
#' - Para reducir la incertidumbre del pronóstico se recomienda combinar varios métodos de pronóstico.
#' - Utilizar el conocimiento experto aunque no sea cuantitativo.
#' - Recalcular el modelo cada vez que se disponga de nuevos datos.
#' 
#' 
#' # Ajuste de modelos
#' 
#' ## Proceso de ajuste de un modelo
#' 
#' - Determinar el modelo adecuado
#'     - A partir del conocimiento de las variables de los datos
#'     - A partir de la forma de los datos
#' - Ajustar el modelo ≡ Determinar los coeficientes del modelo
#'     - Habitualmente usando la técnico de mínimos cuadrados ordinarios (OLS)
#' - Comprobación del modelo y del ajuste
#'     - ¿Representa adecuadamente los datos?
#'     - ¿Los residuales son independientes y siguen una distribución normal?
#'     - ¿Representa adecuadamente datos no usados para construir el modelo?
#' 
#' 
#' ## Ajustes de modelos en R por OLS
#' 
#' Una vez decidido un modelo, el ajuste por el método de mínimos cuadrados ordinarios se realiza usando la notación de fórmulas y la función ```lm```.
#' 
#' ----
#' 
#' ### Notación de fórmulas
#' 
#' Una fórmula en R indica una relación lineal entre variables o combinaciones de variables.
#' 
#' - Recta: ``` y ~ x ```
#' - Recta (sin ordenada en origen): ```y ~ x - 1``` o ```y ~ 0 + x``` 
#' - Expresiones lineales multivariantes: ```y ~ x1 + x2```
#' - Expresiones multivariantes con interacciones: ```y ~ (X1 + x2) ^ 2```
#' - Polinomio: ```y ~ x + I(x ^ 2)``` o ```y ~ poly(x, 3)```
#' - Expresiones no lineales: ```y ~ exp(x)``` o ```log(y) ~ log(x)```
#' 
#' ----
#' 
#' ### Uso de la función ```lm```
#' 
## ---- echo = FALSE-------------------------------------------------------
set.seed(123)

#' 
## ---- echo = TRUE--------------------------------------------------------
x <- seq(1, 2, length.out = 11)
y <- round(3 * x + 5 + rnorm(11) / 10, 3)
datos <- data.frame(x = x, y = y)

#' 
## ---- echo = FALSE-------------------------------------------------------
kable_styling(kable(datos), font_size=24)

#' 
#' ----
#' 
## ---- echo = FALSE-------------------------------------------------------
ggplot(datos, aes(x = x, y = y)) + geom_point() + theme_classic()

#' 
#' ----
#' 
## ---- eval = FALSE, echo = TRUE------------------------------------------
## ajuste <- lm(y ~ x, datos)
## summary(ajuste)

#' 
#' <div style="font-size:24pt;">
#' 
## ---- echo = FALSE-------------------------------------------------------
ajuste <- lm(y ~ x, datos)
summary(ajuste)

#' 
#' </div>
#' 
#' ----
#' 
## ---- echo = TRUE--------------------------------------------------------
datos$yc <- ajuste$fitted

#' 
## ---- echo = FALSE-------------------------------------------------------
kable_styling(kable(datos), font_size=24)

#' 
#' ----
#' 
## ---- eval = FALSE, echo = TRUE------------------------------------------
## ggplot(datos, aes(x = x, y = y)) +
##   geom_point() +
##   geom_line(aes(y = yc)) +
##   theme_classic()

#' 
#' ----
#' 
## ---- echo = FALSE-------------------------------------------------------
ggplot(datos, aes(x = x, y = y)) +
  geom_point() +
  geom_line(aes(y = yc)) + 
  theme_classic()

#' 
#' ## Análisis estadístico de los modelos de ajuste
#' 
#' Un ajuste es adecuado si
#' 
#' <div style="font-size:20pt;">
#' 
#' - Se ajusta a los valores experimentales y su funcionalidad
#'     - Gráfico con el modelo ajustado
#'     - Análisi de los residuales
#'         - Residuales sin funcionalidad y centrado en cero
#'     - Prueba F
#' - No hay puntos excesivamente influyentes
#'     - Vigilar con los puntos anómalos y los puntos extremos
#' - Los errores están normalmente distribuidos
#'     - Prueba de normalidad de los residuales
#'     - Gráfico de normalidad de los residuales
#' - Sus coeficientes son significativos
#'     - Estadísticamente
#'     - Teóricamente / científicamente
#' 
#' </div>
#' 
#' ----
#' 
## ---- echo = FALSE-------------------------------------------------------
ggplot(datos, aes(x = x, y = y)) +
  geom_point() +
  geom_line(aes(y = yc)) + 
  theme_classic()

#' 
#' ----
#' 
## ---- eval = FALSE, echo = TRUE------------------------------------------
## summary(ajuste)

#' 
#' <div style="font-size:24pt;">
#' 
## ---- echo = FALSE-------------------------------------------------------
summary(ajuste)

#' 
#' </div>
#' 
#' ----
#' 
## ---- echo = TRUE, eval = FALSE------------------------------------------
## plot(ajuste, which=1:2)

#' 
#' ----
#' 
## ---- echo = FALSE-------------------------------------------------------
plot(ajuste, which=1)

#' 
#' ----
#' 
## ---- echo = FALSE-------------------------------------------------------
plot(ajuste, which=2)

#' 
#' ----
#' 
## ---- echo = TRUE--------------------------------------------------------
shapiro.test(ajuste$residuals)

#' 
#' ## Predicción
#' 
#' Si el modelo es correcto (y solo en este caso), este puede usarse para estimar valores de la variable dependiente.
#' 
## ---- echo = TRUE--------------------------------------------------------
predict(ajuste,data.frame(x = c(1.12,1.23)))

#' 
#' ----
#' 
#' A esta predicción puede añadirse intervalos de confianza (por defecto, a un nivel de confianza del 95 %). Estos se calculan de forma distinta cuando se quiere predecir el valor medio (mejor estimación) o un nuevo dato.
#' 
#' Si x es 1,12, la estimación del promedio es
#' 
## ---- echo = TRUE--------------------------------------------------------
predict(ajuste,data.frame(x = c(1.12)), interval="confidence")

#' 
#' y la estimación para un nuevo dato es
#' 
## ---- echo = TRUE--------------------------------------------------------
predict(ajuste,data.frame(x = c(1.12)), interval="prediction")

#' 
#' 
#' ## Ejemplo
#' 
#' A partir de los datos que figuran en el archivo "cu.txt", determina el coeficiente de expansión térmica del cobre (*k*) a las temperaturas (*T*) de 600 K y de 200 K.
#' 
#' <p>&nbsp;</p>
#' 
#' <p class="bibref">http://www.itl.nist.gov/div898/handbook/pmd/section6/pmd641.htm </p>
#' 
#' 
#' # Ajuste de series temporales
#' 
#' ## Serie temporal
#' 
#' Se denomina serie temporal a una secuencia de puntos indexados temporalmente. Es decir, obtenidos a intervalos de tiempo constantes.
#' 
#' En estos casos, el índice temporal (o posición) se incorpora como variable de modelización. El tiempo no se usa como variable independiente.
#' 
#' 
#' 
#' Solo se presentará el tratamiento del ajuste de serie temporales completas.
#' 
#' 
#' ## Fuentes de variación en una serie temporal
#' 
#' - **Tendencia**. Evolución de los datos a largo plazo
#' - **Estacionalidad**. Variaciones estacionales a corto plazo (periodo de menos de un año)
#'     - Día de la semana
#'     - Día del mes
#'     - Día del año
#'     - Semana del año
#'     - Semana del mes
#'     - Mes del año
#' - Componentes **aleatorios** no previsibles
#' - **Autocorrelación**. Dependencia de los periodos inmediatamente anteriores.
#' 
#' 
#' ## Previsión en series temporales (pronóstico, *forecasting*)
#' 
#' - Ajuste de modelos (con variables fictícias)
#' - Métodos de previsión sin funciones de ajuste (para datos desestacionalizados)
#' 
#' 
#' # Pronóstico mediante ajuste de modelos
#' ## Ejemplo
#' 
#' Sean las ventas de un determinado producto entre enero de 2013 y mediados de julio de 2016 las que figuran en el archivo "ventas.csv", ¿cuál seria una previsión razonable de las ventas de julio y agosto de 2016?
#' 
#' 
## ---- echo = FALSE, results = 'asis'-------------------------------------
datos <- read.table("ventas.csv", header=TRUE, dec=",",sep=";")
kable_styling(kable(head(datos)), font_size=24)

#' 
#' ----
#' 
#' ### Visualización de los datos
#' 
## ---- echo = TRUE, eval = FALSE------------------------------------------
## datos$fecha <- paste(datos$ano,
##                      formatC(datos$mes, width=2,
##                              format="d", flag="0"),
##                      sep="-")
## ggplot(datos,aes(x=fecha,y=ventas,group=1)) + geom_line() +
##   theme_classic()+
##   theme(axis.text.x = element_text(angle=90,vjust=0.5))

#' 
#' ----
#' 
## ---- echo = FALSE-------------------------------------------------------
datos$fecha <- paste(datos$ano,
                     formatC(datos$mes, width=2,
                             format="d", flag="0"),
                     sep="-")
ggplot(datos,aes(x=fecha,y=ventas,group=1)) + geom_line() +
  theme_classic()+
  theme(axis.text.x = element_text(angle=90,vjust=0.5))

#' 
#' ## Modelos habituales (sin estacionalidad)
#' 
#' - Constante ( ```y ~ 1``` )
#' - Recta ( ```y ~ x``` )
#' - Recta sin ordenada ( ```y ~ 0 + x``` )
#' 
#' También pueden usarse funciones no lineales (polinomios, logaritmos, exponenciales...).
#' 
#' 
#' ## Ajuste de una constante
#' 
## ---- echo = TRUE, eval = FALSE------------------------------------------
## datosAj <- datos[1:42,]
## datosAj$i <- 1:42
## datosAj <- rbind(datosAj,
##                  list(ano=c(2016,2016),
##                       mes=7:8,
##                       ventas=c(NA,NA),
##                       fecha=c("2016-07","2016-08"),
##                       i=43:44))
## 
## ajuste <- lm(ventas~1, datosAj[1:42,])
## 
## datosAj <- cbind(datosAj,
##                  predict(ajuste, datosAj, interval="prediction"))

#' 
#' ----
#' 
## ---- echo = TRUE, eval = FALSE------------------------------------------
## ggplot(datosAj,aes(x=fecha,y=ventas,group=1)) + geom_line() +
##   geom_line(aes(y=fit), col="green")+
##   geom_ribbon(aes(ymin=lwr, ymax=upr), fill="green", alpha=0.05)+
##   theme_classic()+
##   theme(axis.text.x = element_text(angle=90,vjust=0.5))
## 

#' 
#' ----
#' 
## ---- echo = FALSE, warning = FALSE--------------------------------------
datosAj <- datos[1:42,]
datosAj$i <- 1:42
datosAj <- rbind(datosAj,
                 list(ano=c(2016,2016),
                      mes=7:8,
                      ventas=c(NA,NA),
                      fecha=c("2016-07","2016-08"),
                      i=43:44))

ajuste <- lm(ventas~1, datosAj[1:42,])

datosAj <- cbind(datosAj,
                 predict(ajuste, datosAj, interval="prediction"))

ggplot(datosAj,aes(x=fecha,y=ventas,group=1)) + geom_line() +
  geom_line(aes(y=fit), col="green")+
  geom_ribbon(aes(ymin=lwr, ymax=upr), fill="green", alpha=0.05)+
  theme_classic()+
  theme(axis.text.x = element_text(angle=90,vjust=0.5))


#' 
#' ----
#' 
## ---- echo = TRUE--------------------------------------------------------

print(datosAj[43:44,c(4,6:8)])


#' 
#' ## Ajuste de una recta
#' 
## ---- echo = TRUE, eval = FALSE------------------------------------------
## datosAj <- datos[1:42,]
## datosAj$i <- 1:42
## datosAj <- rbind(datosAj,
##                  list(ano=c(2016,2016),
##                       mes=7:8,
##                       ventas=c(NA,NA),
##                       fecha=c("2016-07","2016-08"),
##                       i=43:44))
## 
## ajuste <- lm(ventas~i, datosAj[1:42,])
## 
## datosAj <- cbind(datosAj,
##                  predict(ajuste, datosAj, interval="prediction"))

#' 
#' ----
#' 
## ---- echo = TRUE, eval = FALSE------------------------------------------
## ggplot(datosAj,aes(x=fecha,y=ventas,group=1)) + geom_line() +
##   geom_line(aes(y=fit), col="green")+
##   geom_ribbon(aes(ymin=lwr, ymax=upr), fill="green", alpha=0.05)+
##   theme_classic()+
##   theme(axis.text.x = element_text(angle=90,vjust=0.5))
## 

#' 
#' ----
#' 
## ---- echo = FALSE, warning = FALSE--------------------------------------
datosAj <- datos[1:42,]
datosAj$i <- 1:42
datosAj <- rbind(datosAj,
                 list(ano=c(2016,2016),
                      mes=7:8,
                      ventas=c(NA,NA),
                      fecha=c("2016-07","2016-08"),
                      i=43:44))

ajuste <- lm(ventas~i, datosAj[1:42,])

datosAj <- cbind(datosAj,
                 predict(ajuste, datosAj, interval="prediction"))

ggplot(datosAj,aes(x=fecha,y=ventas,group=1)) + geom_line() +
  geom_line(aes(y=fit), col="green")+
  geom_ribbon(aes(ymin=lwr, ymax=upr), fill="green", alpha=0.05)+
  theme_classic()+
  theme(axis.text.x = element_text(angle=90,vjust=0.5))


#' 
#' ----
#' 
## ---- echo = TRUE--------------------------------------------------------

print(datosAj[43:44,c(4,6:8)])


#' 
#' 
#' ## Incorporar la estacionalidad
#' 
#' La estacionalidad se incorpora a los modelos a través de variables ficticias
#' 
#' - Se decide el periodo y el paso de la periodicidad
#'     - Día en mes
#'     - Día en semana
#'     - Mes en año
#'     - Trimestre en año
#' - Se usa una variable ficticia (lógica, 0 o 1) para cada elemento del periodo
#' - Se introducen al modelo todas las variables ficticias excepto una (que corresponderá a la referencia del modelo).
#' 
#' 
#' ## Modelizar la estacionalidad en R
#' 
#' - Definir una variable para la estacionalidad (valores cíclicos).
#' - Se establece esta variable como factor y se introduce como variable del modelo.
#' 
#' 
#' ## Ajuste de una recta más una periodicidad anual (por meses)
#' 
## ---- echo = TRUE, eval = FALSE------------------------------------------
## datosAj <- datos[1:42,]
## datosAj$i <- 1:42
## datosAj <- rbind(datosAj,
##                  list(ano=c(2016,2016),
##                       mes=7:8,
##                       ventas=c(NA,NA),
##                       fecha=c("2016-07","2016-08"),
##                       i=43:44))
## datosAj$mes <- factor(datosAj$mes)
## 
## ajuste <- lm(ventas~i+mes, datosAj[1:42,])
## 
## datosAj <- cbind(datosAj,
##                  predict(ajuste, datosAj, interval="prediction"))

#' 
#' ----
#' 
## ---- echo = TRUE, eval = FALSE------------------------------------------
## ggplot(datosAj,aes(x=fecha,y=ventas,group=1)) + geom_line() +
##   geom_line(aes(y=fit), col="green")+
##   geom_ribbon(aes(ymin=lwr, ymax=upr), fill="green", alpha=0.05)+
##   theme_classic()+
##   theme(axis.text.x = element_text(angle=90,vjust=0.5))
## 

#' 
#' ----
#' 
## ---- echo = FALSE, warning = FALSE--------------------------------------
datosAj <- datos[1:42,]
datosAj$i <- 1:42
datosAj <- rbind(datosAj,
                 list(ano=c(2016,2016),
                      mes=7:8,
                      ventas=c(NA,NA),
                      fecha=c("2016-07","2016-08"),
                      i=43:44))
datosAj$mes <- factor(datosAj$mes)

ajuste <- lm(ventas~i+mes, datosAj[1:42,])

datosAj <- cbind(datosAj,
                 predict(ajuste, datosAj, interval="prediction"))

ggplot(datosAj,aes(x=fecha,y=ventas,group=1)) + geom_line() +
  geom_line(aes(y=fit), col="green")+
  geom_ribbon(aes(ymin=lwr, ymax=upr), fill="green", alpha=0.05)+
  theme_classic()+
  theme(axis.text.x = element_text(angle=90,vjust=0.5))


#' 
#' ----
#' 
## ---- echo = TRUE--------------------------------------------------------

print(datosAj[43:44,c(4,6:8)])


#' 
#' ----
#' 
#' ### Comprobación del ajuste
#' 
## ---- echo = TRUE--------------------------------------------------------
summary(ajuste)

#' 
#' ----
#' 
## ---- echo = TRUE, eval = FALSE------------------------------------------
## plot(ajuste, which = 1:2)

#' 
#' 
#' ----
#' 
## ---- echo = FALSE-------------------------------------------------------
plot(ajuste, which = 1)

#' 
#' 
#' ----
#' 
## ---- echo = FALSE-------------------------------------------------------
plot(ajuste, which = 2)

#' 
#' ----
#' 
## ---- echo = TRUE--------------------------------------------------------
shapiro.test(ajuste$residuals)

#' 
#' # Pronósticos a corto plazo (para datos desestacionalizados)
#' 
#' ## Datos desestacionalizados
#' 
#' - No tienen tendencia ni funcionalidad.
#' - No presentan variabilidad estacional.
#' 
#' Presentan autocorrelación, es decir dependencia de los valores anteriores.
#' 
#' 
#' ## Métodos simples para predecir a corto plazo
#' 
#' - Método Naïve (o Naïve I)
#' - Método Naïve II
#' - Método de la media móvil simple
#' 
#' 
#' ## Método Naïve
#' 
#' Consiste en pronosticar el siguiente valor de la serie temporal como igual al último valor disponible en la misma
#' 
#' $$
#' \\ \hat y_{n+1} = y_n
#' $$
#' 
#' 
#' ## Método Naïve II
#' 
#' Consiste en pronosticar el siguiente valor de la serie temporal como igual al último valor disponible en la misma más un término dependiente de la variación entre los dos valores anteriores.
#' 
#' $$
#' \\ \hat y_{n+1} = y_n + k (y_n - y_{n+1})
#' $$
#' 
#' Si *k* vale 1, consiste en el ajuste de una recta a los dos datos anteriores.
#' 
#' 
#' ## Media móvil simple
#' 
#' Consiste en pronosticar el siguiente valor de la serie temporal como media de los *m* valores anteriores.
#' 
#' $$
#' \\ \hat{y}_{n+1} = \sum\limits_{i=n-m+1}^{n} \frac{y_i}{m}
#' $$
#' 
#' 
#' ## Comprobación del ajuste
#' 
#' El ajuste se puede comprobar aplicando el método a los valores anteriores de la serie y calculando los residuales correspondientes.
#' 
#' El análisis de residuales sigue siendo válido en estos casos.
#' 
#' 
#' ## Estimación del intervalo de predicción
#' 
#' Si los residuales estan normalmente distribuidos, el intervalo de predicción puede calcularse a partir de la desviación estándar de los residuales.
#' 
#' $$
#' \\ y = \hat y \pm z_{1-\alpha/2} \  s_{res}
#' $$
#' 
#' 
#' ## Ejemplo
#' 
#' Disponemos de los precios históricos (promedios mensuales) de uno de los productos de partida de nuestro proceso de fabricación, ¿podemos estimar el precio que nos costará este recurso en el siguiente mes?
#' 
#' Los datos figuran en el archivo "coconutOil.txt".
#' 
#' 
#' # Criterios de error para la comparación de modelos
#' 
#' ## 
#' 
#' Para establecer la calidad de un modelo y tener criterios que permitan comparar modelos, se usan distintos indicadores
#' 
#' - Coeficiente de determinación ajustado, *R*<sup>2</sup>
#' - Distintas medidas del error, calculadas a partir
#' de los residuales (MAPE/MAPD , MSE/MSD...)
#' 
#' <p>&nbsp;</p>
#' 
#' <p class="bibref">https://support.minitab.com/en-us/minitab/17/topic-library/modeling-statistics/time-series/time-series-models/what-are-mape-mad-and-msd/</p>
#' 
#' 
#' # Referencias adicionales
#' 
#' - Hyndman, R.J.; Athanasopoulos, G. (2018). Forecasting: Principles and Practice,http://otexts.org/fpp2/
#' - NIST/SEMATECH (2013). NIST/SEMATECH. e-Handbook of Statistical Methods, http://www.itl.nist.gov/div898/handbook
#' - ForPrin (2018). The Forecasting Principles, http://www.forecastingprinciples.com/
