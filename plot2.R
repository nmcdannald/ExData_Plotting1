#########################################################################
##      Create Date:    01-07-2014
##      Author:         Nick McDannald
##      Description:    Reads in household_power_consumption.txt and
##                      creates a line plot png file of the 
##                      Global Active Power of during the timeframe of
##                      02/01/2007 through 02/03/2007 
##      Packages:       data.table, dplyr
#########################################################################

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

## make a line plot of Global active power over the three days in timeframe
plot(sub_hpc$datetime,sub_hpc$Global_active_power, type="l",
     +      ylab="Global Active Power (kilowatts)",xlab = "")

## Create png file of the line plot
dev.copy(png, file ="plot2.png")
dev.off()