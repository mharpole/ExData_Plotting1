myData <- read_delim("household_power_consumption.txt",
                     na=c("?"),
                     show_col_types = FALSE) %>% 
  mutate(Date=lubridate::dmy(Date)) %>% 
  filter(between(Date, as.Date('2007-02-01'), as.Date('2007-02-02'))) %>% 
  mutate(DateTime = lubridate::ymd_hms(paste(myData$Date,myData$Time)) )

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
       col = c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.copy(png,"plot3.png")
dev.off()