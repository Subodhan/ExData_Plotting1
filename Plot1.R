d1 <- "1/2/2007"
d2 <- "2/2/2007"
download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "./household_power_consumption.zip")
unzip("./household_power_consumption.zip")
pwr<-subset(read.table("./household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?"), Date == d1 | Date == d2)

plot1 <- png(filename = "./Plot1.png", width = 480, height = 480)
hist(pwr$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
