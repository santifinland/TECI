# Simulación Distribución binomial

source("Congruencial.R")

binomial <- function(s, n, p) {
  x <- 0
  for (i in seq(from = 1, to = n)) {
    resultadoCongruencial <- congruencial(s)
    s<- resultadoCongruencial[1]
    u <- resultadoCongruencial[2]
    if (u < p) {
      x <- x + 1
    }
  }
  return(c(x, s))
}

# Probabilidad de la binomial
p <- 0.5

# Longitud de la binomial
n <- 5

# Generamos un valor aleatorio u € [0, 1]
semilla <- 123456789

distBinomial <- numeric(10)
for (i in seq(from = 1, to = 10)) {
  res <- binomial(semilla, n, p)
  distBinomial[i] <- res[1]
  semilla <- res[2]
}

barplot(distBinomial)
hist(distBinomial)
print(distBinomial)


