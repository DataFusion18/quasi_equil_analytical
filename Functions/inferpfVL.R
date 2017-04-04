### Make inference of pf based on nf
inferpfVL <- function(nf, a, Pin=0.04, Nin=1.0,
                      leachn=0.05, leachp=0.05,
                      k1=0.01, k2=0.01, k3=0.05,
                      nwood=0.005, pwood=0.0003, 
                      pwvar = TRUE, nrho = 0.7, prho = 0.7,
                      nretrans = 0.5, pretrans = 0.6) {
    # allocation parameters
    ar <- 0.2
    af <- 0.2
    aw <- 1 - ar - af
    
    # output nf, based on F(nf) = F(pf)
    pf <- c()
    
    Nleach <- (leachn/(1-leachn)) * (a$nfl * a$af + a$nr * a$ar +
                                         a$nw *a$aw)
    
    Pleach <- (leachp/(1-leachp-k1)) 
    Pocc <- (k3/(k2+k3))*(k1/(1-k1-leachp)) 
    
    Pg <- ((Pin * Nleach)/Nin) / (Pocc + Pleach)
    
    if(pwvar == FALSE) {
        pf <- (Pg - pwood * aw) / ((1.0 - pretrans) * af + prho * ar)
    } else {
        pf <- Pg / ((1.0 - pretrans) * af + prho * ar + aw * pwood)
    }
    return(round(pf,8))
}