

library(ggplot2)
# Datos
data = read.csv("vecinal.csv", sep=",", header=FALSE, stringsAsFactors=FALSE)
datos <- data.frame(data)

g1 <- ggplot(datos, aes(V1, V2, colour=V3)) +
  geom_line(alpha = 1) +
  scale_colour_manual(name="Punto de inicio",
                      values= c("red", "blue", "green", "black"),
                      labels=c("Azar 1", "Azar 2", "Azar 3", "Voraz")) +
  xlab("Iteraciones") + ylab("Coeficiente de correlación") +
  ggtitle("Optimización mediante algoritmo vecinal") +
  theme_bw()
print(g1)