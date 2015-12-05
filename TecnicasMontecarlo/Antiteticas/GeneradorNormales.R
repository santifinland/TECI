# Master TECI
# Técnicas de Montecarlo
#
# Generacion de normales usando Box Muller
# y Box Muller con antitéticas

library(ggplot2)
source("BoxMuller.R")
source("BoxMullerAntitetica.R")
source("Estadisticos.R")

s <- 123456789;

generadorNormales <- function(semilla, longitud, antitetica) {
  normalSeno <- numeric(longitud)
  normalCoseno <- numeric(longitud)
  for (i in seq(from = 1, to = longitud)) {
    if (!antitetica) {
      b <- boxMuller(semilla, 0, 1)
    } else {
      b <- boxMullerAntitetica(semilla, 0, 1)
    }
    normalSeno[i] <- b[2]
    normalCoseno[i] <- b[1]
    semilla <- b[3]
  }
  return(list(normalSeno, normalCoseno, semilla))
}
  
histograma <- function(datos, titulo) {
  df <- data.frame(y = datos)
  g <- ggplot(df, aes(y)) +
    geom_histogram(binwidth=0.1) +
    xlim(-3.5, 3.5) +
    xlab(titulo) + ylab("Frecuencia") +
    ggtitle(paste("Distribucion", titulo)) +
    theme_bw()
    return(g)
}

estadisticos <- function(datos, titulo) {
  e <- data.frame(mediaMuestral = mediaMuestral(datos),
                  cuasivarianza = cuasivarianza(datos),
                  varianzaMediaMuestral = varianzaMediaMuestral(datos),
                  intervaloConfianza95 = intervaloConfianza95(datos))
  return(e)
}

generarNormales <- function() {
  normales <- generadorNormales(s, 2000, FALSE)
  normalSeno <- histograma(normales[[1]], "Seno")
  normalCoseno <- histograma(normales[[2]], "Coseno")

  antiteticas <- generadorNormales(s, 2000, TRUE)
  antiteticaSeno <- histograma(antiteticas[[1]], "Antitetica Seno")
  antiteticaCoseno <- histograma(antiteticas[[2]], "Antitetica Coseno")

  plot(normalSeno)
  plot(normalCoseno)
  plot(antiteticaSeno)
  plot(antiteticaCoseno)

  print(estadisticos(normales[[1]]))
  print(estadisticos(normales[[2]]))
  print(estadisticos(antiteticas[[1]]))
  print(estadisticos(antiteticas[[2]]))

  print(cov(normales[[1]], normales[[2]]))
  print(cov(antiteticas[[1]], antiteticas[[2]]))
  print(cov(normales[[1]], antiteticas[[1]]))
  print(cov(normales[[1]], antiteticas[[2]]))
  print(cov(normales[[2]], antiteticas[[1]]))
  print(cov(normales[[2]], antiteticas[[2]]))
  
  combinadasSeno <- c(normales[[1]], antiteticas[[1]])
  combinadasCoseno <- c(normales[[2]], antiteticas[[2]])
  combinadasSenoHistograma <- histograma(combinadasSeno, "Combinadas Seno")
  combinadasCosenoHistograma <- histograma(combinadasCoseno, "Combinadas Coseno")
  plot(combinadasSenoHistograma)
  plot(combinadasCosenoHistograma)
  print(estadisticos(combinadasSeno))
  print(estadisticos(combinadasCoseno))
  return(combinadasSeno)
}
