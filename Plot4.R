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

plot4 <- png(filename = "./Plot4.png", width = 480, height = 480)

par(mfrow=c(2,2), mar=c(4,4,2,1))

plot(pwr1$NewDateTime, pwr1$Global_active_power, type="n", xlab="", ylab="Global Active Power")
lines(pwr1$NewDateTime, pwr1$Global_active_power, type="l")

plot(pwr1$NewDateTime, pwr1$Voltage, type="n", xlab="datetime", ylab="Voltage")
lines(pwr1$NewDateTime, pwr1$Voltage, type="l")

plot(pwr1$NewDateTime, pwr1$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
lines(pwr1$NewDateTime, pwr1$Sub_metering_1, type="l")
lines(pwr1$NewDateTime, pwr1$Sub_metering_2, type="l", col="red")
lines(pwr1$NewDateTime, pwr1$Sub_metering_3, type="l", col="blue")
legend("topright", lty = c(1,1,1), col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

plot(pwr1$NewDateTime, pwr1$Global_reactive_power, type="n", xlab="datetime", ylab="Gobal_reactive_power")
lines(pwr1$NewDateTime, pwr1$Global_reactive_power, type="l")

dev.off()
