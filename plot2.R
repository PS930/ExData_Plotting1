#############################################
#Exploratory Data Analysis Project 1: Plot 2#
#############################################

#Downloaded the file from: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#Saved it to a file that will be my working directory.
#Set my working directory where the downloaded file is located
setwd("~/Courses-Copied from Work laptop/Coursera/R Projects & Quizes for Coursera/4- Exploratory Data Analysis")

#Read the file in my working directory & select Feb 1 & 2
plot2file = read.table("household_power_consumption.txt",sep=";",dec=".",header=TRUE,stringsAsFactors=FALSE,na.strings="?",
                       colClasses=c(rep("character",2), rep("numeric",7)))

#Select both dates in one subset and create a new data frame
plot2file2 = subset(plot2file, plot2file$Date == "1/2/2007" | plot2file$Date == "2/2/2007") 
unique(plot2file2$Date) #Check unique subsetted values. "1/2/2007" & "2/2/2007" printed in output, which means subset worked
plot2file <- NA #Delete plot2file from global environment because it is not needed anymore

#To make the x-axis look continuous to match assignment, combine Date and Time into a new column
plot2file2$DateTime <- with(plot2file2, paste(Date, Time)) 
class(plot2file2$DateTime) #The class of the new DateTime column is "character"

#Change class of DateTime to appropriate time & date format
plot2file2$DateTime <- strptime(plot2file2$DateTime, "%d/%m/%Y %H:%M:%S") 
class(plot2file2$DateTime) #The class is now "POSIXlt" "POSIXt" which is good

#Create the plot. Use type = "l" to connect data points with a line; otherwise only points will appear.
plot(plot2file2$DateTime, plot2file2$Global_active_power, type="l", xlab = NA, ylab="Global Active Power (kilowatts)") #xlab = NA erased the automatic x-axis label

#Create a png of the plot by copying plot to PNG file. Will be saved to working directory
dev.copy(png, file = "plot2.png", width=480, height=480) 
dev.off() #close the png file in R so I can view the file