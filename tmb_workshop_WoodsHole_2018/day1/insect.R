library(TMB)
compile("insect.cpp")
dyn.load(dynlib("insect"))

# for data we use the built-in InsectSprays
param <- list(
    logAlpha = rep(0, nlevels(InsectSprays$spray))
)
obj <- MakeADFun(InsectSprays, param, DLL = "insect")
opt <- nlminb(obj$par, obj$fn, obj$gr)
