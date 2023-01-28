
myFiles <- list.files(pattern="*.txt")
myFiles
myData <- read_delim(myFiles[1],na="?",show_col_types = FALSE) %>% 
  mutate(Date=lubridate::dmy(Date)) %>% 
  filter(between(Date, as.Date('2007-02-01'), as.Date('2007-02-02')))
# only want dates between 2007-02-01 and 2007-02-02
summary(myData)
head(myData)
names(myData)
hist(myData$Global_active_power,col = "red",
     xlab = "Global Active Power (kilowats)",
     main="Global Active Power")
dev.copy(png,"plot1.png")
dev.off()