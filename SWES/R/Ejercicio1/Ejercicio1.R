# Software Estadístico
# Lenguaje R
# Ejercicio 1
# Alumno: Santiago Dobón

# Vector de longitud 8 comenzando en 4 y terminando en 13
v <- seq(from = 4, to = 13, length.out = 8)

# Suma de los elementos del vector v
s <- sum(v)
print(c('Suma de los elementos del vector v: ', s))

# Se añaden 2 ceros al principio y al final del vector v
v <- c(0, 0, v, 0, 0)

# Se sustituyen los valores positivos menores que 7 por 11
v[v > 0 & v < 7] = 11

# Suma con un vector de la misma longitud de 2 a 8
vSuma <- v + seq(from = 2, to = 8, length.out = length(v))

# Resultado de multiplicar los dos elementos centrales de vSuma
multiplicando <- vSuma[(length(vSuma) / 2)]
multiplicador <- vSuma[(length(vSuma) / 2) + 1]
print(c('Resultado de multiplicar los elementos centrales de VSuma ',
      multiplicando * multiplicador))

# Repetimos el cálculo anterior con vSuma como vector decreciente
vDecreciente <- sort(vSuma, decreasing = TRUE)
multiplicando <- vDecreciente[(length(vDecreciente) / 2)]
multiplicador <- vDecreciente[(length(vDecreciente) / 2) + 1]
print(c('Resultado de multiplicar los elementos centrales de vDecreciente',
      multiplicando * multiplicador))

# Renombramos los 12 primeros valores de vDecreciente con los meses del año
meses <- c("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio",
           "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre")
names(vDecreciente) <- meses

# Valor de vDecreciente correspondiente a Agosto
print(c('Valor de vDecreciente correspodiente a Agosto',
      vDecreciente["Agosto"]))
