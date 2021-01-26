library(TMB)
compile("insect.cpp")
dyn.load(dynlib("insect"))

# for data we use the built-in InsectSprays
param <- list(
    logAlpha = rep(0, nlevels(InsectSprays$spray))
)
obj <- MakeADFun(InsectSprays, param, silent = TRUE)
opt <- nlminb(obj$par, obj$fn, obj$gr)

map1 <- list(logAlpha = factor(c(1, 1, 2, 3, 4, 1)))
obj1 <- MakeADFun(InsectSprays, param, map = map1, silent = TRUE)
opt1 <- nlminb(obj1$par, obj1$fn, obj1$gr)
1 - pchisq(2 * (opt1$obj - opt$obj), 2)
#
#  0.3982677
#
map2 <- list(logAlpha = factor(c(NA, NA, 2, 3, 4, NA)))
param2 <- param
param2$logAlpha[c(1, 2, 6)] <- log(15)
obj2 <- MakeADFun(InsectSprays, param2, map = map2, silent = TRUE)
opt2 <- nlminb(obj2$par, obj2$fn, obj2$gr)
1 - pchisq(2 * (opt2$obj - opt1$obj), 1)
#
# 0.4410911
#
