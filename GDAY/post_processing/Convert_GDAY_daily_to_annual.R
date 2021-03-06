
#### Convert GDAY raw output data from daily to annual timestep
####
#### 
################################################################################

######################## Functions ###################################

#### Aggregate daily data to annual dataframe
d_to_a <- function(inDF) {
    
    ## update inDF structure
    inDF <- as.data.frame(inDF)
    
    #### Checking data structure
    dimension <- dim(inDF)
    n <- names(inDF)
    yvars <- n[-c(1:2)]
    e <- ncol(inDF)
    
    #### Identify fluxes and stocks: 0 is other, 1 is flux, 2 is stock
    fop1<-c(rep(0,2),    # 1 - 2
            rep(2,35),   # 3 - 37
            rep(1,18),   # 38 - 73
            #rep(0,1),    # 74
            rep(1,2))   # 75 - 97
    match <- data.frame(fop1,n)
    #print(match)
    
    ## extract stock df and flux df
    fDF <- cbind(inDF[1:2], inDF[,38:e])
    sDF <- cbind(inDF[,1:37])
    
    ## update year list for calculation of delta
    yrange <- as.list(unique(inDF[, "year"]))
    
    #create empty annual data frame, take out DoY and adjust fop vector
    ann<-inDF[1:length(yrange),]
    ann[,]<-NA
    ann$year <- yrange
    
    ## assign daily data onto annual frame: stocks
    saDF <- subset(sDF, doy == 1)
    ann[,3:37] <- saDF[,3:37]
    
    ## assign daily data onto annual frame: fluxes
    faDF <- aggregate(. ~ year, data = fDF, FUN = "sum")
    faDF$year <- NULL
    faDF$doy <- NULL
    ann[,38:e] <- faDF
    
    ## Finishing touch
    ann$year<-as.numeric(ann$year)
    ann$doy <- NULL
    #ann$tfac_soil_decomp <- ann$tfac_soil_decomp/365.0
    
    return(ann)
    
}

#### Save annual data to a csv file
save_daily_to_annual_csv <- function(spin_file_in, amb_file_in, ele_file_in,
                                     spin_file_out, amb_file_out, ele_file_out) {
    
    #### give file names
    spin_file_in <- "Quasi_equil_model_spinup_equilib.csv"
    amb_file_in <- "Quasi_equil_transient_CO2_AMB.csv"
    ele_file_in <-  "Quasi_equil_transient_CO2_ELE.csv"
    spin_file_out <- "annual_gday_result_spinup.csv"
    amb_file_out <- "annual_gday_result_transient_CO2_AMB.csv"
    ele_file_out <- "annual_gday_result_transient_CO2_ELE.csv"
    
    #### obtain the original working directory
    cwd <- getwd()
    
    #### Setting working directory
    setwd("GDAY/outputs")
    
    #### Count number of simulations runs by counting the # folders
    dirFile <- list.dirs(path=".", full.names = F, recursive = F)
    
    #### Set back to the original working directory
    setwd(cwd)
    
    #### Convert the spin up files
    for (i in 1:length(dirFile)) {
        inF <- paste(getwd(), "/GDAY/outputs/", dirFile[i], "/", spin_file_in, sep="")
        myDF <- fread(inF, sep=",", skip = 1, header=T)
        
        #### Transforming from daily to annual and write output
        annDF <- d_to_a(myDF)
        write.table(annDF, paste(getwd(), "/GDAY/analyses/", dirFile[i], "/", spin_file_out, sep=""),
                    row.names=F,col.names=T,sep=",")
    }
    
    #### Convert the aCO2 files
    for (i in 1:length(dirFile)) {
        inF <- paste(getwd(), "/GDAY/outputs/", dirFile[i], "/", amb_file_in, sep="")
        myDF <- fread(inF, sep=",", skip = 1, header=T)
        
        #### Transforming from daily to annual and write output
        annDF <- d_to_a(myDF)
        write.table(annDF, paste(getwd(), "/GDAY/analyses/", dirFile[i], "/", amb_file_out, sep=""),
                    row.names=F,col.names=T,sep=",")
    }
    
    #### Convert the eCO2 files
    for (i in 1:length(dirFile)) {
        inF <- paste(getwd(), "/GDAY/outputs/", dirFile[i], "/", ele_file_in, sep="")
        myDF <- fread(inF, sep=",", skip = 1, header=T)
        
        #### Transforming from daily to annual and write output
        annDF <- d_to_a(myDF)
        write.table(annDF, paste(getwd(), "/GDAY/analyses/", dirFile[i], "/", ele_file_out, sep=""),
                    row.names=F,col.names=T,sep=",")
    }
    
    
}

######################## Programs ###################################
save_daily_to_annual_csv()

