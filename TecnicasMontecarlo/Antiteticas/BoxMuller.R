# Master TECI
# Técnicas de Montecarlo
# Función Box Muller

# Imput parameter:
#  seed
# Output paramters:
#  x, y

source("Congruencial.R")

boxMuller <- function(s, m, v) {
  c1 <- congruencial(s)
  c2 <- congruencial(c1[1])
  n1 <- sqrt(-2 * log(c1[2])) * cos(2 * pi * c2[2])
  n2 <- sqrt(-2 * log(c1[2])) * sin(2 * pi * c2[2])
  
  n1 <- n1 * v + m
  n2 <- n2 * v + m
  return(c(n1, n2, c2[1]))
}
