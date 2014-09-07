# Read text file into R, named as data_orig
data_orig <- read.table("household_power_consumption.txt",
                        header = TRUE,
                        sep= ";",
                        na.strings= "?",
                        nrows= 1000000,
                        stringsAsFactors=FALSE,
                        as.is=TRUE
)

# Subset the data based on the given dates in the assignment, new data frame named data_subset
data_subset <- data_orig[min(which(data_orig$Date == "1/2/2007")):max(which(data_orig$Date == "2/2/2007")),]

#check to see that the subset worked
head(data_subset)

# make sure R is reading the dates as actual dates
data_subset$Date <- as.Date(data_subset$Date, format = "%d/%m/%Y")
head(data_subset$Date)

#get the names of each date
#datenames <- weekdays(data_subset$Date)

#create a new column with both date and time
data_subset2 <- within(data_subset, Date_Time <- paste(data_subset$Date, data_subset$Time, sep =' '))

#set Date_Time to make sure read as date and time in R
data_subset2$Date_Time <- as.POSIXct(data_subset2$Date_Time)

#set the overall parameters to fit four graphs in
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))

# plot the day of the week versus Global Active Power
plot(data_subset2$Date_Time, data_subset2$Global_active_power, type = "l", main = " ", xlab = NA,
     ylab="Global Active Power")

#plot the day of the week versus voltage
plot(data_subset2$Date_Time, data_subset2$Voltage, type = "l", main = " ", xlab = "datetime",
     ylab="Voltage")

# plot the day of the week versus sub metering 1
plot(data_subset2$Date_Time, data_subset2$Sub_metering_1, type = "l", main = " ", xlab = "",
     ylab = "Energy sub metering")

#add the next two sub meterings to the plot, identifying the color
lines(data_subset2$Date_Time, data_subset2$Sub_metering_2, type = "l", col = "red")
lines(data_subset2$Date_Time, data_subset2$Sub_metering_3, type = "l", col = "blue")

#add a legend to the sub metering plot
legend(x ="topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n",
       pch = NA, lty = 1, col = c("black", "blue", "red"))

#plot the day of the week versus voltage
plot(data_subset2$Date_Time, data_subset2$Global_reactive_power, type = "l", main = " ", xlab = "datetime",
     ylab="Global_reactive_power")

#save histogram as png file with appropriate dimensions
png(filename = "plot4.png",
    width = 480, height = 480, units = "px",)