##################################################
## Exploratory Data Analysis
## Week 1 - Cousre Project
##
##
## Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels
## Name each of the plot files as plot1.png, plot2.png, etc.
## Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, 
## i.e. code in plot1.R constructs the plot1.png plot. 
## Your code file should include code for reading the data so that the plot can be fully reproduced. 
## You must also include the code that creates the PNG file.
##################################################

if(!require('lubridate')) {install.packages('lubridate')}

library(lubridate)
library(dplyr)
library(plyr)

#Download the zip files
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#When zip files are donwloaded, need to create temp path for decompressed data
temp <- tempfile()
download.file(fileurl, temp)

electricdata <- read.csv(unz(temp, "household_power_consumption.txt"), sep=";", header = T, na.strings="?", stringsAsFactors=F, comment.char="", quote='\"')

#Look at the structure of dataframe to see how columns are classified
str(electricdata)

#Change date to date class
electricdata$Date <- as.Date(electricdata$Date, "%d/%m/%Y")

#Subset data using dplyr filter() to dates between "2007-02-01" and "2007-02-02"
subset1 <- filter(electricdata, Date >= "2007-02-01", Date <= "2007-02-02")

#Format time
datetime <- paste(subset1$Date, subset1$Time)
subset1$datetime <- as.POSIXct(datetime)

#Set up plot parameters
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

#First plot
plot(subset1$datetime, subset1$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab= "")

#Second plot

plot(subset1$datetime, subset1$Voltage, type="l", ylab = "Voltage", xlab = "datetime")

#Third plot

plot(subset1$Sub_metering_1~subset1$datetime, type="l",
     ylab="Energy sub metering", xlab="")
lines(subset1$Sub_metering_2~subset1$datetime,col='Red')
lines(subset1$Sub_metering_3~subset1$datetime,col='Blue')

legend("topright", legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=1, lwd=2)

#Fourth plot

plot(subset1$datetime, subset1$Global_reactive_power, type="l", ylab = "Global_reactive_power", xlab = "datetime")


dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()