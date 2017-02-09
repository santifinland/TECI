# TECI
# Componentes principales

# Matriz de correlación
M <- matrix(c(1, 0.98, 0.98, 0.98,
              0.98, 1, 0.98, 0.98,
              0.98, 0.98, 1, 0.98,
              0.98, 0.98, 0.98, 1), nrow=4)

# Descomposicion espectral
descomposision_espectral <- eigen(M)
