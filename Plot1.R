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


#PLOT 1
png("plot1.png", width = 480, height = 480)

# Create the histogram
hist(as.numeric(data$Global_active_power),
     main = "Global Active Power", 
     xlab = "Global Active Power (killowatts)",
     ylab = "Frequency",
     col = "red")

dev.off()


