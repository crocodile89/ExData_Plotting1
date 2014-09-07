
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

#create the first plot, a histogram, based on the assignment
hist(data_subset$Global_active_power, col = "red", main = "Global Active Power",
     xlab="Global Active Power (kilowatts)")

#save histogram as png file with appropriate dimensions
png(filename = "plot1.png",
    width = 480, height = 480, units = "px",)

