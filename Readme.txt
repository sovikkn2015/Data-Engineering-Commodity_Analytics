
How to use the R codes ?

I. Extracting Futures Data.R
	Reading Raw Bloomberg csv File of NYMEX WTI Crude Oil Futuredata and creating required formatted files
	
	Parameters::
	period_len <- 5 #--- Mention how many years the future curve is required
	n <- 23 # Last file name
	

II. Calculating Slope.R
	Calculating slope of from each futures file for the required time period
	
	Parameters::
	period_len <- 5 #--- Mention how many years the future curve is required
	n <- 23 # Last file name


III. Ploting Futures Data.R
	Plotting Slopes of NYMEX WTI Crude Oil Future Curves

	Parameters::
	period_len <- 5 #--- Mention how many years the future curve is required
