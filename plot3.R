#############################################
#Exploratory Data Analysis Project 1: Plot 3#
#############################################

#Downloaded the file from: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#Saved it to a file that will be my working directory.
#Set my working directory where the downloaded file is located
setwd("~/Courses-Copied from Work laptop/Coursera/R Projects & Quizes for Coursera/4- Exploratory Data Analysis")

#Read the file in my working directory & select Feb 1 & 2
plot3file = read.table("household_power_consumption.txt",sep=";",dec=".",header=TRUE,stringsAsFactors=FALSE,na.strings="?",
                       colClasses=c(rep("character",2), rep("numeric",7)))

#Select both dates in one subset and create a new data frame; the subset works because it was checked in plot2 (separate R script)
plot3file2 = subset(plot3file, plot3file$Date == "1/2/2007" | plot3file$Date == "2/2/2007") 
plot3file <- NA #Delete plot2file from global environment because it is not needed anymore

#To make the x-axis look continuous to match assignment, combine Date and Time into a new column
plot3file2$DateTime <- with(plot3file2, paste(Date, Time)) 
class(plot3file2$DateTime) #The class of the new DateTime column is "character"

#Change class of DateTime to appropriate time & date format
plot3file2$DateTime <- strptime(plot3file2$DateTime, "%d/%m/%Y %H:%M:%S") 
class(plot3file2$DateTime) #The class is now "POSIXlt" "POSIXt" which is good

#Create plot one sub meter at a time; the 1st & 2nd values are x & y values. DateTime is always the X value
plot(plot3file2$DateTime, plot3file2$Sub_metering_1, type="l", xlab = NA, ylab="Energy sub metering")
#Use lines function to add meters to the plot
lines(plot3file2$DateTime, plot3file2$Sub_metering_2, type="l", col="red")
lines(plot3file2$DateTime, plot3file2$Sub_metering_3, type="l", col="blue")
#Insert legend on top right. Size the plot viewer in R Studio manually by dragging so it is somewhat the size of 480x480 pixels or else legend will be huge
legend("topright", lty="solid", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Create a png of the plot by copying plot to PNG file. Will be saved to working directory
dev.copy(png, file = "plot3.png", width=480, height=480) 
dev.off() #close the png file in R so I can view the file