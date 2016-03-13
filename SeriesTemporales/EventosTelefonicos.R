
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

colorlag <- function(lag, firstperiod) {
  c <- rep("#262626", 41)
  if (lag != 0) {
    r <- (1:40 %% 7) == 0
    for (i in 0:40 ) {
      m <- i %% 7 
      if (m == 0 && i != 0) {
        c[i+1] = "red"
      }
    }
  }
  if (firstperiod != 0) {
    for (i in 2:firstperiod) {
      c[i] = "blue"
    }
  }
  return(c)
}

# Diferentiate data at given lag
differentiate <- function(data, lag, xlab, ylab, title) {
  lag <- lag
  diferentiated <- data.frame(day=1:(length(data)-lag), events= diff(data, lag))
  gdiff <- ggplot(diferentiated, aes(day, events)) +
    geom_line(alpha = 1) +
    xlab(xlab) + ylab(ylab) +
    scale_y_continuous(labels=fancy_scientific) +
    ggtitle(title) +
    theme_bw()
  print(gdiff)
  return(diferentiated)
}

# Get autocorrelation function to be plotted
autocorrelation <- function(data, title, lag = 0, firstperiod = 0) {
  autocovariance <- data.frame(x = 0:40, y = acvf(data))
  autocorrelation <- data.frame(x = 0:40, y = autocovariance$y / autocovariance$y[1], c=colorlag(lag, firstperiod))
  gautocorrelation <- ggplot(autocorrelation, aes(x, y)) +
    geom_bar(stat = "identity", alpha = 1, fill=autocorrelation$c) +
    geom_abline(intercept = 1.96 / sqrt(length(data)),
                slope = 0, linetype = 2) +
    geom_abline(intercept = -(1.96 / sqrt(length(data))),
                slope = 0, linetype = 2) +
    xlab("Retardo") + ylab("Autocorrelación") +
    ggtitle(title) +
    theme_bw()
}

# Get partial autocorrelation function to be plotted
partialautocorrelation <- function(data, title, lag = 0, firstperiod = 0) {
  pacv <- data.frame(x = 0:40,
                     y = c(1, acf(data,
                             lag.max=40,
                             type="partial",
                             plot=FALSE)$acf))
  pac <- data.frame(x = 0:40, y = pacv$y / pacv$y[1], c=colorlag(lag, firstperiod))
  gpac <- ggplot(pac, aes(x, y)) +
    geom_bar(stat = "identity", alpha = 1, fill=pac$c) +
    geom_abline(intercept = 1.96 / sqrt(length(data)),
                slope = 0, linetype = 2) +
    geom_abline(intercept = -(1.96 / sqrt(length(data))),
                slope = 0, linetype = 2) +
    xlab("Retardo") + ylab("Autocorrelación parcial") +
    ggtitle(title) +
    theme_bw()
}

# Read Data
data <- as.data.frame(read.csv("EventosPocos.csv", header=FALSE))
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

# Plot autocorrelation function
gacf <- autocorrelation(data$events, "Función de autocorrelación")
print(gacf)

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

# Differentiate at lag 7 to remove weekly seasonal pattern
eventsdiff <- differentiate(data$events,
                            7,
                            "Días",
                            "Número de eventos telefónicos",
                            "Eliminación de tendencia y estacionalidad. Diferenciación")

# Plot autocorrelation function
gacf <- autocorrelation(eventsdiff$events, "Función de autocorrelación de serie diferenciada", 0, 0)
print(gacf)

# Plot partial autocorrelation function
gpacf <- partialautocorrelation(eventsdiff$events, "Función de autocorrelación parcial de serie diferenciada", 7, 7)
print(gpacf)

# Adjust model to the differenced data

 
