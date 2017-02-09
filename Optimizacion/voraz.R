
library(ggplot2)
# Datos
data = read.csv("voraz.csv", sep=",", header=FALSE, stringsAsFactors=FALSE)
x = seq(from=1, to=8)
datos <- data.frame(x, data)

g1 <- ggplot(datos, aes(x, V1)) +
  geom_line(alpha = 1) +
  xlab("Iteraciones") + ylab("Coeficiente de correlación") +
  ggtitle("Optimización mediante algoritmo voraz") +
  theme_bw()
print(g1)