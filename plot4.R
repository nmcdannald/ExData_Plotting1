#########################################################################
##      Create Date:    01-07-2014
##      Author:         Nick McDannald
##      Description:    Reads in household_power_consumption.txt and
##                      creates a line plot png file of four different 
##                      line graphs during the timeframe of
##                      02/01/2007 through 02/03/2007:
##                              1) Global Active Power (kilowatts)
##                              2) Voltage
##                              3) Energy Sub Metering
##                              4) Global Reactive Power
##      Packages:       downloader, data.table, dplyr
#########################################################################


## If data file not in working directory, download and unzip the file
if(!file.exists("household_power_consumption.txt")) {
        library(downloader)
        url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download(url,dest="hpc.zip") 
        unzip ("hpc.zip")
}

## Use fread() function in data.table to efficiently read in the large file
library(data.table)
hpc <- fread("household_power_consumption.txt", na.strings = "?")

## Convert the Date field from char to date for filtering
hpc$Date <- as.Date(hpc$Date,"%d/%m/%Y")

## Use filter() function in dplyr to get subset of data we are interested in
library(dplyr)
sub_hpc <- filter(hpc, Date >= as.Date("2007-02-01 00:00:00"), 
                        Date < as.Date("2007-02-03 00:00:00"))

## Remove hpc data.frame to free up space 
rm(hpc)

## Combine date and time field to plot through time 
sub_hpc$datetime <- as.POSIXct(paste(sub_hpc$Date, sub_hpc$Time), 
                               "%d/%m/%Y %H:%M:%S")

## set the graphical parameters to fit four graphs on one screen
par(mfrow = c(2,2))

## make a line plot of Global active power over the three days in timeframe
plot(sub_hpc$datetime,sub_hpc$Global_active_power, type="l",
        ylab="Global Active Power (kilowatts)",xlab = "")

## make a line plot of Voltage over the three days in timeframe
plot(sub_hpc$datetime,sub_hpc$Voltage, type="l", 
        ylab="Voltage",xlab = "datetime")

## make a line plot of Energy Sub Metering 1 over the three days in timeframe
plot(sub_hpc$datetime,as.numeric(sub_hpc$Sub_metering_1), type="l",
     ylab="Energy sub metering",xlab = "")
        
        ## Add Sub Metering 2 and Sub Metering 3 lines to line graph
        lines(sub_hpc$datetime, sub_hpc$Sub_metering_2, col = "red")
        lines(sub_hpc$datetime, sub_hpc$Sub_metering_3, col = "blue")

        ## Make the legend for sub metering 3 graph
        legend("topright", col=c("black","red","blue"), 
                c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
                lty=1, lwd=1.5, cex=0.65, bty="n")

## make a line plot of Global reactive power over the three days in timeframe
plot(sub_hpc$datetime,sub_hpc$Global_reactive_power, type="l", 
     ylab="Global_reactive_power",xlab = "datetime")

## Create png file of the line plots
dev.copy(png, file ="plot4.png",width = 480, height = 480)
dev.off()