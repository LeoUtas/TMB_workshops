library(TMB)
compile("turbotpois.cpp")
dyn.load(dynlib("turbotpois"))

dat <- read.table("turbotpois.dat", head = TRUE)
data <- list()
data$cat <- dat$cat
data$pos <- dat$pos
data$day <- dat$day
data$N00 <- 3529
data$W <- 4.5

param <- list()
param$alpha <- 0
param$logsigma <- log(1000)
param$q <- 0.5

obj <- MakeADFun(data, param, DLL = "turbotpois", silent = TRUE)
opt <- nlminb(obj$par, obj$fn, obj$gr, lower = c(-Inf, -Inf, 0), upper = c(Inf, Inf, 1))
summary(sdreport(obj))
opt$objective
