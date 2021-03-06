library(dplyr)

d1 <- "1/2/2007"
d2 <- "2/2/2007"
download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./household_power_consumption.zip")
unzip("./household_power_consumption.zip")
pwr<-subset(read.table("./household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?"), Date == d1 | Date == d2)

pwr1 <-  subset(pwr, !is.na(pwr$Global_active_power))

pwr1 <- mutate(pwr1, NewDateTime = paste(as.character(pwr1$Date), as.character(pwr1$Time)))

pwr1$Date = as.Date(as.character(pwr1$Date), format="%d/%m/%Y")

pwr1$NewDateTime <- strptime(pwr1$NewDateTime, format = "%d/%m/%Y %H:%M:%S")

plot2 <- png(filename = "./Plot2.png", width = 480, height = 480)
plot(pwr1$NewDateTime, pwr1$Global_active_power, type="n", xlab="", ylab="Global Active Power (kilowatts)")
lines(pwr1$NewDateTime, pwr1$Global_active_power, type="l")
dev.off()
