
# Import libraries
library("ggplot2")
#source("./itsmr.R")
library("itsmr")

# Function for ggplot2 axis formatting 
fancy_scientific <- function(l) {
  # turn in to character string in scientific notation
  l <- format(l, scientific = TRUE)
  # quote the part before the exponent to keep all the digits
  l <- gsub("^(.*)e", "'\\1'e", l)
  # turn the 'e+' into plotmath format
  l <- gsub("e", "%*%10^", l)
  # return this as an expression
  parse(text=l)
}

# Read Data
data <- as.data.frame(read.csv("EventosTelefonicos.csv", header=FALSE))
colnames(data) <- c("day", "events", "weekday")

# Plot temporal serie 
gdata <- ggplot(data, aes(data$day, data$events)) +
  geom_line(alpha = 1) +
  ylim(0, max(data$events)) +
  xlab("Días") + ylab("Número de eventos telefónicos") +
  ggtitle("Eventos Red Móvil 2015") +
  theme_bw()
print(gdata)

# Plot number of events by weekday
gdays <- ggplot(data, aes(x = reorder(weekday, events), y = events)) +
  geom_bar(stat = "identity", alpha = 1) +
  ylab("Número de eventos telefónicos") +
  scale_y_continuous(labels=fancy_scientific) +
  ggtitle("Número de eventos telefónicos según día de la semana") +
  theme_bw()
print(gdays)

# Calulate trend
regression <- lm(events ~ day, data = data)
gdata <- gdata +
  geom_abline(intercept = regression$coefficients[1],
              slope = regression$coefficients[2],
              color = "red") +
  ggtitle("Tendencia eventos telefónicos")
print(gdata)

# Get autocovariance of data
autocovariance <- data.frame(x = 0:40, y = acvf(data$events))
autocorrelation <- data.frame(x = 0:40, y = autocovariance$y / autocovariance$y[1])
gautocorrelation <- ggplot(autocorrelation, aes(x, y)) +
  geom_bar(stat = "identity", alpha = 1) +
  xlab("Retardo") + ylab("Autocorrelación") +
  ggtitle("Función de autocorrelación") +
  theme_bw()
print(gautocorrelation)

# Classical decomposition
trend <- trend(data$events, 1) # Same calc using itsmr trend
dataminustrend <- data$events - trend
season <- season(dataminustrend, 7)
classical <- data.frame(x = data$day, y = dataminustrend - season)
gclassical <- ggplot(classical, aes(x, y)) +
  geom_line(alpha = 1) +
  xlab("Días") + ylab("Número de eventos telefónicos") +
  scale_y_continuous(labels=fancy_scientific) +
  ggtitle("Eliminación de tendencia y estacionalidad. Descomposición clásica.") +
  theme_bw()
print(gclassical)

# Differencing
lag <- 7
diff <- data.frame(day= 1:(length(data$day)-lag), events= diff(data$events, lag))
gdiff <- ggplot(diff, aes(day, events)) +
  geom_line(alpha = 1) +
  xlab("Días") + ylab("Número de eventos telefónicos") +
  scale_y_continuous(labels=fancy_scientific) +
  ggtitle("Eliminación de tendencia y estacionalidad. Diferenciación.") +
  theme_bw()
print(gdiff)

# Get autocovariance of differenced data
autocovariancediff <- data.frame(x = 0:40, y = acvf(diff$events))
autocorrelationdiff <- data.frame(x = 0:40, y = autocovariancediff$y / autocovariancediff$y[1])
gautocorrelationdiff <- ggplot(autocorrelationdiff, aes(x, y)) +
  geom_bar(stat = "identity", alpha = 1) +
  geom_abline(intercept = 1.96 / sqrt(length(diff$events)),
              slope = 0, linetype = 2) +
  geom_abline(intercept = -(1.96 / sqrt(length(diff$events))),
              slope = 0, linetype = 2) +
  xlab("Retardo") + ylab("Autocorrelación") +
  ggtitle("Función de autocorrelación de serie diferenciada") +
  theme_bw()
print(gautocorrelationdiff)

# Get partial autocovariance of differenced data
pacvdiff <- data.frame(x = 0:39,
                       y = acf(diff$events,
                               lag.max=40,
                               type="partial",
                               plot=FALSE)$acf)
pacdiff <- data.frame(x = 0:39, y = pacvdiff$y / pacvdiff$y[1])
gpacdiff <- ggplot(pacdiff, aes(x, y)) +
  geom_bar(stat = "identity", alpha = 1) +
  geom_abline(intercept = 1.96 / sqrt(length(diff$events)),
              slope = 0, linetype = 2) +
  geom_abline(intercept = -(1.96 / sqrt(length(diff$events))),
              slope = 0, linetype = 2) +
  xlab("Retardo") + ylab("Autocorrelación parcial") +
  ggtitle("Función de autocorrelación parcial de serie diferenciada") +
  theme_bw()
print(gpacdiff)
