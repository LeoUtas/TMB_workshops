setwd("D:/OneDrive - University of Tasmania/HOANG.Ng84/Education/Hoang.MUN20/Projects/TMB_workshops/tmb_Andre_E_Punt/Day 1")

set.seed(1234)
beta0 <- 2
beta1 <- 6
beta2 <- 8
beta3 <- 10
sd_err <- 2
n <- 50000

x_obs <- sort(rlnorm(n, 0, .5))
y_obs <- beta0 * x_obs +
  beta1 * x_obs * x_obs -
  beta2 * x_obs * x_obs * x_obs +
  beta3 + sd_err * rnorm(n, 0, 10)
plot(x_obs, y_obs)

data <- list(x_obs = x_obs, y_obs = y_obs)
parameters <- list(beta0 = 1, beta1 = 1, beta2 = 1, beta3 = 1, logSigma = 0)

require(TMB)
compile("LectB2_mess2.cpp")
dyn.load(dynlib("LectB2_mess2"))
# dyn.unload(dynlib("LectB2"))

################################################################################
model <- MakeADFun(data, parameters, DLL = "LectB2_mess2", silent = FALSE)
fit <- nlminb(model$par, model$fn, model$gr, trace = TRUE)

best_tmb <- model$env$last.par.best
report <- sdreport(model)

best_nls <- nls(y_obs ~ beta0 * x_obs +
  beta1 * x_obs^2 -
  beta2 * x_obs^3 +
  beta3,
data = data,
start = list(beta0 = 1, beta1 = 1, beta2 = 1, beta3 = 1),
algorithm = c("port")
)

best_tmb
coef(best_nls)
model$report()
report
