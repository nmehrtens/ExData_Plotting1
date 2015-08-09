# Script for producting plot4.png


# download in data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "power_consumption.zip"
download.file(url, destfile=destfile, method="curl")
unzip("power_consumption.zip")

#read in dadta
data <- read.csv2("household_power_consumption.txt")

#set date as a Date class and subset on 1st-2nd Feb 2007
data$Date <- as.Date(data$Date, "%d/%m/%Y")
febData <- data[data$Date >="2007-02-01" & data$Date <="2007-02-02",]


# create a date / time variable.
datetime <- paste(febData$Date, febData$Time)
datetime <- strptime(datetime, "%Y-%m-%d %H:%M:%S")


# data has been read in a factor variable.
# To turn it into a numeric, first convert it to a character variable,
# so it uses the values and not the levels as data.

globalActivePower <- as.numeric(as.character(febData$Global_active_power))
subMetering1 <- as.numeric(as.character(febData$Sub_metering_1))
subMetering2 <- as.numeric(as.character(febData$Sub_metering_2))
subMetering3 <- as.numeric(as.character(febData$Sub_metering_3))
voltage <- as.numeric(as.character(febData$Voltage))
globalReactivePower <- as.numeric(as.character(febData$Global_reactive_power))


png("plot4.png", width=480, height=480)

# presenting 2x2 panel plot 
par(mfrow = c(2, 2))

#top left
plot(datetime,globalActivePower, ylab="Global Active Power", xlab="", type="l")

#top right
plot(datetime, voltage, type="l", ylab="Voltage")

#bottom left
plot(datetime,subMetering1, ylab="Energy sub metering", xlab="",type="l")
lines(datetime,subMetering2, col="red")
lines(datetime,subMetering3, col="blue")

# this time turning off legend boarder
legend(x="topright",
      col = c("black", "red", "blue"),
      legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
      lwd=1, lty=c(1,1,1), bty = "n")

#bottom right
plot(datetime, globalReactivePower, type="l", ylab="Global_reactive_power")

dev.off()


