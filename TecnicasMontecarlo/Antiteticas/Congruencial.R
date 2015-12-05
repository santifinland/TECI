# Master TECI
# Técnicas de montecarlo
# Generadores aleatorios congruenciales

# Imput parameter:
#   seed
# Output paramters:
#   new seed
#   ramdom number

congruencial <- function(x) {
  a <- 16807
  b <- 0
  m <- 2^31 - 1

  yn <- a * x + b
  xn <- yn %% m
  un <- xn / m
  return(c(xn, un))
}



