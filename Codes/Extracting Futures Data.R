
period_len <- 5 #--- Mention how many years the future curve is required
n <- 23 # Last file name

### Read Futures Data

for (i in 1:n){
  
  inputfile <- paste(".../Commodity_Analytics/Futures Data/futures_curves_raw_data/",i,".csv", sep="")
  outputfile <- paste(".../Commodity_Analytics/Futures Data/futures_curves_modified_data/",i,".csv", sep="")
  
  
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
    temp1[,1] <- Futures_Data[row_num:(row_num+59),(i*3-2)]
    temp1[,2] <- Futures_Data[row_num:(row_num+59),(i*3-1)]
    temp1[,3] <- Futures_Data[row_num:(row_num+59),i*3]
    colnames(temp1) <- c("Ticker", "Period", "Last_Price")
    #print(temp1)
    assign(paste("DF",i,sep="_"), temp1)
    #print(row_num)
  }
  
  ### Creating a modified Data Frame
  
  DF_Modified <- data.frame(DF_1, DF_2, DF_3, DF_4, DF_5, DF_6, DF_7, DF_8)
  
  ### Writing CSV File
  
  write.csv(DF_Modified, file = outputfile)
  
}