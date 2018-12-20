#download file
if(!file.exists('source data')){dir.create('source data')}
download.file(file.url,destfile = "source data/power_consumption.zip")
unzip('source data/power_consumption.zip',exdir='source data',overwrite=TRUE)
variable.class = c(rep('character',2),rep('numeric',7))

#read & convert file
power.consumption = read.table('source data/household_power_consumption.txt',header=TRUE, 
                              sep=';',na.strings='?',colClasses=variable.class)
power.consumption$Date= as.Date(power.consumption$Date, format="%d/%m/%Y")
power.consumption = subset(power.consumption,subset=(Date>="2007-02-01"& Date<="2007-02-02"))

datetime <- paste(as.Date(power.consumption$Date), power.consumption$Time)
power.consumption$Datetime <- as.POSIXct(datetime)

#Plot and label graph
hist(power.consumption$Global_active_power, main="Global Active Power", 
     
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

#Save as png
dev.copy(png,file="Plot1.png",height=480,width=480)
dev.off()
