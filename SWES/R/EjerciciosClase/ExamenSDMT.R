# Master TECI
# Examen SWES R
# Alumno: Santiago Dobón Méndez Trelles

# Estudio descriptivo de los datos crabs del paquete MASS
# Asumimos instalado el paquete MASS. Cargamos la librería
library("MASS")

# Sacamos los principales estadísticos de las variables numericas
print("Frontal lobe size")
print(summary(crabs$FL))
print("Rear width")
print(summary(crabs$RW))
print("Carapace length")
print(summary(crabs$CL))
print("Carapace width")
print(summary(crabs$CW))
print("Body depth")
print(summary(crabs$BD))

# Sacamos los histogramas de cada una de las variables numéricas
hist(crabs$FL)
hist(crabs$RW)
hist(crabs$CL)
hist(crabs$CW)
hist(crabs$BD)

# Sacamos graficamente la relación de las variables numéricas
# con las variables categoricas de especie y sexo.
plot(crabs$FL~crabs$sp)
plot(crabs$FL~crabs$sex)
plot(crabs$RW~crabs$sp)
plot(crabs$RW~crabs$sex)
plot(crabs$CL~crabs$sp)
plot(crabs$CL~crabs$sex)
plot(crabs$CW~crabs$sp)
plot(crabs$CW~crabs$sex)
plot(crabs$BD~crabs$sp)
plot(crabs$BD~crabs$sex)

print("Graficamente observamos que el par de variables que mejor
      separa a los elementos en diferentes clases es Species-Body depth")


# Completamos la instrucción para que genere una matriz cuya
# segunda fila sea 4, 13, 22
mat <- matrix(seq(from = 1, to = 25, by = 3), nrow = 3)

# Extraemos del objeto faithful las observaciones con la primera
# columna menor que 2 y la segunda columan mayor que 55 simultaneamente
ext1 <- faithful[faithful[,1] < 2 & faithful[,2] > 55,]

# Extraemos las medias de las columnas con las observaciones anteriores
medias <- lapply(ext1, mean)


# Obtenemos matriz inversa y determinante de las 2 primeras filas y columnas
# de los datos de ext1
m <- as.matrix(ext1[c(1, 2), ])
detm <- det(m)
invm <- solve(m)