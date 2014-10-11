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

# plot the day of the week versus Global Active Power
plot(data_subset2$Date_Time, data_subset2$Global_active_power, type = "l", main = " ", xlab = NA,
     ylab="Global Active Power (kilowatts)")

#save plot as png file with appropriate dimensions
dev.copy(png, file = "plot2.png")
dev.off()
