# Master TECI
# Técnicas de regresión y predicción
# Diagnosis de modelo de regresión

# Importamos las librarías necesarias
library("ggplot2")

# Datas las siguientes muestras de las variables regresoras
x1 <- c(827.80, 653.10, 756.00, 769.35, 860.45, 704.05, 875.15, 793.50, 801.65, 709.60, 909.45, 905.55, 726.90, 819.65, 774.55, 783.35, 808.55, 757.90, 697.15, 748.45, 774.95, 753.35, 704.70, 711.85, 684.45, 694.85, 666.80, 638.10, 568.55)
x2 <- c(17.50, 16.51, 16.60, 16.41, 16.40, 16.02, 16.28, 16.17, 15.92, 15.89, 16.06, 15.93, 15.83, 16.04, 15.54, 16.66, 16.19, 15.70, 16.71, 16.46, 16.62, 16.45, 17.62, 17.37, 17.66, 18.12, 18.12, 18.53, 19.05)
x3 <- c(10.53, 10.58, 10.66, 10.85, 11.00, 11.28, 11.31, 11.41, 11.91, 11.91, 11.96, 12.58, 12.65, 12.85, 13.10, 13.20, 13.58, 13.63, 14.06, 14.11, 14.21, 14.51, 15.38, 15.56, 15.68, 15.83, 16.10, 16.41, 16.73)
y <- c(230.7, 227.5, 229.1, 239.3, 251.6, 253.6, 257.9, 258.0, 257.6, 263.0, 263.9, 266.5, 265.8, 267.3, 278.7, 271.8, 267.0, 272.3, 263.8, 264.0, 259.6, 267.4, 254.5, 240.4, 238.8, 227.2, 224.7, 196.0, 181.5)
k = 3
n = 29

# Construimos la matriz X de regresores
x0 <- rep(1, 29)
x <- cbind(x0, x1, x2, x3)

# Construimos la matriz proyección o H
xt <- t(x)
P <- x %*% solve(xt %*% x) %*% xt
H <- P

# Calculamos los residuos, su suma de cuadrados y su media 
I <- diag(length(y))
hii = diag(H)
e <- (I - P) %*% y
SSRes <- t(e) %*% e
MSRes <- SSRes / (n - (k + 1))

# Calculamos los residuos estandarizados
d <- e / sqrt(MSRes[1])

# Calculamos los residuos estudentizados
r <- c()
for (i in seq(from = 1, to = length(hii))) {
  ri = e[i] / sqrt((1 - hii[i]) * MSRes[1])
  r <- c(r, ri)
}

# Calculamos los puntos vecinos
# 1 Calculamos los estimadores
B <- solve(xt %*% x) %*% xt %*% y
Diij <- function(b, xi, oxi) {
  kk <-  (b * (xi - oxi) / sqrt(MSRes))
  kk <- kk * kk
  return(kk)
}
# 2 Calculo la distancia cuadrada ponderada entre puntos
Dii2 <- matrix(0, nrow = 29, ncol = 3)
for (p in seq(from =2, to = 28)) {
  xi <- c(x1[p], x2[p], x3[p])
  for (q in seq(from =1, to = 3)){
    oxi <- c(x1[p + q - 2], x2[p + q - 2], x3[p + q - 2])
    for (j in seq(from = 1, to = 3)) {
      Dii2[p, q] = Dii2[p, q] + Diij(B[j + 1], xi[j], oxi[j])
    } 
  } 
}
# 3 Selecciono los puntos proximos: aquellos con Dii^2 pequeño y
SSpe <- 0
nearPointsHistory <- list()
for (p in seq(from =1, to = 29)) {
  y1 <- c() 
  y2 <- c() 
  for (q in seq(from =2, to = 3)) {
    if (Dii2[p, q] < 1 && Dii2[p, q] > 0) {
      print(paste(p, q))
      print(t(nearPointsHistory))
      if (!paste(p, q) %in% nearPointsHistory) {
        print(paste("Punto p: ", p, " q: ", q, " => ", Dii2[p, q]))
        # 4 Obtenemos las respuestas para los puntos próximos
        y1 <- c(y1, B[1] + B[2] * x1[p] + B[3] * x2[p] + B[4] * x3[p])
        y2 <- c(y2, B[1] + B[2] * x1[q] + B[3] * x2[q] + B[4] * x3[q])
        nearPointsHistory <- rbind(nearPointsHistory, paste(p + q - 2, p))
      }
    }
  }
  if (length(y1) > 0)  {
    ys <- c(y1[1], y2)
    if (ys[1] - ys[2] < 25) {
      meany <- sum(ys) / length(ys)
      print(paste("mean: ", meany))
      for (i in seq(from = 1, to = length(ys))) {
        print(i)
        print(paste("ys: ", ys[i]))
        SSpe <- SSpe + (ys[i] - meany)^2
      }
    }
  }
  print(paste("error purto", SSpe))
}
# 4 Obtenemos las respuestas para los puntos próximos
#yp <- c()
#for (p in unique(s)) {
  #tmp <- B[1] + B[2] * x1[p] + B[3] * x2[p] + B[4] * x3[p]
  #yp <- c(yp, tmp)
#}
# 5 Obtenemos el error puro
#SSpe <- 0
#for (p in seq(from = 1, to = length(yp))) {
  #print(SSpe)
#  SSpe <- SSpe + (yp[p] - mean(y))^2
#}






# Calculamos los niveles de los puntos y mostramos los mayores a 2 * (k + 1) / n
leveragePoint = 2 * (k + 1) / n
for (i in seq(from = 1, to = length(hii))) {
  if (hii[i] > leveragePoint) {
    print(paste("Valor seleccionado ", i, " : ", hii[i]))
  }
}



