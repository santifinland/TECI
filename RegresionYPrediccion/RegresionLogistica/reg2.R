# Regresión logística

# Carga de librerias
library(msme)
library(openxlsx)
library(ggplot2)

# Lectura de fichero de datos
#datos <- read.xlsx('datos.xlsx', sheet="DATOS", startRow=1)
hombres <- datos[datos$sexo_invitador == "m",]
mujeres <- datos[datos$sexo_invitador == "f",]

reglogistica <- function(datos, respuesta, regresor, mark) {
  datos[[regresor]][is.na(datos[[regresor]])] <- 0
  b <- irls(datos[[respuesta]] ~ datos[[regresor]],
               family = "binomial",
                link = "logit",
                data = datos)
  print(paste(regresor, b$coefficients[2]))
  maximo <- max(datos[[regresor]]) * 10
  minimo <- min(datos[[regresor]])
  #if (minimo < 0) {
    #print(maximo)
#    print(minimo)
    #maximo <- maximo - (minimo)
##    minimo <- 0
    #print(maximo)
#    print(minimo)
  #}
  rango <- maximo - minimo
  f <- numeric(rango)
  t <- numeric(rango)
  m <- character(rango)
  for (i in seq(from = minimo, to = maximo, by = 1)) {
    t[i] <- i
    m[i] <- mark
    f[i] <- 1 / (1 + exp(-(b$coefficients[1] + b$coefficients[2] * i)))
  }
  res <- data.frame(t, f, m)
  return(res)
}

regBySex <- function(respuesta, regresor) {
  h <- reglogistica(hombres, respuesta, regresor, "h")
  m <- reglogistica(mujeres, respuesta, regresor, "m")
  res <- rbind(h, m)
  maximo <- max(datos[[regresor]]) * 10
  minimo <- min(datos[[regresor]])
  g <- ggplot(res, aes(t, f, color = m)) +
  geom_line(alpha = 1) +
  xlim(minimo, maximo)+ ylim(0, 1) +
  xlab(regresor) + ylab("Probabilidad") +
  ggtitle("Regresión logística") +
  scale_colour_discrete(name  ="Sexo",
                        labels=c("Hombre", "Mujer")) +
  geom_vline(xintercept = maximo / 10, linetype = "longdash", colour = "dark grey") +
  theme_bw()
  print(g)
}

regBySex("aceptados", "edad_indicada_edad_invitado")
regBySex("aceptados", "edad_invitador")
regBySex("aceptados", "bio")
regBySex("aceptados", "tamano_grupo")
regBySex("aceptados", "hora_envio")
regBySex("aceptados", "dias_antelacion")
regBySex("aceptados", "dias_antelacion")
regBySex("aceptados", "edad_invitado")
regBySex("aceptados", "dif_edades")