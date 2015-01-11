## Download the data

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile <- "./data/exdata-data-household_power_consumption.zip")   
unzip("./data/activity.zip")

## Read in data

household_power_consumption <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";")[66638:69517,]

## Convert and format Date and Time variables

household_power_consumption$Date <- as.Date(household_power_consumption$Date, format="%d/%m/%Y")
datetime <- paste(as.Date(household_power_consumption$Date), household_power_consumption$Time)
household_power_consumption$Datetime <- as.POSIXct(datetime)

# Convert Global Power Consumption to numeric

household_power_consumption$Global_active_power <- as.numeric(as.character(household_power_consumption$Global_active_power))

## Convert to numerics, Create plot 

household_power_consumption$Sub_metering_1 <- as.numeric(as.character(household_power_consumption$Sub_metering_1))
with(household_power_consumption, plot(Datetime, Sub_metering_1, type = "l", xlab ="", ylab = "Energy sub metering", yaxp  = c(0, 40, 4)))

household_power_consumption$Sub_metering_2 <- as.numeric(as.character(household_power_consumption$Sub_metering_2))
with(household_power_consumption, lines (Datetime, Sub_metering_2, col = "red"))

with(household_power_consumption, lines (Datetime, Sub_metering_3, col = "blue"))

legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.6)

## Copy plot 3 to a PNG file

dev.copy(png, file = "plot3.png") 
dev.off()