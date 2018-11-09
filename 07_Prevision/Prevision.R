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
