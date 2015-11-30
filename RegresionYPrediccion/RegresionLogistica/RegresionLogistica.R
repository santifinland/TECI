# Regresión logística

# Carga de librerias
library(msme)
library(openxlsx)
library(ggplot2)

# Lectura de fichero de datos
#datos <- read.xlsx('datos.xlsx', sheet="DATOS", startRow=1)

# Estimación de coeficientes de regresión para regresor bio
bbio <- irls(datos$aceptados ~ datos$bio,
            family = "poisson",
            link = "log",
            data = datos)

f <- numeric(100)
t <- numeric(100)
for (i in seq(from = 0, to = 100, by = 1)) {
  t[i] <- i
  f[i] <- 1 / (1 + exp(-(bbio$coefficients[1] + bbio$coefficients[2] * i)))
}
res <- data.frame(f, t)

g <- ggplot(res, aes(t, f)) +
  geom_line(alpha = 1) +
  xlim(0, 100) + ylim(0, 1) +
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
