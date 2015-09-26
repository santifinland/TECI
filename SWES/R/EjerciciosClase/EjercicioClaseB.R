# Ejercicio Clase B
# Alumno: Santiago Dobón

# Asumimos los datos de airquality disponibles

# Seleccionamos las observaciones del mes 5
observacionesMayo <- airquality[airquality$Month == 5,]

# Seleccionamos las observaciones del dia 17 de cada mas
observacionesDia17<- airquality[airquality$Day == 17,]

# Obtenemos la suma de los numeros de fila de las
# observaciones del día 17
sumaDia17 <- sum(as.numeric(rownames(observacionesDia17)))

# Obtener los meses con temperatura mayor que 77
observacionesMesesCalidos<- airquality[airquality$Temp > 77,]$Month
recuentoCalidos <- table(observacionesMesesCalidos)
mesCalido = recuentoCalidos[recuentoCalidos==max(recuentoCalidos)]

# Obtener los meses y dias temperatura mayor que 77 y menor que 79
observacionesMeses78<- rownames(airquality[airquality$Temp == 78, c(5,6)])

# Obtener donde estan los nulos
which(is.na(airquality, arr.ind = TRUE))