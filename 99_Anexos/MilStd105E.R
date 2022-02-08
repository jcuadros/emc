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
## ----setup, include=FALSE--------------------------------------------------
knitr::opts_chunk$set(echo = FALSE, dev="svg")

#' 
## ---- include=FALSE--------------------------------------------------------
if(!require("tidyverse")) {
  install.packages("tidyverse")
  library("tidyverse")
}
if(!require("kableExtra")) {
  install.packages("kableExtra")
  library("kableExtra")
}

#' 
#' ##
#' 
#' <img src="../images/IQSlogo.png" style="border-style:none;box-shadow:none;
#' position:absolute;margin:0;top:20px;left:20px;max-width:200px;height:auto;" />
#' 
#' <div style="font-size:1.5em;font-weight:700;margin-top:200px;">Control estadístico de procesos</div>
#' <div style="font-size:1.4em;font-weight:500;color:#333333;">Military Standard 105E</div>
#' <div style="font-size:1.2em;margin-top:40px;color:#333333;">Jordi Cuadros, Lucinio González</div>
#' <div style="margin-top:80px;color:#333333;">Noviembre de 2018</div>
#' 
#' 
#' # MIL-STD 105E: Muestreo de aceptación por atributos
#' 
#' ## Tabla 1. Código del tamaño de muestra {.smaller}
#' 
## ---- echo = FALSE, results = 'asis'---------------------------------------
df105t1 <- read.table(file="105E_tab1.txt", sep=";", header=TRUE, quote="")
knitr::kable(df105t1)

#' 
#' ## Tabla 2. M. simple >> ins. normal {.smaller}
#' 
## ---- include = FALSE------------------------------------------------------
df105t2 <- read.table(file="105E_tab2a.txt", sep=";", header=TRUE, quote="")
df105t2ls <- read.table(file="105E_tab2a_ls.txt", sep=";", header=TRUE, quote="")

#' 
## ---- echo = FALSE, results = 'asis'---------------------------------------
df105t2r <- inner_join(df105t2, df105t2ls, by = "Letter")
df105t2r <- df105t2r %>% mutate(AcRe=ifelse(LetterSize < Size, "\U21D3",
                         ifelse(LetterSize > Size, "\U21D1",
                                paste(as.character(Ac),
                           as.character(Re), sep=" - "))))
df105t2p <- df105t2r %>%  filter(AQL <= 0.65) %>%
  dplyr::select(-Size,-Ac,-Re) %>%  
  rename(Size=LetterSize) %>%
  spread(AQL,AcRe)
kable_styling(kable(df105t2p), font_size=16)

#' 
#' ## Tabla 2. M. simple >> ins. normal {.smaller}
#' 
## ---- echo = FALSE, results = 'asis'---------------------------------------
df105t2p <- df105t2r %>%  filter(AQL > 0.65 & AQL <= 25) %>%
  dplyr::select(-Size,-Ac,-Re) %>%  
  rename(Size=LetterSize) %>%
  spread(AQL,AcRe)
kable_styling(kable(df105t2p), font_size=16)

#' 
#' ## Tabla 2. M. simple >> ins. normal {.smaller}
#' 
## ---- echo = FALSE, results = 'asis'---------------------------------------
df105t2p <- df105t2r %>%  filter(AQL > 25) %>%
  dplyr::select(-Size,-Ac,-Re) %>%  
  rename(Size=LetterSize) %>%
  spread(AQL,AcRe)
kable_styling(kable(df105t2p), font_size=16)

#' 
#' 
#' ## Tabla 2. M. simple >> ins. estricta {.smaller}
#' 
## ---- include = FALSE------------------------------------------------------
df105t2 <- read.table(file="105E_tab2b.txt", sep=";", header=TRUE, quote="")
df105t2ls <- read.table(file="105E_tab2b_ls.txt", sep=";", header=TRUE, quote="")

#' 
## ---- echo = FALSE, results = 'asis'---------------------------------------
df105t2r <- inner_join(df105t2, df105t2ls, by = "Letter")
df105t2r <- df105t2r %>% mutate(AcRe=ifelse(LetterSize < Size, "\U21D3",
                         ifelse(LetterSize > Size, "\U21D1",
                                paste(as.character(Ac),
                           as.character(Re), sep=" - "))))
df105t2p <- df105t2r %>%  filter(AQL <= 0.65) %>%
  dplyr::select(-Size,-Ac,-Re) %>%  
  rename(Size=LetterSize) %>%
  spread(AQL,AcRe)
kable_styling(kable(df105t2p), font_size=16)

#' 
#' ## Tabla 2. M. simple >> ins. esctricta {.smaller}
#' 
## ---- echo = FALSE, results = 'asis'---------------------------------------
df105t2p <- df105t2r %>%  filter(AQL > 0.65 & AQL <= 25) %>%
  dplyr::select(-Size,-Ac,-Re) %>%  
  rename(Size=LetterSize) %>%
  spread(AQL,AcRe)
kable_styling(kable(df105t2p), font_size=16)

#' 
#' ## Tabla 2. M. simple >> ins. estricta {.smaller}
#' 
## ---- echo = FALSE, results = 'asis'---------------------------------------
df105t2p <- df105t2r %>%  filter(AQL > 25) %>%
  dplyr::select(-Size,-Ac,-Re) %>%  
  rename(Size=LetterSize) %>%
  spread(AQL,AcRe)
kable_styling(kable(df105t2p), font_size=16)

#' 
