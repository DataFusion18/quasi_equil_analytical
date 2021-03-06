#### setting CO2 concentrations
CO2_1 <- 350.0
CO2_2 <- 700.0

#### define parameters
nwood = 0.0005      # if nwvar = false, 0.0005, if = true, 0.005
pwood = 0.000003    # if nwvar = false, 0.000003, if = true, 0.00003
nrho = 0.7
prho = 0.7
nretrans = 0.5
pretrans = 0.6
nwvar = FALSE
pwvar = FALSE
LUE0=1.4
I0=3
Nref=0.04
kext=0.5
SLA=5
sf=0.5
sr = 1.5
cfrac = 0.45
cue = 0.5
leachn = 0.05
leachp = 0.05
Nin = 0.4
Pin = 0.015
k1=0.01
k2=0.01
k3=0.05
Tsoil = 15
Texture = 0.5
ligfl = 0.2
ligrl = 0.16
pcp = 0.005
ncp = 0.1
PAR_MJ <- 4.0
J_2_UMOL <- 4.57
MJ_TO_J <- 1000000.0
par <- MJ_TO_J * J_2_UMOL * PAR_MJ
UMOL_TO_MOL <- 0.000001
MOL_C_TO_GRAMS_C <- 12.0
conv <- UMOL_TO_MOL * MOL_C_TO_GRAMS_C
mt <- 25.0 + 273.5  # degree to kelvin
tk <- 20.0 + 273.5  # air temperature
gamstar25 <- 42.75
eag <- 37830.0
eac <- 79430.0
eao <- 36380.0
kc25 <- 404.9
ko25 <- 278400.0
oi <- 210000.0
vpd <- 2.4
PA_2_KPA <- 0.001
wtfac_root <- 1.0
g1 <- 3.8667
alpha_j <- 0.308
daylen <- 8.0
kn <- 0.3
aroot <- 0.2
aleaf <- 0.2
nuptakerate <- 1.0  # 0.96884
puptakerate <- 1.0  # 0.82395
ariz1 <- 0.2        # range: 0.2 - 1
ariz0 <- 0.05       # range: 0.0 - 0.1
cnref <- 25
cpref <- 500
cue_mic <- 0.3      # range: 0.3 - 0.7
km <- 2             # scaling factor for SOM response; range: 1- 5
prime_y <- 1.0      # 0.05
prime_z <- 2
prime_y_slow <- 1.0
prime_z_slow <- 2