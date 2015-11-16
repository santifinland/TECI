# Master TECI
# Técnicas de Montecarlo
# Práctica 1: modelo de crecimiento poblacional

# Función crecimiento poblacional
crecimientoPoblacionalLogistico <- function(p0, a, b, dt, tmax, color) {
  steps = tmax / dt
  p <- numeric(steps)
  t <- numeric(steps)
  c <- character(steps)
  p[1] <- p0
  t[1] <- 0
  c[1] <- color
  for (i in seq(from = 1, to = steps - 1)) {
    p[i + 1] <- p[i] + (a * p[i] - (a / b) * p[i]^2) * dt
    t[i + 1] <- t[i] + dt
    c[i + 1] <- color 
  }
  return(data.frame(p, t, c))
}

# Función crecimiento poblacional Gompertz
crecimientoPoblacionalGompertz<- function(p0, a, b, dt, tmax, color) {
  steps = tmax / dt
  p <- numeric(steps)
  t <- numeric(steps)
  c <- character(steps)
  p[1] <- p0
  t[1] <- 0
  c[1] <- color
  for (i in seq(from = 1, to = steps - 1)) {
    p[i + 1] <- max(p[i] + (a * p[i] * log(b / p[i])) * dt, 0)
    t[i + 1] <- t[i] + dt
    c[i + 1] <- color 
  }
  return(data.frame(p, t, c))
}

# Calculo del crecimiento poblacional
tmax <- 1000
#c001 <- crecimientoPoblacionalLogistico(150, 0.01, 1000, 0.01, tmax, "green")
#c01 <- crecimientoPoblacionalLogistico(150, 0.01, 1000, 0.1, tmax, "blue")
cl1 <- crecimientoPoblacionalLogistico(150, 0.01, 1000, 1, tmax, "red")
cl10 <- crecimientoPoblacionalLogistico(150, 0.01, 1000, 10, tmax, "blue")
cl100 <- crecimientoPoblacionalLogistico(150, 0.01, 1000, 100, tmax, "green")
clb1 <- crecimientoPoblacionalLogistico(150, 0.01, 1000, 1, tmax, "red")
clb2 <- crecimientoPoblacionalLogistico(150, 0.01, 500, 1, tmax, "blue")
clb3<- crecimientoPoblacionalLogistico(150, 0.01, 100, 1, tmax, "green")
cg1 <- crecimientoPoblacionalGompertz(150, 0.01, 1000, 1, tmax, "red")
cg10 <- crecimientoPoblacionalGompertz(150, 0.01, 1000, 10, tmax, "blue")
cg100 <- crecimientoPoblacionalGompertz(150, 0.01, 1000, 100, tmax, "green")
cgb1 <- crecimientoPoblacionalGompertz(150, 0.01, 1000, 1, tmax, "red")
cgb2 <- crecimientoPoblacionalGompertz(150, 0.01, 500, 1, tmax, "blue")
cgb3 <- crecimientoPoblacionalGompertz(150, 0.01, 100, 1, tmax, "green")

# Gráfico del crecimiento poblacional logistico
crecimientos <- rbind(cl1, cl10, cl100)
g1 <- ggplot(crecimientos, aes(t, p, colour=c)) +
  geom_line(alpha = 1) +
  xlim(0, 1000) + ylim(0, 1000) +
  scale_colour_discrete(name  ="Incremento\nde tiempo",  labels=c("1", "10", "100")) +
  xlab("Tiempo") + ylab("Población") +
  ggtitle("Crecimiento poblacional\nEcuación logística") +
  theme_bw()
print(g1)

# Gráfico del crecimiento poblacional logistico
# con distintas tasas de crecimiento
crecimientos <- rbind(clb1, clb2, clb3)
g2 <- ggplot(crecimientos, aes(t, p, colour=c)) +
  geom_line(alpha = 1) +
  xlim(0, 1000) + ylim(0, 1000) +
  scale_colour_discrete(name  ="Tasa de\ncrecimiento",
                        labels=c("1000", "500", "100")) +
  xlab("Tiempo") + ylab("Población") +
  ggtitle("Crecimiento poblacional\nEcuación logística") +
  theme_bw()
print(g2)

# Gráfico del crecimiento poblacional Gompertz 
crecimientos <- rbind(cg1, cg10, cg100)
g3 <- ggplot(crecimientos, aes(t, p, colour=c)) +
  geom_line(alpha = 1) +
  xlim(0, 1000) + ylim(0, 1000) +
  scale_colour_discrete(name  ="Incremento\nde tiempo",  labels=c("1", "10", "100")) +
  xlab("Tiempo") + ylab("Población") +
  ggtitle("Crecimiento poblacional\nEcuación Gompertz") +
  theme_bw()
print(g3)

# Gráfico del crecimiento poblacional Gompertz 
# con distintas tasas de crecimiento
crecimientos <- rbind(cgb1, cgb2, cgb3)
g4 <- ggplot(crecimientos, aes(t, p, colour=c)) +
  geom_line(alpha = 1) +
  xlim(0, 1000) + ylim(0, 1000) +
  scale_colour_discrete(name  ="Tasa de\ncrecimiento",
                        labels=c("1000", "500", "100")) +
  xlab("Tiempo") + ylab("Población") +
  ggtitle("Crecimiento poblacional\nEcuación Gompertz") +
  theme_bw()
print(g4)
