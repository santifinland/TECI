# Master TECI
# Técnicas de Montecarlo
#
# Generacion de normales usando Box Muller
# y Box Muller con antitéticas

library(ggplot2)
source("Estadisticos.R")
source("GeneradorNormales.R")

semilla <- 123456789
longitud <- 100
f <- 0

for (i in seq(from = 1, to = 100)) {
  normales <- generadorNormales(semilla, 100, FALSE)
  semilla <- normales[[3]]
  normalSeno <- normales[[1]]
  intervalo <- intervaloConfianza90(normalSeno)
  intervalo <- intervaloConfianza95(normalSeno)
  intervalo <- intervaloConfianza99(normalSeno)
  media <- mean(normalSeno)
  if (intervalo[1] > 0 || intervalo[2] < 0) {
    f <- f + 1
  }
}

print(f)