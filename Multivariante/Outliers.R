# TECI
# Componentes principales y atípicos con WDBC

# Datos
XU = read.csv("wdbc.csv", sep=";", header=TRUE, stringsAsFactors=FALSE)

# Datos centrados
X = scale(XU[,3:32], scale=FALSE)

# Matriz de covarianzas
S = cov(X)
# Matriz de correlaciones
R = cor(X)

# Autovalores de la matriz de covarianzas
LA = diag(as.numeric(unlist(eigen(S)[1])))
# Autovectores de la matriz de covarianzas
A = matrix(unlist(eigen(S)[2]), ncol=30)

# Autovalores de la matriz de correlaciones
LB = diag(as.numeric(unlist(eigen(R)[1])))
# Autovectores de la matriz de correlaciones
B = matrix(unlist(eigen(R)[2]), ncol=30)

# Transformación de los datos centrados por componentes principales
YA = X %*% A
YB = X %*% B

# Estandarización multivariante
YA_std = YA %*% solve(sqrt(LA))
YB_std = YB %*% solve(sqrt(LB))

# Computo de distancia Euclidea en estadarizado == Mahalanobis en originales
YA_std_scaled = scale(YA_std, scale=FALSE)
YB_std_scaled = scale(YB_std, scale=FALSE)
distancias_A = rowSums(apply(YA_std_scaled, c(1,2), function(x) x^2))
distancias_B = rowSums(apply(YB_std_scaled, c(1,2), function(x) x^2))

# Limite outlier
l = 30 + 3 * sqrt(2 * 30)

# Outliers
outliers_A = distancias_A[distancias_A > l]
outliers_B = distancias_B[distancias_B > l]