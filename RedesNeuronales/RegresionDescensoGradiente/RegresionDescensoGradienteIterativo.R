# Descenso en la dirección del gradiente
rm(list=ls())

# Carga de librerías
library(ggplot2)

# Datos a ajustar. n muestras en intervalo [-1, 1]
ns <- c(100)
E <- matrix(0, 4, 4) # Vector para almacenar el error cuadrático medio
T <- matrix(0, 4, 4) # Vector para almacenar el tiempo consumido
e <- 0 
for (n in ns) {
e <- e + 1
x0 <- rep(c(1), n)
x1 <- runif(n = n, min = -1, max = 1)
X <- as.matrix(cbind(x0, x1))
error <- rnorm(n = n, 0, 0.5)
Y <- as.matrix(x0 + x1 + error)

# Solución cerrada
datos <- data.frame(x = X[,2], y = Y)
sc <- lm(y ~ x, data = datos)
g0 <- ggplot(datos, aes(x, y)) +
  geom_point(alpha = 1) +
  geom_abline(intercept = sc$coefficients[1], slope = sc$coefficients[2], col = "black") +
  xlab("X") + ylab("Y") +
  ggtitle("Regresión lineal") +
  theme_bw()

# Descenso en la dirección del gradiente (incremental o estocástico)
etas <- c(0.9, 0.1, 0.01)
W <- c(rnorm(1), rnorm(1))
comparaciones <- data.frame()
for (eta in etas) {
  start.time <- Sys.time()
  for (i in 1:n) {
    J <- rep(0, n) # Vector para almacenar los valores que toma la función de coste
    I <- rep(0, n) # Vector para almacenar los valores que toma el indicador de iteraci
    C <- rep(0, n) # Vector para almacenar los valores que toma el color
    # Inicializamos el error de ajuste
    delta <- (Y[i,] - (t(X[i,]) %*% W)) * X[i,]
    for (j in 1:n) {
      J[i] <- J[i] +  ((t(X[j,]) %*% W) - Y[j,])^2 # Cálculo de la función de cost
    }
    # Actualizamos W
    W <- W + eta * delta
    I[i] <- i 
    J[i] <- J[i] / (2 * n) # Valor de la función de coste para esta iteració
    if (eta == 0.9) { g0 <- g0 + geom_abline(intercept = W[1], slope = W[2], col="red", alpha = 0.3) }
    if (eta == 0.1) { g0 <- g0 + geom_abline(intercept = W[1], slope = W[2], col="green", alpha = 0.3) }
    if (eta == 0.01) { g0 <- g0 + geom_abline(intercept = W[1], slope = W[2], col="blue", alpha = 0.3) }
    if (eta == 0.9) { comparaciones <- rbind(comparaciones, data.frame(I, J, C = "red")) } 
    if (eta == 0.1) { comparaciones <- rbind(comparaciones, data.frame(I, J, C = "green")) } 
    if (eta == 0.01) { comparaciones <- rbind(comparaciones, data.frame(I, J, C = "blue")) } 
  }
  if (eta == 0.9) { g0 <- g0 + geom_abline(intercept = W[1], slope = W[2], col="red") }
  if (eta == 0.1) { g0 <- g0 + geom_abline(intercept = W[1], slope = W[2], col="green") }
  if (eta == 0.01) { g0 <- g0 + geom_abline(intercept = W[1], slope = W[2], col="blue") }
  end.time <- Sys.time()
  if (eta == 0.9) { E[e, 1] <- J[i]; T[e, 1] <- end.time - start.time }
  if (eta == 0.1) { E[e, 2] <- J[i]; T[e, 2] <- end.time - start.time }
  if (eta == 0.01) { E[e, 3] <- J[i]; T[e, 3] <- end.time - start.time }
  if (eta == 0.001) { E[e, 4] <- J[i]; T[e, 4] <- end.time - start.time }
}
print(g0)

g1 <- ggplot(comparaciones, aes(I, J, colour=C)) +
  geom_point(alpha = 1) +
  xlim(0, n) + ylim(0, 3000) +
  scale_colour_manual(name  ="Tasa de aprendizaje", values= c("red", "green", "blue"), labels=c("0.9", "0.1", "0.01")) +
  xlab("Iteraciones") + ylab("Error cuadrático (Escala logarítmica)") +
  ggtitle("Minimización del error cuadrático medio") +
  scale_y_log10() +
  theme_bw()
print(g1)
}