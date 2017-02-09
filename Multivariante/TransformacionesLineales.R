# Analisis Multivariante

# Transformaciones lineales
v_x <- matrix(c(1, 0.5, 0.7, 0.5, 0.64, 0.6, 0.7, 0.6, 1.44), nrow=3)
mu_x <- matrix(c(7, 8, 8.5), nrow=3)
A <- matrix(c(sqrt(3)/3, sqrt(3)/3,
              sqrt(3)/3, sqrt(2/3)/2,
              sqrt(2/3)/2, -1 * sqrt(2/3)), nrow=3)
mu_y <- t(A) %*% mu_x

v_y = t(A) %*% v_x %*% A

S <- matrix(c(1, 2, 4, 3, 5, 6, 10, 8, 9), nrow=3)
DS <- matrix(c(0.0731, 0, 0, 0, 0.75609, 0, 0, 0, 0.0243902), nrow=3)