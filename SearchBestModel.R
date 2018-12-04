inputData <- read.csv("http://rstatistics.net/wp-content/uploads/2015/09/ozone2.csv", stringsAsFactors=F)
response_df <- inputData['ozone_reading']  # Y variable
predictors_df <- inputData[, !names(inputData) %in% "ozone_reading" ]  # X variables
head(inputData)
#plot best regression model with adj r2
library(leaps)
regsubsetsObj <- regsubsets(x=predictors_df ,y=response_df, nbest = 2, really.big = T)
plot(regsubsetsObj, scale = "adjr2")  # regsubsets plot based on R-sq
#Best regression model with lm with adj r2
library(FactoMineR)
regMod <- RegBest(y=inputData$ozone_reading, x = predictors_df)
regMod$all  # summary of best model of all sizes based on Adj A-sq
regMod$best  # best model
