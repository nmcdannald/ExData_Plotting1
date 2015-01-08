#########################################################################
##      Create Date:    01-06-2014
##      Author:         Nick McDannald
##      Description:    Reads in household_power_consumption.txt and
##                      creates a histogram png file of the 
##                      Global Active Power field 
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

## make a histrogram of Global active power
hist(as.numeric(sub_hpc$Global_active_power),xlab="Global Active Power (kilowatts)",col="red",main = "Global Active Power")

## Create png file of histogram
dev.copy(png, file ="plot1.png",width = 480, height = 480)
dev.off()