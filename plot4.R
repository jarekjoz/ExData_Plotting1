
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
png(filename="./plots/plot4.png")
par(mfrow= c(2,2), mar = c(4,4,3,2), cex = "0.75")
### Subgraph 1
plot(data$Date2, data[,3], 
     type = "l", 
     xlab="", 
     ylab="Global Active Power ")
### Subgraph 2
plot(data$Date2, data[,5], 
     type = "l", 
     xlab="datetime", 
     ylab="Voltage")
### Subgraph 3
plot(data$Date2, data[,7], type = "l", xlab="", ylab="Energy sub metering")
lines(data$Date2, data[,8], col = "red")
lines(data$Date2, data[,9], col = "blue")
legend("topright", 
       lty = 1,
       bty = "n",
       col = c("black", "red", "blue"), 
       legend = names(data[,c(7:9)]))
### Subgraph 4
plot(data$Date2, data[,4], 
     type = "l", 
     xlab="datetime", 
     ylab="Global_reactive_power")
dev.off()