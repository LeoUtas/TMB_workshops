setwd("D:/OneDrive - University of Tasmania/HOANG.Ng84/Education/Hoang.MUN20/Projects/TMB_workshops/tmb_Andre_E_Punt/Day 1")

data <- list(x = rivers)
parameters <- list(mu = 0, logSigma = 0)

require(TMB)
compile("LectB1.cpp", flags = "-Wno-ignored-attributes")
dyn.load(dynlib("LectB1"))

##################
model <- MakeADFun(data, parameters, silent = TRUE)
fit <- nlminb(model$par, model$fn, model$gr, trace = TRUE)
rep <- sdreport(model)
print(summary(rep))