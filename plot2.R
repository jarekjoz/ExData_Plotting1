## reads data
hpc <- read.table("./data/household_power_consumption.txt", sep= ";", header = TRUE)
## converts date to POSIX
hpc[,1] <- as.character(hpc[,1])
hpc[,2] <- as.character(hpc[,2])
hpc$Date2 <- paste(hpc[,1], hpc[,2], sep = " ")
require(lubridate)
hpc$Date2 <- dmy_hms(hpc$Date2)
## subsets only the data from 2007-02-01 and 2007-02-02
data <- hpc[year(hpc$Date2) == "2007" 
            & month(hpc$Date2) == "2" 
            & c(day(hpc$Date2) == "1" | day(hpc$Date2) == "2"),]
## converts factors to numbers
for (i in 3:9) {
      data[,i] <- as.numeric(as.character(data[,i]))
}
## plots graph
png(filename="./plots/plot2.png")
plot(data$Date2, data[,3], 
     type = "l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")
dev.off()