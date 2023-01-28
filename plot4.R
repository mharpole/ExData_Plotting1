myData <- read_delim("household_power_consumption.txt",
                     na=c("?"),
                     show_col_types = FALSE) %>% 
  mutate(Date=lubridate::dmy(Date)) %>% 
  filter(between(Date, as.Date('2007-02-01'), as.Date('2007-02-02'))) %>% 
  mutate(DateTime = lubridate::ymd_hms(paste(myData$Date,myData$Time)) )
par(mfrow=c(2,2))
plot(myData$DateTime,
     myData$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowats)")
plot(myData$DateTime,
     myData$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")
plot(myData$DateTime,
     myData$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Enerygy sub metering")
lines(myData$DateTime,
      myData$Sub_metering_2,
      col="red")
lines(myData$DateTime,
      myData$Sub_metering_3,
      col="blue")
legend("topright",
       lty = c(1,1,1),
       bty = "n",
       cex = 0.7,
       col = c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(myData$DateTime,
     myData$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")
dev.copy(png,"plot4.png")
dev.off()