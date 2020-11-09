path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, file.path(path, "data.zip"))

unzip("data.zip")

data <- read.table("household_power_consumption.txt", header = TRUE,
                   sep = ";", stringsAsFactors = FALSE, 
                   dec = ".")
head(data)

data_subset <- subset(data, data$Date %in% c("1/2/2007", "2/2/2007"))

submetering1 <- as.numeric(data_subset$Sub_metering_1)
submetering2 <- as.numeric(data_subset$Sub_metering_2)
submetering3 <- as.numeric(data_subset$Sub_metering_3)

datetime <- strptime(paste(data_subset$Date, data_subset$Time, sep = " "),
                     "%d/%m/%Y %H:%M:%S")

## Create the plot and add the first submetering
plot(datetime, submetering1, type = "l", xlab = "",
     ylab = "Energy Submetering")
## Add submetering 2 & 3 
lines(datetime, submetering2, type = "l", col = "red")
lines(datetime, submetering3, type = "l", col = "blue")

## Add the legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, lwd = 2.5, col = c("black", "red", "blue"))

dev.copy(png, "plot3.png", width = 480, height = 480)
dev.off()
