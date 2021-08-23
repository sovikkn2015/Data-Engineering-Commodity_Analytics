
period_len <- 5 #--- Mention how many years the future curve is required
n <- 23 # Last file name


slopedf <- data.frame()


### Read Futures Data

for (i in 1:n){
  
  inputfile <- paste(".../Commodity_Analytics/Futures Data/futures_curves_modified_data/",i,".csv", sep="")

  Futures_Data <- read.csv(inputfile, header=TRUE)
  Futures_Data <- Futures_Data[,-1]
  Futures_Data[is.na(Futures_Data)] <- 0
  
  ### Creating empty data
  
  for (i in 1:8){
    assign(paste("DF",i,sep="_"),data.frame(factor(period_len*12), factor(period_len*12), numeric(period_len*12))) 
  }
  
  ### Assigning data
  
  for (i in 1:8){
    temp1 <- assign(paste("DF",i,sep="_"),data.frame(factor(period_len*12), factor(period_len*12), numeric(period_len*12))) 
    row_num <- min(which(Futures_Data[,i*3] > 0))
    temp1[,1] <- Futures_Data[row_num:(row_num+(period_len*12-1)),(i*3-2)]
    temp1[,2] <- Futures_Data[row_num:(row_num+(period_len*12-1)),(i*3-1)]
    temp1[,3] <- Futures_Data[row_num:(row_num+(period_len*12-1)),i*3]
    colnames(temp1) <- c("Ticker", "Period", "Last_Price")
    #print(temp1)
    assign(paste("DF",i,sep="_"), temp1)
    #print(row_num)
  }
  
  ### Calculating slope
  
  slope2 <- data.frame(numeric(8))
  
  for (i in 1:8) {
    temp2 <- get(paste("DF",i,sep="_"))
    row_len <- nrow(temp2)
    slope2[i,] <- round((temp2[row_len,3]-temp2[1,3])/(12*period_len), digits=2)
  }
  
  slopedf <- rbind(slopedf, slope2) 

}


### Writing CSV File

outputfile <- paste(".../Commodity_Analytics/Futures Data/futures_curves_modified_data/slope_",period_len,".csv", sep="")


write.table(slopedf, file = outputfile, row.names=FALSE, col.names=FALSE)

