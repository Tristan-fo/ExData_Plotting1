path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, file.path(path, "data.zip"))

unzip("data.zip")

data <- read.table("household_power_consumption.txt", header = TRUE,
                   sep = ";", stringsAsFactors = FALSE, 
                   dec = ".")
head(data)

data_subset <- subset(data, data$Date %in% c("1/2/2007", "2/2/2007"))

GlobalActivePower <- as.numeric(data_subset$Global_active_power)

datetime <- strptime(paste(data_subset$Date, data_subset$Time, sep = " "),
                     "%d/%m/%Y %H:%M:%S")

plot(datetime, GlobalActivePower, type = "l", xlab = "",
     ylab ="Global Active Power (kilowatts)") 

dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()
