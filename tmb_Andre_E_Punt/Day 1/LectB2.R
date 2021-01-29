setwd("D:/OneDrive - University of Tasmania/HOANG.Ng84/Education/Hoang.MUN20/Projects/TMB_workshops/tmb_Andre_E_Punt/Day 1")

data <- read.table("LectB2.dat", header = TRUE)
colnames(data) = c("x_obs","y_obs")
parameters <- list(b0 = 0, b1 = 0, logSigma = 0)

require(TMB)
compile("LectB2.cpp", flags = "-Wno-ignored-attributes")
dyn.load(dynlib("LectB2"))

################################################################################
model <- MakeADFun(data, parameters, DLL = "LectB2", silent = TRUE)
fit <- nlminb(model$par, model$fn, model$gr, trace = TRUE)

best <- model$env$last.par.best
rep <- sdreport(model)

print(best)
print(rep)