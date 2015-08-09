# Script for prodicing plot1.png

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


# Global active power is read in a factor variable.
# To turn it into a numeric, first convert it to a character variable,
# so that it uses the values and not the levels as data.
globalActivePower <- as.numeric(as.character(febData$Global_active_power))


png("plot1.png", width=480, height=480)
hist(globalActivePower, main="Global Active Power", pch=10, xlab="Global Active Power (kilowatts)", col="red")
dev.off()

