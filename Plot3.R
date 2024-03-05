#rm(list = ls())
library(tidyverse)


# URL of the dataset
url <- "https://archive.ics.uci.edu/static/public/235/individual+household+electric+power+consumption.zip"


# file name
energy_data <- basename(url)

# Download data into your working directory
download.file(url, energy_data, mode = "wb")

unzip(energy_data)



#Reading raw data, filtering by those two days, and adding a new column "weekday"
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE) %>% 
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>% 
  mutate(weekday = if_else(Date == "1/2/2007", "Thu", "Fri")) 

# Combining Date and Time columns
data$date_time <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")


#PLOT 3
png("plot3.png", width = 480, height = 480)

# Create an empty plot with the first line
plot(data$date_time, data$Sub_metering_1, type = "l",
     xlab = "Date/Time",
     ylab = "Energy Sub Metering",
     col = "black", # Set color for the first line
     main = "Energy Sub Metering Over Time")

# Add the second line
lines(data$date_time, data$Sub_metering_2, col = "red")

# Add the third line
lines(data$date_time, data$Sub_metering_3, col = "blue")

# Add a legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"),
       lty = 1,
       bty = "n", 
       cex = 0.8)


dev.off()


