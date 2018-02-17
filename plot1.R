# Set up

Sys.setlocale("LC_TIME", "en_US.UTF-8")

library(readr)
library(lubridate)

# Get column names
cn <- names(read_delim("../data/household_power_consumption.txt", ";", n_max = 0))

# Read in from a specific range 
# Lines located with: grep -n "^2/1/2007" household_power_consumption.txt |head (and tail)
d <- read_delim("../data/household_power_consumption.txt",
		col_names=cn,
	   	";", 
	   	na = c("?", "NA"),
	   	skip = 66637,
	   	n_max = 2880)

# Convert to date format
d$Date <- dmy(d$Date)


# Create a file with a plot
png(file="plot1.png",
    width = 480, 
    height = 480, 
    units = "px")

 hist(d$Global_active_power, 
      col="red", 
      xlab=c("Global Active Power (kilowatts)"), 
      main="Global Active Power")

dev.off()

