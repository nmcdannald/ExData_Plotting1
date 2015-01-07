#########################################################################
##      Create Date:    01/06/2014
##      Author:         Nick McDannald
##      Description:    
##      
##
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
                        Date < as.Date("2007-02-02 00:00:00"))

## Remove hpc data.frame to free up space 
rm(hpc)

