data <- read.csv("raw.csv", sep = ";", na.strings = "")
data$Unit.Cost <- scan(text = data$Unit.Cost, dec = ",", sep = ".")
data$OrderDate <- as.Date(data$OrderDate, "%m.%d.%y")
data$Total <- data$Units * data$Unit.Cost
data

a <- mean(data$Units)
b <- mean(data$Unit.Cost)
c <- mean(data$Total)


mean <- c(a,b,c)

a <- sum(data$Units)
b <- sum(data$Unit.Cost)
c <- sum(data$Total)

somme <- c(a,b,c)



traitment <- data.frame(mean = mean, somme = somme, row.names = c("Units", "Unit Cost", "Total"))
traitment <- t(traitment)
traitment

rate <- fromJSON(file="https://api.exchangeratesapi.io/latest?symbols=CHF&base=USD")$rates$CHF

paste("Valeur totale des ventes en CHF:", sum(data$Total)*rate)

data[data$Units < mean(data$Units),]

data[is.na(data$Rep),]

ggplot(data = data) + geom_point(mapping=aes(y = data$Unit.Cost, x= data$OrderDate)) + geom_smooth(mapping = aes(x=data$OrderDate, y = data$Unit.Cost)) + labs(x ="Order date", y = "Unit Cost")
