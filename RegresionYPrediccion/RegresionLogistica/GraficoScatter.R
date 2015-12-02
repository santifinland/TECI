# Regresión logística

# Carga de librerias
library(msme)
library(openxlsx)
library(ggplot2)

# Lectura de fichero de datos
#datos <- read.xlsx('datos.xlsx', sheet="DATOS", startRow=1)
hombres <- datos[datos$sexo_invitador == "m",]
mujeres <- datos[datos$sexo_invitador == "f",]
totalMujeres <- nrow(mujeres)
mujeresAceptados <- mujeres[mujeres$aceptados == 1,]

kk <- irls(mujeres$aceptados ~ mujeres$hora_envio,
     family = "binomial",
     link = "logit",
     data = datos)

horas <-  numeric(6)
for (i in seq(from = 1, to = 6)) {
  horas[i] <- length(which(mujeresAceptados$hora_envio < (i * 4) & mujeresAceptados$hora_envio > ((i - 1) * 4)))
}
h <- c(4, 8, 12, 16, 20, 24)
p <- horas / totalMujeres
res <- data.frame(h, p)

lo <- reglogistica(mujeres, "aceptados", "hora_envio", "m")
g <- ggplot(lo, aes(t, f)) +
  geom_line(alpha = 1) + 
  geom_point(data = res, aes(h, p)) +
  xlim(0, 24)+ ylim(0, 0.1) +
  xlab("Horas") + ylab("Probabilidad") +
  ggtitle("Regresión logística") +
  theme_bw()
print(g)
