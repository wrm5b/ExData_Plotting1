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

## Create plot 2

with(household_power_consumption, plot(Datetime, Global_active_power, type = "l", xlab ="", ylab = "Global Active Power (kilowatts)"))

## Copy plot 2 to a PNG file

dev.copy(png, file = "plot2.png") 
dev.off()