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


electricdata <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", header = T, na.strings="?", stringsAsFactors=F)

#Look at the structure of dataframe to see how columns are classified
str(electricdata)

#Change date to date class
electricdata$Date <- as.Date(electricdata$Date, "%d/%m/%Y")

#Subset data using dplyr filter() to dates between "2007-02-01" and "2007-02-02"
subset1 <- filter(electricdata, Date >= "2007-02-01", Date <= "2007-02-02")


hist(subset1$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()