# This program crates a line graph plot of "Global Active Power" over time
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
T <- na.omit(subset(T,select=c(posTime,Global_active_power)))
# Opening png device
png(filename = "plot2.png", width = 480, height = 480, units = "px")
# plotting the graph
plot(T$posTime,T$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
#closing the device
dev.off()
