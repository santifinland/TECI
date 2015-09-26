
val1 <- seq(-3, 3, 0.1)

# Función de densidad
densi1 <- dnorm(val1)
#plot(densi1)
#plot(densi1, type="h")
#plot(densi1, type="l")
plot(val1, densi1, type="l")
abline(v=1.96)
par(new=TRUE)
plot(val1,
     dnorm(val1, 0, 0.5),
     xlim=c(-3, 3),
     ylim=c(0, 0.4),
     type="h")

# Función de destribución
dis1 <- pnorm(1.96)
dis2 <- pnorm(1.96, lower.tail = FALSE)
dis3 <- pnorm(1.96, 0, 0.5)
dis4 <- pnorm(val1)
#plot(val1, dis4)
#plot(val1, dis4, type="l")

# Funcion cuantílica
cuan1 <- qnorm(0.975)

# Simulador de normales
normal1 <- rnorm(100)
normal2 <- rnorm(100, 0, 100)
plot(normal1)  
plot(normal2)

# Graficamente
curve(qnorm(x))
abline(h=1.96)
abline(v=0.975)
curve(dnorm(x), xlim=c(-3, 3), ylim=c(0, 0.8))
curve(dnorm(x, -1, 1), col="dark blue", add=TRUE)
curve(dnorm(x, 1, 0.5), col="red", add=TRUE)

# Binomial n=7, p=0.2
# Función de masa de probabilidad
bino1 <- dbinom(1, 7, 0.2) # 7*0.2*(0.8^6)
kk <- 7*0.2*(0.8^6)
bino2 <- dbinom(1, 10, 0.2)
bino3 <- dbinom(7, 7, 0.2)
factorial(4)

val2 <- seq(0, 7, 1)
plot(val2, dbinom(val2, 7, 0.2), type="h")
par(new=TRUE)
plot(val2, dbinom(val2, 7, 0.8), type="h", col=2)

# Función de distribución de una binomial


# Medidad cuantitativas
set.seed(1234)

# Mean y median y cuantil,.......
val3 <- rnorm(20, 2, 1)
mean(val3)
median(val3)
sort(val3)
quantile(val3)
fivenum(val3)
summary(val3)

mat1 <- cbind(rnorm(1000), rnorm(1000))
cov(mat1)

# With
with(cars, plot(speed, dist))
with(cars, cor(speed, dist))

library("fBasics")
attach(iris)
summary(Sepal.Length)
basicStats(Sepal.Length)

#Ejercicio transparencia 4 de RintroC
basicStats(Sepal.Length[Species=="setosa"])
resumen1 <- cbind(basicStats(Sepal.Length[Species=="setosa"]),
            basicStats(Sepal.Length[Species=="versicolor"]),
            basicStats(Sepal.Length[Species=="virginica"]))
names(resumen1) <- levels(Species)


plot(iris, col=Species)


# Graficos con cuantitativas
library("lattice")

# Histograma
hist(Sepal.Length)
sc <- cut(Sepal.Length, seq(4, 8, 0.5))
table(sc)
hist(Sepal.Length, freq=FALSE, breaks=c(seq(4, 7, 0.5), 8))

hist(Sepal.Width, freq=FALSE)
curve(dnorm(x, mean(Sepal.Width), sd(Sepal.Width)), add=TRUE, col="red")



