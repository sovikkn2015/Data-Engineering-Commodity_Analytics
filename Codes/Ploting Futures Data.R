

period_len <- 5 #--- Mention how many years the future curve is required


###---------- Enter start and end period for data ----------
start_period <- "2006-6-1"
end_period <- "2015-6-1"

start_period <- as.Date(start_period, format="%Y-%m-%d")
end_period <- as.Date(end_period, format="%Y-%m-%d")

### Read Futures Data

inputfile <- paste(".../Commodity_Analytics/Futures Data/futures_curves_modified_data/slope_",period_len,".csv", sep="")

slope_Data <- read.csv(inputfile, header=FALSE)
#Futures_Data <- Futures_Data[,-1]
#Futures_Data[is.na(Futures_Data)] <- 0

### Genearting dates

dates <- seq(as.Date("2000/3/1"), as.Date("2015/6/1"),by = "month")
dates <- data.frame(dates)

### Inverting data

row_len <- nrow(slope_Data)
rev_slope_Data <- data.frame(slope_Data[row_len:1,])

### Forming data frame

DF_Date_slope <- cbind(dates, rev_slope_Data)
colnames(DF_Date_slope) <- c("Date", "Slope")

### Subseeting data frame

Slope_SP <- which(DF_Date_slope$Date == start_period)
Slope_EP <- which(DF_Date_slope$Date == end_period)

DF_Date_slope_Sub <- DF_Date_slope[Slope_SP:Slope_EP,]

### Plotting the data

cols <- c("red", "green")[(DF_Date_slope_Sub$Slope > 0) + 1] 

plot(DF_Date_slope_Sub$Date, DF_Date_slope_Sub$Slope,
     xlab= "", ylab= "",type='h',col=cols,lwd=3)

legend(x=min(par("usr")[1:2]), y=-.3,
       xpd=TRUE,
       legend=c("Negative Slope - Backwardation", "Positive Slope - Contango") , 
       lty=1, lwd=3, col=c('red','green'), bty='n', cex=.75)
title(main="Slopes of NYMEX WTI Crude Oil Future Curves 2006-2015")

