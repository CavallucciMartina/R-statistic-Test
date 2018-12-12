library(Boruta)
attach(TableReportSpese2016)
# Decide if a variable is important or not using Boruta
boruta_output <- Boruta(Spese ~ ., data=TableReportSpese2016, doTrace=2)
boruta_output
#Boruta performed 99 iterations in 3.363756 secs.
#No attributes deemed important.
#4 attributes confirmed unimportant: Km, Km16, Ore16, OreT;

# collect Confirmed and Tentative variables
boruta_signif <- names(boruta_output$finalDecision[boruta_output$finalDecision %in% c("Confirmed", "Tentative")])
print(boruta_signif)# significant variables
#[1]Anni
# plot variable importance
plot(boruta_output, cex.axis=.7, las=2, xlab="", main="Variable Importance")