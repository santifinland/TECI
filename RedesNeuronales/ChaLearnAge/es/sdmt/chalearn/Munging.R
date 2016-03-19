
# Import needed libraries
library(ggplot2)

# Ground Truth
gt <- as.data.frame(read.csv("train_gt.csv", stringsAsFactors=FALSE, header=FALSE))
colnames(gt) <- c("photo", "mean", "std")

# Photo area
photos <- as.data.frame(read.csv("areaphoto.csv", stringsAsFactors=FALSE, header=FALSE))
colnames(photos) <- c("photo", "area", "age")

# Biometric features areas
faces <- as.data.frame(read.csv("faces.csv", stringsAsFactors=FALSE, header=FALSE))
colnames(faces) <- c("photo", "area", "age")
smiles <- as.data.frame(read.csv("smiles.csv", stringsAsFactors=FALSE, header=FALSE))
colnames(smiles) <- c("photo", "area", "age")
noses <- as.data.frame(read.csv("noses.csv", stringsAsFactors=FALSE, header=FALSE))
colnames(noses) <- c("photo", "area", "age")
leftear <- as.data.frame(read.csv("leftear.csv", stringsAsFactors=FALSE, header=FALSE))
colnames(leftear) <- c("photo", "area", "age")
rightear <- as.data.frame(read.csv("rightear.csv", stringsAsFactors=FALSE, header=FALSE))
colnames(rightear) <- c("photo", "area", "age")

# Proportion face - nose.
# Expectes a file created with python program FaceDetector writeProportionNose method
facenoseproportions <- as.data.frame(read.csv(
  "proportionnose.csv", stringsAsFactors=FALSE, header=FALSE))
colnames(facenoseproportions) <- c("photo", "age", "areaphoto", "areaface", "areanose")

# Distance Nose - Eyes
# Expectes a file created with python program FaceDetector writeDistanceNoseEyes method
faceeyedistances <- as.data.frame(read.csv(
  "distancenoseeye.csv", stringsAsFactors=FALSE, header=FALSE))
colnames(faceeyedistances) <- c("photo", "age", "left", "right")

# Distance Nose - Mouth 
# Expectes a file created with python program FaceDetector writeDistanceMouthNosemethod
mouthnosedistances <- as.data.frame(read.csv(
  "distancemouthnose.csv", stringsAsFactors=FALSE, header=FALSE))
colnames(mouthnosedistances) <- c("photo", "age", "distance")

# Plot photos by age 
gage <- ggplot(gt, aes(mean)) +
  geom_histogram(binwidth=1) +
  xlab("Edad") + ylab("Número de fotos") +
  #scale_y_continuous(labels=fancy_scientific) +
  ggtitle("Fotos disponibles por edad") +
  theme_bw()
print(gage)

# Plot face - nose proportions
# Apply default value to non detected face - nose proportions
facenoseproportions <- as.data.frame(cbind(
  facenoseproportions, 
  facenose = mapply(function(p, f, n) if (p == n | n / f > 0.3) { 0.1 } else n / f,
             facenoseproportions$areaphoto,
             facenoseproportions$areaface,
             facenoseproportions$areanose)))
# Compute linear regresion
regression <- lm(facenose ~ age, data = facenoseproportions)
# Plot
gfacenoseproportions <- ggplot(facenoseproportions, aes(x=age, y=facenose)) +
  geom_point(alpha=1) +
  geom_abline(intercept = regression$coefficients[1],
              slope = regression$coefficients[2],
              color = "red") +
  xlab("Edad") + ylab("Área nariz / área cara") +
  ggtitle("Proporción nariz / cara por edad") +
  theme_bw()
print(gfacenoseproportions)


# Plot face-eye distances
# Apply default value to non detected eye - nose distances 
faceeyedistances <- as.data.frame(cbind(
  faceeyedistances, 
  cleanleft = mapply(function(l, r) if (l == 0 | r == 0) { 0.0045 } else (l + r) / 2,
             faceeyedistances$left,
             faceeyedistances$right)))
# Compute linear regresion
regression <- lm(cleanleft ~ age, data = faceeyedistances)
# Plot
gfaceeyedistances <- ggplot(faceeyedistances, aes(x=age, y=cleanleft)) +
  ylim(0, 0.025) +
  geom_point(alpha = 1) +
  geom_abline(intercept = regression$coefficients[1],
              slope = regression$coefficients[2],
              color = "red") +
  xlab("Edad") + ylab("Distancia nariz ojo / área cara") +
  ggtitle("Distancia nariz a ojos / área cara por edad") +
  theme_bw()
print(gfaceeyedistances)

# Plot mouth nose distances
# Apply default value to non detected mouth- nose distances 
mouthnosedistances <- as.data.frame(cbind(
  mouthnosedistances, 
  cleandistance = mapply(function(d) if (d == 0 | d > 20) { 0.0025 } else d,
                         mouthnosedistances$distance)))
# Compute linear regresion
regression <- lm(cleandistance ~ age, data = mouthnosedistances)
# Plot
gmouthnosedistances<- ggplot(mouthnosedistances, aes(x=age, y=cleandistance)) +
  ylim(0, 0.025) +
  geom_point(alpha = 1) +
  geom_abline(intercept = regression$coefficients[1],
              slope = regression$coefficients[2],
              color = "red") +
  xlab("Edad") + ylab("Distancia nariz boca / área cara") +
  ggtitle("Distancia nariz a boca / área cara por edad") +
  theme_bw()
print(gmouthnosedistances)

# Build selection file
good <- as.data.frame(cbind(
  good, 
  s = mapply(function(p, f, n) if (p == n | n / f > 0.3) { 0.1 } else n / f,
             facenoseproportions$areaphoto,
             facenoseproportions$areaface,
             facenoseproportions$areanose)))
