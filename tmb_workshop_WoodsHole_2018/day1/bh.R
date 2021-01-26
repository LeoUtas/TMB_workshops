dat <- read.table("bh.dat", header = TRUE)

library(TMB)
compile("bh.cpp")
dyn.load(dynlib("bh"))

data <- list(SSB = dat$SSB, logR = dat$logR)
parameters <- list(
    logA = 0,
    logB = 0,
    logSigma = 0
)

obj <- MakeADFun(data, parameters, DLL = "bh")
obj$fn()
obj$gr()
system.time(opt <- nlminb(obj$par, obj$fn, obj$gr))
rep <- sdreport(obj)

plot(dat$SSB, dat$logR)

lines(dat$SSB, rep$value, lwd = 3)
lines(dat$SSB, rep$value + 2 * rep$sd, lty = "dotted")
lines(dat$SSB, rep$value - 2 * rep$sd, lty = "dotted")
