path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, file.path(path, "data.zip"))

unzip("data.zip")

data <- read.table("household_power_consumption.txt", header = TRUE,
                   sep = ";", stringsAsFactors = FALSE, 
                   dec = ".")
head(data)

data_subset <- subset(data, data$Date %in% c("1/2/2007", "2/2/2007"))

par(mfrow = c(2,2))

## Plot the Global Active Power
GlobalActivePower <- as.numeric(data_subset$Global_active_power)

plot(datetime,GlobalActivePower, type = "l", xlab = "",
     ylab = "Global Active Power", cex = 0.2)

## Plot the Voltage 
Voltage <- as.numeric(data_subset$Voltage)

plot(datetime, Voltage, type = "l", xlab = "datetime",
     ylab = "Voltage")

## Plot the Energy Submetering
submetering1 <- as.numeric(data_subset$Sub_metering_1)
submetering2 <- as.numeric(data_subset$Sub_metering_2)
submetering3 <- as.numeric(data_subset$Sub_metering_3)

plot(datetime, submetering1, type = "l", xlab = "",
     ylab = "Energy Submetering")
lines(datetime, submetering2, type = "l", col = "red")
lines(datetime, submetering3, type = "l", col = "blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, col = c("black", "red", "blue"), cex = 0.5)

## Plot the Global Reactive Power
GlobalReactivePower <- as.numeric(data_subset$Global_reactive_power)

plot(datetime, GlobalReactivePower, type = "l")

dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()
