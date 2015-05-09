#############################################
#Exploratory Data Analysis Project 1: Plot 4#
#############################################

#Downloaded the file from: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#Saved it to a file that will be my working directory.
#Set my working directory where the downloaded file is located
setwd("~/Courses-Copied from Work laptop/Coursera/R Projects & Quizes for Coursera/4- Exploratory Data Analysis")

#Read the file in my working directory & select Feb 1 & 2
plot4file = read.table("household_power_consumption.txt",sep=";",dec=".",header=TRUE,stringsAsFactors=FALSE,na.strings="?",
                       colClasses=c(rep("character",2), rep("numeric",7)))

#Select both dates in one subset and create a new data frame; the subset works because it was checked in plot2 (separate R script)
plot4file2 = subset(plot4file, plot4file$Date == "1/2/2007" | plot4file$Date == "2/2/2007") 
plot4file <- NA #Delete plot2file from global environment because it is not needed anymore

#To make the x-axis look continuous to match assignment, combine Date and Time into a new column
plot4file2$DateTime <- with(plot4file2, paste(Date, Time)) 
class(plot4file2$DateTime) #The class of the new DateTime column is "character"

#Change class of DateTime to appropriate time & date format
plot4file2$DateTime <- strptime(plot4file2$DateTime, "%d/%m/%Y %H:%M:%S") 
class(plot4file2$DateTime) #The class is now "POSIXlt" "POSIXt" which is good

par(mfrow=c(2,2))
with(plot4file2, { #with() permits you to define dataframe once without having to call it when subsetting column names. When I removed
    plot(DateTime, Global_active_power, type="l", xlab = NA, ylab = "Global Active Power") #xlab = NA erased the automatic x-axis label)
    plot(DateTime, Voltage, type="l", xlab="datetime", ylab="Voltage")
    plot(DateTime, Sub_metering_1, type="l", xlab = NA, ylab="Energy sub metering")
        #Use lines function to add meters to the plot
        lines(DateTime, Sub_metering_2, type="l", col="red")
        lines(DateTime, Sub_metering_3, type="l", col="blue")
        #Insert legend on top right. Size the plot viewer in R Studio manually by dragging so it is somewhat the size of 480x480 pixels or else legend will be huge
        legend("topright", border=0, bty="n", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(DateTime, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
    })

#Create a png of the plot by copying plot to PNG file. Will be saved to working directory
dev.copy(png, file = "plot4.png", width=480, height=480) 
dev.off() #close the png file in R so I can view the file
