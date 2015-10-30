# Master TECI
# Técnicas de regresión y predicción
# Práctica 1: extrapolación oculta

# Importamos las librarías necesarias
library("ggplot2")

# Datas las siguientes muestras de las variables regresoras
x1 <- c(783.35, 748.45, 684.45, 827.80, 860.45, 875.15, 909.45, 905.55, 756.00, 769.35, 793.50, 801.65, 819.65, 808.55, 774.95, 711.85, 694.85, 638.10, 774.55, 757.90, 753.35,704.70, 666.80, 568.55, 653.10, 704.05, 709.60, 726.90, 697.15)
x2 <- c(16.66, 16.46, 17.66, 17.50, 16.40, 16.28, 16.06, 15.93, 16.60, 16.41, 16.17, 15.92, 16.04, 16.19, 16.62, 17.37, 18.12, 18.53, 15.54, 15.70, 16.45, 17.62, 18.12, 19.05, 16.51, 16.02, 15.89, 15.83, 16.71)
#x2 <- c(13.20, 14.11, 15.68, 10.53, 11.00, 11.31, 11.96, 12.58, 10.66, 10.85, 11.41, 11.91, 12.85, 13.58, 14.21, 15.56, 15.83, 16.41, 13.10, 13.63, 14.51, 15.38, 16.10, 16.73, 10.58, 11.28, 11.91, 12.65, 14.06)
y <- c(271.8, 264.0, 238.8, 230.7, 251.6, 257.9, 263.9, 266.5, 229.1, 239.3, 258.0, 257.6, 267.3, 267.0, 259.6, 240.4, 227.2, 196.0, 278.7, 272.3, 267.4, 254.5, 224.7, 181.5, 227.5, 253.6, 263.0, 265.8, 263.8)


# Dibujamos los puntos de las variables regresoras
plot(x1, x2)

# Construimos la matriz X de regresores
x0 <- rep(1, 29)
x <- cbind(x0, x1, x2)

# Construimos la matriz proyección
xt <- t(x)
P <- x %*% solve(xt %*% x) %*% xt

# Calculamos los residuos, su suma de cuadrados y su media 
I <- diag(length(y))
e <- (I - P) %*% y
SSRes <- t(e) %*% e
MSRes <- SSRes / (29 - 3)
# Obtenemos el punto más lejano del contorno de la variable regresora
# que es el maximo de la diagonal de la matriz H = X * (X' * X)^-1 * X
hmax <- max(diag(x %*% solve(xt %*% x) %*% xt))
print(paste("Máxima distancia: ", hmax))

# Obtenemos los puntos del contorno de la variable reqresora
# que deben cumplir h00 = x' * (X' * X)^-1 * x < hmax
x1min <- 500; x1max <- 1000 
x2min <- 14; x2max <- 20
contornox <- c()
contornoy <- c()
for (i in seq(from = x1min, to = x1max, by = 2)) {
  for (j in seq(from =x2min, to = x2max, by = 0.03)) {
    p <- c(1, i, j)
    d = t(p) %*% solve(t(x) %*% x) %*% p
    if (d < hmax) {
      contornox <- c(contornox, i)
      contornoy <- c(contornoy, j)
    }
  }
}

# Calculamos estimadores para la interpolación, extrapolación y extrapolación oculta
B <- solve(xt %*% x) %*% xt %*% y

# Interpolación
pix <- c(800, 600)
piy <- c(17, 18)
puntosInterpolacion <- data.frame(pix, piy, c = 7)
pi1 <- c(1, pix[1], piy[1])
yi1 <- pi1 %*% B
pi2 <- c(1, pix[2], piy[2])
yi2 <- pi2 %*% B

# Extrapolación
pex <- c(550)
pey <- c(15)
puntosExtrapolacion <- data.frame(pex, pey, c = 1)
pe1 <- c(1, pex[1], pey[1])
ye1 <- pe1 %*% B

# Extrapolación oculta
peox <- c(600, 850)
peoy <- c(16, 18.5)
puntosExtrapolacionOculta <- data.frame(peox, peoy, c = 0)
peo1 <- c(1, peox[1], peoy[1])
yeo1 <- peo1 %*% B
peo2 <- c(1, peox[2], peoy[2])
yeo2 <- peo2 %*% B

contorno <- data.frame(contornox, contornoy)
puntosOriginales <- data.frame(x1, x2, c = 3)
g <- ggplot(contorno, aes(contornox, contornoy)) +
  geom_point(colour = "grey", alpha = 0.3) +
  geom_point(data = puntosOriginales, aes(x1, x2), colour = "black") +
  geom_point(data = puntosInterpolacion, aes(pix, piy), colour = "black", size = 4, shape = 15) +
  geom_point(data = puntosExtrapolacion, aes(pex, pey), colour = "black", size = 5, shape = 18) +
  geom_point(data = puntosExtrapolacionOculta, aes(peox, peoy), colour = "black", size = 4, shape = 17) +
  xlim(x1min, x1max) + ylim(x2min, x2max) +
  geom_vline(xintercept = min(x1), linetype = "longdash", colour = "dark grey") +
  geom_vline(xintercept = max(x1), linetype = "longdash", colour = "dark grey") +
  geom_hline(yintercept = min(x2), linetype = "longdash", colour = "dark grey") +
  geom_hline(yintercept = max(x2), linetype = "longdash", colour = "dark grey") +
  xlab("Insolación") + ylab("Posición norte") +
  ggtitle("Extrapolación Oculta") +
  theme_bw()
print(g)

