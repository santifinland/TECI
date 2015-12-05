# Master TECI
# Técnicas de Montecarlo
# Función Box Muller antitéticas

# Imput parameter:
#  seed
# Output paramters:
#  x, y

boxMullerAntitetica <- function(s, m, v) {
  c1 <- congruencial(s)
  c2 <- congruencial(c1[1])
  n1 <- sqrt(-2 * log(1 - c1[2])) * cos(2 * pi * (1 - c2[2]))
  n2 <- sqrt(-2 * log(1 - c1[2])) * sin(2 * pi * (1 - c2[2]))
  
  n1 <- n1 * v + m
  n2 <- n2 * v + m
  return(c(n1, n2, c2[1]))
}
