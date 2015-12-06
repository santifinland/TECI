# Simulación Distribución geometrica

source("Congruencial.R")

geometrica <- function(s, p) {
  x <- 0
  while (TRUE) {
    resultadoCongruencial <- congruencial(s)
    s<- resultadoCongruencial[1]
    u <- resultadoCongruencial[2]
    if (u < p) {
      x <- x + 1
    } else break
  }
  return(c(x, s))
}

# Probabilidad de la geometrica
p <- 0.3

# Generamos un valor aleatorio u € [0, 1]
semilla <- 123456789

distGeometrica <- numeric(100)
for (i in seq(from = 1, to = 100)) {
  res <- geometrica(semilla, p)
  distGeometrica[i] <- res[1]
  semilla <- res[2]
}

barplot(distGeometrica)
hist(distGeometrica)
print(distGeometrica)

