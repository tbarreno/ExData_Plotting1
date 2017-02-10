#############################################################################
#
# Explanatory Data Analysis - Course Project 1
#
# plot3.R : Global active power vs. Frequency
#
#############################################################################


# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------

# Data file
data_file <- "../data/household_power_consumption.txt"

# ---------------------------------------------------------------------------
# Data loading
# ---------------------------------------------------------------------------

# Run a filter pipe to load only 1/2/2017-2/2/2017 data
data <- read.csv2(
  pipe( sprintf("grep -E '^Date|^[12]/2/2007' %s", data_file) ),
  header = TRUE )

# Column conversion
data$Time <- as.POSIXct(as.character(paste(data$Date, data$Time)),format="%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(as.character(data$Date),format="%d/%m/%Y")
for( column in c(3, 4, 5, 6, 7, 8, 9))
{
  data[,column] <- as.numeric(as.character(data[,column]))
}


# ---------------------------------------------------------------------------
# Plot
# ---------------------------------------------------------------------------

# Open the PNG device
png( filename = "plot3.png", width = 480, height = 480 )

# Prepare the plots
plot(data$Time, data$Sub_metering_1, type="n",
       ylab="Energy sub metering", xlab="" )

# Plot the lines
lines(data$Time, data$Sub_metering_1)
lines(data$Time, data$Sub_metering_2, col="red")
lines(data$Time, data$Sub_metering_3, col="blue")

# Set the legend
legend_titles = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legend("topright", legend = legend_titles,
       col=c("black", "red", "blue"),
       lty=c(1, 1, 1) )

# Close the device
dev.off()
