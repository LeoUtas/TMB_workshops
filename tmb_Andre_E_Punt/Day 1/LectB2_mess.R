setwd("D:/OneDrive - University of Tasmania/HOANG.Ng84/Education/Hoang.MUN20/Projects/TMB_workshops/tmb_Andre_E_Punt/Day 1")

set.seed(1234)
beta0 = 2
beta1 = 6
sd_err = 1
n = 500

x_obs = sort(rlnorm(n,0,.5))
y_obs = beta0 * x_obs + beta1 + sd_err * rnorm(n,0,.5)
plot(x_obs, y_obs)

data <- list(x_obs = x_obs,y_obs = y_obs)
parameters <- list(beta0 = 1, beta1 = 1, logSigma = 0)

require(TMB)
compile("LectB2_mess.cpp", flags = "-Wno-ignored-attributes")
dyn.load(dynlib("LectB2_mess"))
#dyn.unload(dynlib("LectB2_mess"))

################################################################################
model <- MakeADFun(data, parameters, DLL = "LectB2_mess", silent = TRUE)
fit <- nlminb(model$par, model$fn, model$gr, trace = TRUE)

best <- model$env$last.par.best
rep <- sdreport(model)

print(best)
print(rep)


lm(y_obs~x_obs, data)
