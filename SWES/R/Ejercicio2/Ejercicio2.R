# Software Estadístico
# Lenguaje R
# Ejercicio 2 
# Alumno: Santiago Dobón

# Suponemos instalado el paquete UsingR. Lo importamos.
library("UsingR")

# Contamos las observaciones de age mayores que 30
numObsAge30 <- nrow(babies[babies$age > 30,])
print(paste("El numero de observaciones de age mayores que 30 es:", numObsAge30))

# Comparamos la variable gestación
# para observaciones con age mayor y menor que 30
gestacionMayor30 <- mean(babies[babies$age >= 30,]$ges)
gestacionMenor30 <- mean(babies[babies$age <= 30,]$ges)
if (gestacionMayor30 < gestacionMenor30) {
  print("Dura más la gestación en menores de 30")
} else print("Dura más la gestación en mayores de 30")

# Comprobamos como afecta la variable smoke al
# mínimo de la variable gestación
minGestacion <- tapply(babies$ges, babies$smoke, min)
names(minGestacion) <- c("never", "smokes now", "until current pregnancy",
                         "once did, not now", "unknown")
print("Cómo afecta fumar al minimo de dias de gestación:")
print(minGestacion)
