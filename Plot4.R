##download file
if(!file.exists('source data')){dir.create('source data')}
file.url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(file.url,destfile = "source data/power_consumption.zip")
unzip('source data/power_consumption.zip',exdir='source data',overwrite=TRUE)
variable.class = c(rep('character',2),rep('numeric',7))

##read & convert file
power.consumption = read.table('source data/household_power_consumption.txt',header=TRUE, 
                               sep=';',na.strings='?',colClasses=variable.class)
power.consumption$Date= as.Date(power.consumption$Date, format="%d/%m/%Y")
power.consumption = subset(power.consumption,subset=(Date>="2007-02-01"& Date<="2007-02-02"))

datetime <- paste(as.Date(power.consumption$Date), power.consumption$Time)
power.consumption$Datetime <- as.POSIXct(datetime)


## Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(power.consumption, {
  
  plot(Global_active_power~Datetime, type="l", 
       
       ylab="Global Active Power (kilowatts)", xlab="")
  
  plot(Voltage~Datetime, type="l", 
       
       ylab="Voltage (volt)", xlab="")
  
  plot(Sub_metering_1~Datetime, type="l", 
       
       ylab="Global Active Power (kilowatts)", xlab="")
  
  lines(Sub_metering_2~Datetime,col='Red')
  
  lines(Sub_metering_3~Datetime,col='Blue')
  
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(Global_reactive_power~Datetime, type="l", 
       
       ylab="Global Rective Power (kilowatts)",xlab="")
  
})



## Saving to file

dev.copy(png, file="plot4.png", height=480, width=480)

dev.off()
