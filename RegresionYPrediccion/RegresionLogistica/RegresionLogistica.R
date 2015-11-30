# Regresión logística

# Carga de librerias
library(msme)
library(openxlsx)
library(ggplot2)

# Lectura de fichero de datos
datos <- read.xlsx('datos.xlsx', sheet="DATOS", startRow=1)

hombres <- datos[datos$sex_invitador == "m"]
mujeres <- datos[datos$sex_invitador == "f"]

# Estimación de coeficientes de regresión para regresor bio
bbiom <- irls(hombres$aceptados ~ hombres$bio,
            family = "poisson",
            link = "log",
            data = hombres)

f <- numeric(10000)
t <- numeric(10000)
for (i in seq(from = 0, to = 10000, by = 1)) {
  t[i] <- i
  f[i] <- 1 / (1 + exp(-(bbiom$coefficients[1] + bbiom$coefficients[2] * i)))
}
res <- data.frame(f, t)

g <- ggplot(res, aes(t, f)) +
  geom_line(alpha = 1) +
  xlim(0, 10000) + ylim(0, 1) +
  xlab("Numero de palabras en autobiografía") + ylab("Probabilidad") +
  ggtitle("Regresión logística biografía") +
  theme_bw()
print(g)


# Estimación de coeficientes de regresión para regresor dia de envio 
bdiaenvio <- irls(datos$aceptados ~ datos$d11 + datos$d12 + datos$d13 +
                    datos$d14 + datos$d15 +datos$d16,
            family = "poisson",
            link = "log",
            data = datos)

# Estimación de coeficientes de regresión para regresor dias antelacionG 
bdiasantelacion <- irls(datos$aceptados ~ datos$dias_antelacion,
            family = "poisson",
            link = "log",
            data = datos)

f <- numeric(100)
t <- numeric(100)
for (i in seq(from = 0, to = 100, by = 1)) {
  t[i] <- i
  f[i] <- 1 / (1 + exp(-(bdiasantelacion$coefficients[1] + bdiasantelacion$coefficients[2] * i)))
}
res <- data.frame(f, t)

g <- ggplot(res, aes(t, f)) +
  geom_line(alpha = 1) +
  xlim(0, 100) + ylim(0, 1) +
  xlab("Numero de días de antelación") + ylab("Probabilidad") +
  ggtitle("Regresión logística días de antelación") +
  theme_bw()
print(g)


# Estimación de coeficientes de regresión para regresor edad del invitador 
bedad <- irls(datos$aceptados ~ datos$edad_invitador,
            family = "poisson",
            link = "log",
            data = datos)

f <- numeric(315)
t <- numeric(315)
for (i in seq(from = -200, to = 115, by = 1)) {
  t[i] <- i
  f[i] <- 1 / (1 + exp(-(bedad$coefficients[1] + bedad$coefficients[2] * i)))
}
res <- data.frame(f, t)

g <- ggplot(res, aes(t, f)) +
  geom_line(alpha = 1) +
  xlim(-200, 115) + ylim(0, 1) +
  xlab("Edad del invitador") + ylab("Probabilidad") +
  ggtitle("Regresión logística edad del invitador") +
  theme_bw()
print(g)

# Estimación de coeficientes de regresión para regresor diferencia de edades
bdifedad <- irls(datos$aceptados ~ datos$dif_edades,
              family = "poisson",
              link = "log",
              data = datos)

f <- numeric(125)
t <- numeric(125)
for (i in seq(from = -35, to = 90, by = 1)) {
  t[i] <- i
  f[i] <- 1 / (1 + exp(-(bdifedad$coefficients[1] + bdifedad$coefficients[2] * i)))
}
res <- data.frame(f, t)

g <- ggplot(res, aes(t, f)) +
  geom_line(alpha = 1) +
  xlim(-35, 90) + ylim(0, 1) +
  xlab("Diferencia de edad") + ylab("Probabilidad") +
  ggtitle("Regresión logística diferencia de edad") +
  theme_bw()
print(g)


# Estimación de coeficientes de regresión para regresor tamaño de grupo
bgrupo <- irls(datos$aceptados ~ datos$g11 + datos$g12,
                 family = "poisson",
                 link = "log",
                 data = datos)

f <- numeric(125, 2)
t <- numeric(125, 2)
for (i in seq(from = 0, to = 1, by = 1)) {
  for (j in seq(from = 0, to = 1, by = 1)) {
    t[i] <- i
    f[i] <- 1 / (1 + exp(-(bgrupo$coefficients[1] + bgrupo$coefficients[2] * i + bgrupo$coefficients[3] * i)))
  }
}
res <- data.frame(f, t)

g <- ggplot(res, aes(t, f)) +
  geom_line(alpha = 1) +
  xlim(-1, 1) + ylim(0, 1) +
  xlab("Tamaño del grupo") + ylab("Probabilidad") +
  ggtitle("Regresión logística tamaño de grupo") +
  theme_bw()
print(g)
