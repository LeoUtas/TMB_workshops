setwd("D:/OneDrive - University of Tasmania/HOANG.Ng84/Education/Hoang.MUN20/Projects/TMB_workshops/tmb_Andre_E_Punt/Day 2")

require(TMB)
compile("Ex2.cpp", flags = "-Wno-ignored-attributes")
dyn.load(dynlib("Ex2"))

################################################################################

Nprey <- scan("ex2.dat", skip = 1, n = 1, quiet = TRUE)
Ndata <- scan("ex2.dat", skip = 3, n = 1, quiet = TRUE)
dataD <- matrix(scan("ex2.dat", skip = 5, n = 7 * Ndata, quiet = TRUE), ncol = 7, byrow = TRUE)
Nprey <- scan("ex2.dat", skip = 1, n = 1, quiet = TRUE)

Model_Num <- 4
data <- list(Nprey = Nprey, NData = Ndata, N = dataD, Model_Num = Model_Num)
parameters <- list(alpha = rep(0.1, 3), beta = rep(0, 3), gamma = rep(0, 3))

# map to help decide which parameters to estimates
if (Model_Num == 1) map <- list(beta = factor(rep(NA, Nprey)), gamma = factor(rep(NA, Nprey)))
if (Model_Num == 2) map <- list(gamma = factor(rep(NA, Nprey)))
if (Model_Num == 3) map <- NULL
if (Model_Num == 4) map <- NULL

# print(data)
# print(parameters)
# AAA

################################################################################

model <- MakeADFun(data, parameters, DLL = "Ex2", silent = TRUE, map = map)
fit <- nlminb(model$par, model$fn, model$gr)
best <- model$env$last.par.best
rep <- sdreport(model)
print(best)
print(rep)