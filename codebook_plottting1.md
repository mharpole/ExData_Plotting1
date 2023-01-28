Exploratory Data Analysis Project 1 Codebook
================
Michael G Harpole
2023-01-28

# Plot 1

This plot is a histogram which shows the global active power in
kilowats. Components of the histogram:

- color of the bins are red.
- y axis label is frequency.
- x axis label is Global Active Power (kilowats).
- main title is Global Active Power

``` r
myFiles <- list.files(pattern="*.txt")
myFiles
```

    ## [1] "household_power_consumption.txt"

``` r
myData <- read_delim(myFiles[1],na="?",show_col_types = FALSE) %>% 
  mutate(Date=lubridate::dmy(Date)) %>% 
  filter(between(Date, as.Date('2007-02-01'), as.Date('2007-02-02')))
# only want dates between 2007-02-01 and 2007-02-02
summary(myData)
```

    ##       Date                Time          Global_active_power
    ##  Min.   :2007-02-01   Length:2880       Min.   :0.220      
    ##  1st Qu.:2007-02-01   Class1:hms        1st Qu.:0.320      
    ##  Median :2007-02-01   Class2:difftime   Median :1.060      
    ##  Mean   :2007-02-01   Mode  :numeric    Mean   :1.213      
    ##  3rd Qu.:2007-02-02                     3rd Qu.:1.688      
    ##  Max.   :2007-02-02                     Max.   :7.482      
    ##  Global_reactive_power    Voltage      Global_intensity Sub_metering_1   
    ##  Min.   :0.0000        Min.   :233.1   Min.   : 1.000   Min.   : 0.0000  
    ##  1st Qu.:0.0000        1st Qu.:238.4   1st Qu.: 1.400   1st Qu.: 0.0000  
    ##  Median :0.1040        Median :240.6   Median : 4.600   Median : 0.0000  
    ##  Mean   :0.1006        Mean   :240.4   Mean   : 5.102   Mean   : 0.4062  
    ##  3rd Qu.:0.1440        3rd Qu.:242.4   3rd Qu.: 7.000   3rd Qu.: 0.0000  
    ##  Max.   :0.5000        Max.   :246.6   Max.   :32.000   Max.   :38.0000  
    ##  Sub_metering_2   Sub_metering_3  
    ##  Min.   :0.0000   Min.   : 0.000  
    ##  1st Qu.:0.0000   1st Qu.: 0.000  
    ##  Median :0.0000   Median : 0.000  
    ##  Mean   :0.2576   Mean   : 8.501  
    ##  3rd Qu.:0.0000   3rd Qu.:17.000  
    ##  Max.   :2.0000   Max.   :19.000

``` r
head(myData)
```

    ## # A tibble: 6 × 9
    ##   Date       Time   Global_act…¹ Globa…² Voltage Globa…³ Sub_m…⁴ Sub_m…⁵ Sub_m…⁶
    ##   <date>     <time>        <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
    ## 1 2007-02-01 00'00"        0.326   0.128    243.     1.4       0       0       0
    ## 2 2007-02-01 01'00"        0.326   0.13     243.     1.4       0       0       0
    ## 3 2007-02-01 02'00"        0.324   0.132    244.     1.4       0       0       0
    ## 4 2007-02-01 03'00"        0.324   0.134    244.     1.4       0       0       0
    ## 5 2007-02-01 04'00"        0.322   0.13     243.     1.4       0       0       0
    ## 6 2007-02-01 05'00"        0.32    0.126    242.     1.4       0       0       0
    ## # … with abbreviated variable names ¹​Global_active_power,
    ## #   ²​Global_reactive_power, ³​Global_intensity, ⁴​Sub_metering_1,
    ## #   ⁵​Sub_metering_2, ⁶​Sub_metering_3

``` r
names(myData)
```

    ## [1] "Date"                  "Time"                  "Global_active_power"  
    ## [4] "Global_reactive_power" "Voltage"               "Global_intensity"     
    ## [7] "Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3"

``` r
hist(myData$Global_active_power,col = "red",
     xlab = "Global Active Power (kilowats)",
     main="Global Active Power")
```

![](codebook_plottting1_files/figure-gfm/plot%201-1.png)<!-- -->

``` r
dev.copy(png,"plot1.png")
```

    ## quartz_off_screen 
    ##                 3

``` r
dev.off()
```

    ## quartz_off_screen 
    ##                 2

# Plot 2

This plot is a line graph showing global active power across 3 days. The
graph componenets are:

- y label is Global Active Power (kilowats).
- x label is days of the week
- no main title

``` r
myFiles <- list.files(pattern="*.txt")
myFiles
```

    ## [1] "household_power_consumption.txt"

``` r
myData <- read_delim(myFiles[1],na=c("?"),show_col_types = FALSE) %>% 
  mutate(Date=lubridate::dmy(Date)) %>% 
  filter(between(Date, as.Date('2007-02-01'), as.Date('2007-02-02'))) %>% 
  mutate(DateTime = lubridate::ymd_hms(paste(myData$Date,myData$Time)) )

plot(myData$DateTime,
     myData$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowats)")
```

![](codebook_plottting1_files/figure-gfm/plot2-1.png)<!-- -->

``` r
dev.copy(png,"plot2.png")
```

    ## quartz_off_screen 
    ##                 3

``` r
dev.off()
```

    ## quartz_off_screen 
    ##                 2

# Plot 3

This is a multivariable graph showing energy sub_meeting across time
Components of graph:

- y label Energy sub metering
- x no label
- black line with sub_metering_1
- red line with sub_metering_3
- blue line with sub_metering_3
- legend with three sub headings and corresponding colors

``` r
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
```

![](codebook_plottting1_files/figure-gfm/plot3-1.png)<!-- -->

``` r
dev.copy(png,"plot3.png")
```

    ## quartz_off_screen 
    ##                 3

``` r
dev.off()
```

    ## quartz_off_screen 
    ##                 2

## Plot 4

There are 4 plots in the final graph. Plot2 is in the top left, voltage
versus datime is in top right, plot 3 is in bottom left, and globale
reactive power versus datetime is bottom right. Chart Components.

- Top Left
  - copy of plot2
- Top Right
  - y lable is voltage
  - x label is datetime
  - black line
- Bottom Left
  - copy of plot3
- Bottom Right +y label is Global_reactive_power

``` r
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
       inset=.02,
       cex = .75,
       lty = c(1,1,1),
       bty = "n",
       col = c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(myData$DateTime,
     myData$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")
```

![](codebook_plottting1_files/figure-gfm/plot4-1.png)<!-- -->

``` r
dev.copy(png,"plot4.png")
```

    ## quartz_off_screen 
    ##                 3

``` r
dev.off()
```

    ## quartz_off_screen 
    ##                 2

# Session Information

    ## R version 4.2.2 (2022-10-31)
    ## Platform: aarch64-apple-darwin20 (64-bit)
    ## Running under: macOS Ventura 13.1
    ## 
    ## Matrix products: default
    ## BLAS:   /Library/Frameworks/R.framework/Versions/4.2-arm64/Resources/lib/libRblas.0.dylib
    ## LAPACK: /Library/Frameworks/R.framework/Versions/4.2-arm64/Resources/lib/libRlapack.dylib
    ## 
    ## locale:
    ## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] forcats_0.5.2   stringr_1.5.0   dplyr_1.0.10    purrr_1.0.1    
    ## [5] readr_2.1.3     tidyr_1.2.1     tibble_3.1.8    ggplot2_3.4.0  
    ## [9] tidyverse_1.3.2
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] tidyselect_1.2.0    xfun_0.36           haven_2.5.1        
    ##  [4] gargle_1.2.1        colorspace_2.0-3    vctrs_0.5.1        
    ##  [7] generics_0.1.3      htmltools_0.5.4     yaml_2.3.6         
    ## [10] utf8_1.2.2          rlang_1.0.6         pillar_1.8.1       
    ## [13] withr_2.5.0         glue_1.6.2          DBI_1.1.3          
    ## [16] bit64_4.0.5         dbplyr_2.3.0        modelr_0.1.10      
    ## [19] readxl_1.4.1        lifecycle_1.0.3     munsell_0.5.0      
    ## [22] gtable_0.3.1        cellranger_1.1.0    rvest_1.0.3        
    ## [25] evaluate_0.20       knitr_1.41          tzdb_0.3.0         
    ## [28] fastmap_1.1.0       parallel_4.2.2      fansi_1.0.3        
    ## [31] highr_0.10          broom_1.0.2         scales_1.2.1       
    ## [34] backports_1.4.1     googlesheets4_1.0.1 vroom_1.6.0        
    ## [37] jsonlite_1.8.4      bit_4.0.5           fs_1.5.2           
    ## [40] hms_1.1.2           digest_0.6.31       stringi_1.7.12     
    ## [43] grid_4.2.2          cli_3.6.0           tools_4.2.2        
    ## [46] magrittr_2.0.3      crayon_1.5.2        pkgconfig_2.0.3    
    ## [49] ellipsis_0.3.2      xml2_1.3.3          reprex_2.0.2       
    ## [52] googledrive_2.0.0   lubridate_1.9.0     timechange_0.2.0   
    ## [55] assertthat_0.2.1    rmarkdown_2.20      httr_1.4.4         
    ## [58] rstudioapi_0.14     R6_2.5.1            compiler_4.2.2
