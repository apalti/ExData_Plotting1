# This program crates 4 line graphs reflecting electricity consumption
#
#
setwd("c:/Users/apalti/coursera/ExData_Plotting1")
# Function for Reading ONLY the relevant date range from the table 
ReadFrom <- function(filename, startDate, endDate){
    sno<-grep(startDate, readLines(filename))[1]
    eno <- grep(endDate,readLines(filename))[1]
    lines <- eno-sno + 1
    dat <- read.table(filename,  nrows = lines, skip=sno-1, header=FALSE, 
                      sep=";",na.strings = "?") 
    names(dat) <- unlist(read.table(filename, nrows=1, stringsAsFactors=F, 
                                    sep=";")) # insert header from row 1 of .csv file
    return(dat)
}
# Reading the table, only dates between 1/2/2007 - 3/2/2007 are relevant
T <- ReadFrom("household_power_consumption.txt", "1/2/2007","3/2/2007")
T$posTime <- strptime(paste(T$Date,T$Time),"%d/%m/%Y %H:%M:%S")
T <- na.omit(subset(T,select=c(posTime,Global_reactive_power,Voltage,Global_active_power,Sub_metering_1,Sub_metering_2,Sub_metering_3)))

# Opening png device
png(filename = "plot4.png", width = 480, height = 480, units = "px")
# 4 figures arranged in 2 rows and 2 columns
par(mfrow=c(2,2))
# plotting the graphs
plot(T$posTime,T$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
plot(T$posTime,T$Voltage,type="l",xlab="datetime",ylab="Voltage")
plot(T$posTime,T$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(T$posTime,T$Sub_metering_2,type="l",col="red")
lines(T$posTime,T$Sub_metering_3,type="l",col="blue")
legend("topright",inset=.02,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col= c("black","red","blue"), lty=1, cex=0.8,box.lty=0)
plot(T$posTime,T$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
#closing the device
dev.off()
