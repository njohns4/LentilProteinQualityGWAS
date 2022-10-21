library(lme4)
library(rstan)
library(rstanarm)
library(bayesplot)
library(shinystan)
library(ggplot2)

# Bayesian BLUPs for AAs

options(mc.cores = parallel::detectCores())
setwd("/scratch1/njohns9/AA_GAPIT3")
df <- read.csv("LentilAA.csv")
df[,c(1,3:6)] <- lapply(df[,c(1,3:6)], function(x) as.factor(x))
df[,c(2,7:41)] <- lapply(df[,c(2,7:41)], function(x) as.numeric(x))

bayesian_blups <- unique(df[,c(6),drop=F])
trait <- colnames(df)[7:41]


for (i in 1:length(trait)){
  AA_stan_model <- stan_lmer(paste0(trait[i], " ~ (1|ILL_No) + (1|Batch)"),
                          data=df, adapt_delta = 0.99, seed=324)
  random_effects <- ranef(AA_stan_model)$ILL_No
  random_effects$ILL_No <- rownames(random_effects)
  colnames(random_effects) <- c(trait[i], "ILL_No")
  bayesian_blups <- merge(bayesian_blups, random_effects)
}


head(bayesian_blups)
write.csv(bayesian_blups, file="Lentil.AA.bayesian.blups.csv", row.names = F, quote = F)

# Bayesian BLUPs for Dig

options(mc.cores = parallel::detectCores())
setwd("/scratch1/njohns9/AA_GAPIT3")
df <- read.csv("LentilDig.csv")
df[,c(1:6)] <- lapply(df[,c(1:6)], function(x) as.factor(x))
df[,c(7)] <- lapply(df[,c(7)], function(x) as.numeric(x))

bayesian_blups <- unique(df[,c(3),drop=F])
trait <- colnames(df)[7]


for (i in 1:length(trait)){
  AA_stan_model <- stan_lmer(paste0(trait[i], " ~ (1|ILL_No) + (1|Batch)"),
                             data=df, adapt_delta = 0.99, seed=324)
  random_effects <- ranef(AA_stan_model)$ILL_No
  random_effects$ILL_No <- rownames(random_effects)
  colnames(random_effects) <- c(trait[i], "ILL_No")
  bayesian_blups <- merge(bayesian_blups, random_effects)
}


head(bayesian_blups)
write.csv(bayesian_blups, file="Lentil.Dig.bayesian.blups.csv", row.names = F, quote = F)


# Using lme4 package (lmer), regular stats was tried (below). 
# One trait gave "is singular" error, so Bayesian stats was used in rstanarm (stan_lmer).

# setwd("/scratch1/njohns9/AA_GAPIT3/")
# list.files()
# 
# df <- read.csv("LentilAA.csv")
# head(df)
# 
# df[,c(1,3:6)] <- lapply(df[,c(1,3:6)], function(x) as.factor(x))
# df[,c(2,7:41)] <- lapply(df[,c(2,7:41)], function(x) as.numeric(x))
# str(df)
# blups <- unique(df[,c(6),drop=F])
# AAmeans <- data.frame(matrix(ncol = 35, nrow = 1))
# colnames(AAmeans) <- (colnames(df)[7:41])
# trait <- colnames(df)[7:41]
# lmer_list <- list()
# 
# for (i in 1:length(trait)){
#   model <- lmer(paste0(trait[i], " ~ (1|ILL_No) + (1|Batch)"), data=df)
#   random_effects <- ranef(model)$ILL_No
#   random_effects$ILL_No <- rownames(random_effects)
#   colnames(random_effects) <- c(trait[i], "ILL_No")
#   blups <- merge(blups, random_effects)
#   AAmeans[trait[i]] <- fixef(model)
#   lmer_list[i] <- model
#   names(lmer_list)[i] <- trait[i]
# }
# 
# write.csv(blups, file="Lentil.AA.blups.simp.csv", row.names = F, quote = F)
