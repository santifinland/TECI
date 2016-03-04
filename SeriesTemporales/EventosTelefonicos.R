
# Import libraries
library("ggplot2")
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
trend <- mean(data$events)
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
