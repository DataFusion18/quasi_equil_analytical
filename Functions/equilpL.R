# Find long term equilibrated pf based on equilibrated NPP calculated from equilnf profile
equilpL <- function(equildf, Pin = 0.04, leachp = 0.05, Cpass=CpassVLong,
                    nwvar=TRUE,pwvar = TRUE, pwood = 0.0003, prho = 0.7, 
                    pretrans = 0.6, pcp = 0.005, Tsoil = 15,
                    Texture = 0.5, ligfl = 0.2, ligrl = 0.16,
                    k1 = 0.01, k2 = 0.01, k3 = 0.05) {
    # prepare allocation partitioning
    ar <- 0.2
    af <- 0.2
    aw <- 1 - ar - af
    
    df <- equildf[1,1]
    equilNPP <- equildf[1,2]
    
    # passive pool burial 
    pass <- passive(df, allocn(df,nwvar=nwvar), Tsoil, Texture, ligfl, ligrl)
    omegap <- allocn(df, nwvar=nwvar)$af*pass$omegaf + allocn(df)$ar*pass$omegar 
    
    # prepare very long term nitrogen fluxes
    U0 = Pin + (1-pass$qq) * pass$decomp * Cpass * pcp
    pleach <- leachp/(1-leachp-k1) 
    pburial <- omegap*pcp
    pocc <- (k3/(k2+k3))*(k1/(1-k1-leachp))
    
    # Convert NPP unit
    NPP_PC <- equilNPP*10^3     # convert to g C m-2 yr-1
    
    # Calculate equilnf, based on equilNPP_P
    Y1 <- U0/NPP_PC - pburial
    
    if(pwvar == FALSE) {
        pf <- (((Y1 - pwood * aw) / (pleach+pocc)) - pwood * aw) / ((1.0-pretrans)*af + prho * ar)
    } else {
        pf <- Y1 / (pwood * aw + (pleach+pocc) * ((1.0-pretrans)*af + prho * ar + pwood * aw))
    }
    
    # obtain equilnf  
    return(pf)
}