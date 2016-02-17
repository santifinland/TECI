#######################################################################
# Programa que genera datos de dos conjuntos diferentes e ilustra
# 0) Clasificador optimo basado en distribucion estimada a partir de la muestra
# 1) LDA
# 2) Perceptron empleando regla de entrenamiento simplificada 
#######################################################################

# Clear workspace
rm(list=ls())

# Para generar datos multidimensionales y emplear LDA
library(MASS)
# Para generar muestras
library(datasets)
# Para pintar conicas
library(conics)

########################################
# DEFINO LA DISTRIBUCION
########################################
# Definicion de clases 0 y 1
# Means
mu0 <- c(-1,-1)
mu1 <- c(1,1)

# Covariance positive definite matrix
Sigma0 <- matrix(c(0.1,0.05,0.05,0.1), nrow=2, ncol=2, byrow=TRUE, dimnames=NULL)
Sigma1 <- matrix(c(0.7,0.3,0.3,0.5), nrow=2, ncol=2, byrow=TRUE, dimnames=NULL)


########################################
# GENERO LOS DATOS DE MUESTRA
########################################

#Numero de muestras de clase 0 y 1
n0 <- 25
n1 <- 25

# Genero muestras
muestra0 <- mvrnorm(n = n0, mu0, Sigma0, tol = 1e-6, empirical = FALSE)
muestra1 <- mvrnorm(n = n1, mu1, Sigma1, tol = 1e-6, empirical = FALSE)

###################################################
# Ejemplos con datos criticos bastante ilustrativo
#¢n0 <- 5
#¢n1 <- 5
#¢muestra0 <- matrix(c(-1.3271098652, -0.6781576540, -0.9160664606, -1.3286423684, 
#¢-0.9008765748, -0.9829221738, -0.5838209666, -0.5727383580,-1.3675161197, 
#¢-0.9071273435), ncol=2,byrow=TRUE)
#¢muestra1 <- matrix(c(1.8406694358, 1.2356425784, 1.1099743556, 0.9562270325, 
#¢0.5142365356, 0.4701303580,1.6869605277, 0.8795644853,-0.5817415873, -0.3016088364), ncol=2,byrow=TRUE)
####################################################

# Les asocio una salida (1 o -1) y los junto
muestra0_clasificada <- cbind(muestra0,rep(-1,n0), 1);
muestra1_clasificada <- cbind(muestra1,rep(1,n1), 2);

# Pintar las muestras
plot(muestra0_clasificada[,1],muestra0_clasificada[,2],pch=1, xlim=c(-3,3), ylim=c(-3,3),xlab="x1",ylab="x2")
points(muestra1_clasificada[,1],muestra1_clasificada[,2],pch=2)

# Paro el programa hasta que se introduzca un retorno de carro en consola
readline()


#########################################################################################
# 0) CLASIFICADOR OPTIMO BASADO EN DISTRIBUCION (QUE ESTIMAREMOS A PARTIR DE LA MUESTRA 
#########################################################################################
# Si las varianzas son diferentes es una región cuadratica
inv_Sigma0 <- solve(Sigma0)
inv_Sigma1 <- solve(Sigma1)


# Calculo los coeficientes a pelo. Se podrían calcular matricialmente.
a1 <- inv_Sigma0[1,1]-inv_Sigma1[1,1]
a2 <- 2*(inv_Sigma0[1,2]-inv_Sigma1[1,2])
a3 <- inv_Sigma0[2,2]-inv_Sigma1[2,2]
a4 <- -2*inv_Sigma0[1,1]*mu0[1] + 2 *inv_Sigma1[1,1]*mu1[1] -2*inv_Sigma0[1,2]*mu0[2]+2*inv_Sigma1[1,2]*mu1[2]
a5 <- -2*inv_Sigma0[2,2]*mu0[2] + 2 *inv_Sigma1[2,2]*mu1[2] -2*inv_Sigma0[1,2]*mu0[1]+2*inv_Sigma1[1,2]*mu1[1]
a6 <- inv_Sigma0[1,1]*mu0[1]^2 + 2*inv_Sigma0[1,2]*mu0[1]*mu0[2] + inv_Sigma0[2,2]*mu0[2]^2-
  (inv_Sigma1[1,1]*mu1[1]^2 + 2*inv_Sigma1[1,2]*mu1[1]*mu1[2] + inv_Sigma1[2,2]*mu1[2]^2)+
  log(det(Sigma0))-log(det(Sigma1))

coef_conica <- c(a1,a2,a3,a4,a5,a6)
conicPlot(coef_conica,add=TRUE,xlab="",ylab="",lwd=2)


readline()



###################################################
# 1) LINEAR DISCRIMINANT ANALYSIS (BASADO EN MUESTRA)
###################################################
muestras_clasificadas <- rbind(muestra0_clasificada,muestra1_clasificada)
datos <- data.frame(muestras_clasificadas)
lda.fit <- lda(X3 ~ X1+X2,datos)
coefx1 <- lda.fit$scaling[1,]
coefx2 <- lda.fit$scaling[2,]
medias <- lda.fit$means
media <- colMeans(medias)
# Impongo que linea de separacion pase por media de las medias 
# (asumimos que ambos grupos tienen similar distribucion)
const <- media%*%lda.fit$scaling
abline(a=const/coefx2, b=-coefx1/coefx2, col="blue", lwd=2)
readline()


g0 <- ggplot(datos, aes(X1, X2)) +
  geom_point(alpha = 1, pch = datos[,4]) +
  geom_abline(intercept = const/coefx2, slope = -coefx1/coefx2, col = "black") +
  xlab("X") + ylab("Y") +
  ggtitle("Clasificación perceptron") +
  theme_bw()

############################################################################
# 2) DEFINO ADALINE. INICIALIZO SEGÚN REGLA SIMPLIFICADA (Video de N. Lawrence)
############################################################################
# Defino el perceptron mediante un vector de pesos w=(w1,w2,w3)
# Los datos de entradas se completan con ultima componente (R no admite indice cero) igual a 1 (umbral)
# Inicializo con unos pesos que cumplen la condicion (clasifica bien) para un primer punto
w0 <- muestras_clasificadas[1,3]*c(muestras_clasificadas[1,1:2],1);
w <- w0
print("Inicial")
print(w)
abline(-w[3]/w[2],-w[1]/w[2],col="red",lty=2)
g0 <- g0 + geom_abline(intercept = -w[3]/w[2], slope = -w[1]/w[2], col="purple", alpha = 0.3)
readline()

###########################################################
# ENTRENO SEGUN REGLA DEL PERCEPTRON (version simplificada)
###########################################################
# Datos de entrenamiento npa = numero total de pasadas
etas = c(0.2, 0.1, 0.01);
npa<- 100
# Flag que indica si todos los ejemplos se clasifican bien
entrenado <- 0
# Defino un indice j para numero de pasada
j <- 1
J <- rep(0, npa) # Vector para almacenar los valores que toma la función de coste
I <- rep(0, npa) # Vector para almacenar los valores que toma el indicador de iteraci
comparaciones <- data.frame()
for (eta in etas) {
  j <- 1 
  J <- rep(0, npa) # Vector para almacenar los valores que toma la función de coste
  I <- rep(0, npa) # Vector para almacenar los valores que toma el indicador de iteraci
  w <- w0
  entrenado <- 0
  while (j<= npa & entrenado==0) {
  # Elijo los ejemplos secuencialmente (mejor aleatoriamente)
    entrenado <- 1
    # Calculo la función de coste como el número de muestras mal clasificadas
    for (i in (1:(n0+n1))) {
      if (sign(w%*%c(muestras_clasificadas[i,1:2],1))!=muestras_clasificadas[i,3]) {
        J[j] = J[j] + 1
      }
    }
    print(J)
	  for (i in (1:(n0+n1))) {
      # Comprobamos si el ejemplo está bien clasificado
      if (sign(w%*%c(muestras_clasificadas[i,1:2],1))!=muestras_clasificadas[i,3]){
      	w <- w+eta*muestras_clasificadas[i,3]*c(muestras_clasificadas[i,1:2],1);
        #print(w)
        entrenado <- 0
     	  abline(-w[3]/w[2],-w[1]/w[2], col="red",lty=2);
      	if (eta == 0.2) { g0 <- g0 + geom_abline(intercept = -w[3]/w[2], slope = -w[1]/w[2], col="red", alpha = 0.3) }
      	if (eta == 0.1) { g0 <- g0 + geom_abline(intercept = -w[3]/w[2], slope = -w[1]/w[2], col="green", alpha = 0.3) }
      	if (eta == 0.01) { g0 <- g0 + geom_abline(intercept = -w[3]/w[2], slope = -w[1]/w[2], col="blue", alpha = 0.3) }
      }
	  }
    cat("Iteracion=",j, "\n")
    I[j] <- j 
    j <- j+1
  	if (eta == 0.2) { comparaciones <- rbind(comparaciones, data.frame(I, J, C = "red")) }
  	if (eta == 0.1) { comparaciones <- rbind(comparaciones, data.frame(I, J, C = "green")) }
  	if (eta == 0.01) { comparaciones <- rbind(comparaciones, data.frame(I, J, C = "blue")) }
  }
  if (eta == 0.01) { g0 <- g0 + geom_abline(intercept = -w[3]/w[2], slope = -w[1]/w[2], col="blue") }
  if (eta == 0.1) { g0 <- g0 + geom_abline(intercept = -w[3]/w[2], slope = -w[1]/w[2], col="green") }
  if (eta == 0.2) { g0 <- g0 + geom_abline(intercept = -w[3]/w[2], slope = -w[1]/w[2], col="red") }
  abline(-w[3]/w[2],-w[1]/w[2], col="red",lwd=2)
}

print(g0)

g1 <- ggplot(comparaciones, aes(I, J, colour=C)) +
  geom_point(alpha = 1) +
  scale_colour_manual(name  ="Tasa de aprendizaje", values= c("red", "green", "blue"), labels=c("0.2", "0.1", "0.01")) +
  xlab("Iteraciones") + ylab("Muestras mal clasificadas") +
  ggtitle("Minimización del error (Perceptron criterion function)") +
  theme_bw()
print(g1)