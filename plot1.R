#############################################
#Exploratory Data Analysis Project 1: Plot 1#
#############################################

#Downloaded the file from: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#Saved it to a file that will be my working directory.
#Set my working directory where the downloaded file is located
setwd("~/Courses-Copied from Work laptop/Coursera/R Projects & Quizes for Coursera/4- Exploratory Data Analysis")

#Read in the file in my working directory
plot1file = read.table("household_power_consumption.txt",sep=";",dec=".",header=TRUE,stringsAsFactors=FALSE,na.strings="?",
      colClasses=c(rep("character",2), rep("numeric",7)))

#Check to see how many observations there are for Feb 1st and Feb 2nd
plotfile2 = subset(plot1file, plot1file$Date == '1/2/2007') #1440 observations
plotfile3 = subset(plot1file, plot1file$Date == '2/2/2007') #1440 observations as well

#Select both dates in one subset
plot1file3 = subset(plot1file, plot1file$Date == "1/2/2007" | plot1file$Date == "2/2/2007") #This has 2880 observations, which seems like it selected the right dates 

#Delete objects I created to count observations for each date:
plotfile2 <- NA
plotfile3 <- NA

#test the class of Date and Time columns
class(plot1file3$Date) #character
class(plot1file3$Time) #character

#Now, change Date column to Date object because they are class "character"
plot1file3$Date <- as.Date(plot1file3$Date, format="%d/%m/%Y") #convert the Date column into Date class.
plot1file3$Time <- strptime(plot1file3$Time, "%H:%M:%S") #convert Time col to Time class (POSIXlt, POSIXt)

#Create histogram with appropriate main title and color
hist(plot1file3$Global_active_power, 12, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

#Copy plot 1 to a PNG file with a width of 480 pixels and a height of 480 pixels
dev.copy(png, file = "plot1.png", width=480, height=480) #copy histogram to PNG file, saved to working directory
dev.off() #close the png file in R so I can view the file
