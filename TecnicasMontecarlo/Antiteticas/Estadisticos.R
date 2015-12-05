# Master TECI
# Técnicas de Montecarlo
#
# Calculo de estadísticos de variable aleatoria

mediaMuestral <- function(x) {
  m <- 0
  for (i in seq(from = 1, to = length(x))) {
    m <- m + x[i]
  }
  m <- m / length(x)
  return(m)
}

cuasivarianza <- function(x) {
  m <- mediaMuestral(x)
  c <- 0
  for (i in seq(from = 1, to = length(x))) {
    c <- c + (x[i] - m)^2
  }
  c <- c / (length(x) - 1)
  return(c)
}

varianzaMediaMuestral <- function(x) {
  c <- cuasivarianza(x) / length(x)
  return(c)
}

intervaloConfianza95 <- function(x) {
  i <- mediaMuestral(x) - 1.96 * sqrt(varianzaMediaMuestral(x))
  s <- mediaMuestral(x) + 1.96 * sqrt(varianzaMediaMuestral(x))
  return(c(i, s))
}

intervaloConfianza90 <- function(x) {
  i <- mediaMuestral(x) - 1.6449 * sqrt(varianzaMediaMuestral(x))
  s <- mediaMuestral(x) + 1.6449 * sqrt(varianzaMediaMuestral(x))
  return(c(i, s))
}

intervaloConfianza99 <- function(x) {
  i <- mediaMuestral(x) - (2.5758 * sqrt(varianzaMediaMuestral(x)))
  s <- mediaMuestral(x) + (2.5758 * sqrt(varianzaMediaMuestral(x)))
  return(c(i, s))
}