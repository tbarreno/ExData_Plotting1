#############################################################################
#
# Explanatory Data Analysis - Course Project 1
#
# plot2.R : Time vs. Global active power
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
png( filename = "plot2.png", width = 480, height = 480 )

# Do the plot
plot(data$Time, data$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")


# Close the device
dev.off()
