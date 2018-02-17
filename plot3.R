# Set up

Sys.setlocale("LC_TIME", "en_US.UTF-8")

library(readr)


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
p <- strptime(d$Date, "%d/%m/%Y")
t <- as.Date(p, "%d/%m/%Y")


# Create a file with a plot
png(file="plot3.png",
    width = 480, 
    height = 480, 
    units = "px")

plot(d$Sub_metering_1, 
      col="black", 
      ylab=c("Energy sub metering"), 
      typ="l",
      xlab="",
      xaxt="n")

lines(d$Sub_metering_2, col="red")
lines(d$Sub_metering_3, col="blue")
legend("topright",
       legend=c("Sub_metering_1",
                "Sub_metering_2",
                "Sub_metering_3"),
	lty=c(1,1,1),
        col=c("black","red","blue"))

axis.Date(1, t, format="%a")


dev.off()

