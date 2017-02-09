# TECI
# Componentes principales Mujeres

# Matriz de covarianzas
S <- matrix(c(44.7, 17.79, 5.99, 9.19,
              17.79, 26.15, 4.52, 4.44,
              5.99, 4.52, 3.33, 1.34,
              9.19, 4.44, 1.34, 4.56), nrow=4)

# Matriz de correlacion
D <- diag(diag(sqrt(S)), nrow=4)
R = solve(D) %*% S %*% solve(D)

# Descomposicion espectral
descomposision_espectral <- eigen(R)
