# TECI
# Generación de normal multivariante a partir de matriz de covarianzas o de correlación.

# Matriz de correlación
R <- matrix(c(1, 0.445, 0.275, 0.601, 0.201, 0.222,
              0.445, 1, 0.302, 0.268, 0.340, 0.249,
              0.275, 0.302, 1, 0.340, 0.162, 0.484,
              0.601, 0.268, 0.340, 1, 0.270, 0.268,
              0.201, 0.340, 0.162, 0.270, 1, 0.293,
              0.222, 0.249, 0.484, 0.268, 0.293, 1), nrow=6)

# Matriz de desviaciones estandar
D <- diag(c(1.053, 1.097, 0.909, 0.937, 1.055, 0.8), nrow=6)

# Matriz de covarianzas
S <- D %*% R %*% D

# Descomposición espectral de S
descomposicion_espectral = eigen(S)
L <- diag(descomposicion_espectral$values) 
U <- descomposicion_espectral$vectors

# Obtención de la matriz de transformación A
A <- U %*% sqrt(L)

# Geración de 6 variables N(0, 1)
set.seed(1234)
y1 <- rnorm(1000, 0, 1)
y2 <- rnorm(1000, 0, 1)
y3 <- rnorm(1000, 0, 1)
y4 <- rnorm(1000, 0, 1)
y5 <- rnorm(1000, 0, 1)
y6 <- rnorm(1000, 0, 1)
y <- rbind(y1, y2, y3, y4, y5, y6)

# Generación de variable normal multivariante centrada en el origen
x <- A %*% y 

# Test de normalidad sobre la normal multivariante obtenida
library("MVN")
hz_res <- hzTest(t(x), cov = TRUE, qqplot = TRUE)
mardia_res <- mardiaTest(t(x), cov = TRUE, qqplot = TRUE)

# Visualización
hz_res <- hzTest(t(x[1:2,]), cov = TRUE, qqplot = TRUE)
mvnPlot(hz_res, type = "persp", default = TRUE) # perspective plot
mvnPlot(hz_res, type = "contour", default = TRUE) # contour plot

# Persistencia
write.csv(t(x),
          file="/Users/sdmt/Personal/teci/TECI/Multivariante/multinorm.csv",
          row.names=FALSE)




