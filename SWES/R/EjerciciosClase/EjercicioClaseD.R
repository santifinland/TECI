# Practica D

# Pruebas de distribución
mues1 <- rnorm(100, 2, 1)
mues2 <- rcauchy(100)
hist(mues)
res1 <- ks.test(mues, 1)
res2 <- ks.test(mues, "pnorm", 2, 1)
res2 <- ks.test(mues, "pcauchy")
res3 <- shapiro.test(mues2)
res4 <- shapiro.test(mues1)
attributes(res2)
res1p <- res1$p.value
res1s <- res1$statistic

# Test t para diferencia de medias
mues3 <- rnorm(100, 2, 1)
mues4 <- rnorm(100, 2.1, 1)
rest <- t.test(mues3, mues4)

# Obtención de la linea de regresión
#plot(airquality)
#attach(airquality)
#names(airquality)
#reg1 <- lm(Ozone~Temp)
#attributes(reg1)
#summary(reg1)
#reg1$fitted.values
#plot(reg1)
#plot(Ozone~Temp)
#abline(reg1, col="red", lwd=2)

# Bucles
library("car")
par(mfrow=c(2, 2))
#for (i in 1:6) {
  #if (1 > 4) break
#  hist(Prestige[,i])
  ##ks.test(jitter(Prestige[, i], "pnorm", mean(Prestige[, i]), sd(Prestige[, i])))
#}

# Funciones
diffmed <- function(n, mu1, mu2) {
  mues1 <- rnorm(n, mu1, 1)
  mues2 <- rnorm(n, mu2, 1)
  t.test(mues1, mues2)
}

diffmed(100, 2, 5)
