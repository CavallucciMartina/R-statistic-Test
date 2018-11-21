#Import dataset on R
SpeseManutenzioneTotalePerAuto2018 <- read.delim2("C:/Users/utente/Desktop/.../PulituraDati/SpeseManutenzioneTotalePerAuto2018.txt")
# View and attach dataframe
View(SpeseManutenzioneTotalePerAuto2018)
attach(SpeseManutenzioneTotalePerAuto2018)
# Show the first plot
plot(Km,Spese)
# Load outliers package
library(outliers)
# Search outliers in dataframe 
outlier(Km,opposite=FALSE, logical=FALSE)
outlier(Spese,opposite=FALSE, logical=FALSE)
# Delete discovered outliers and replace with median
KmNoOut<-rm.outlier(Km,fill=TRUE, median=FALSE,opposite = FALSE)
SpeseNoOut<-rm.outlier(Spese,fill=TRUE, median=FALSE,opposite = FALSE)
# Show new plot
plot(KmNoOut,SpeseNoOut)
# Create the new dataframe with the cleanest coloums
SpeseManutPerAuto2018Clean<-cbind(KmNoOut,SpeseNoOut)
SpeseManutPerAuto2018Clean<-as.data.frame(SpeseManutPerAuto2018Clean)
# Load vegan package
library(vegan)
# Data standardization between 0 and 1
SpeseManutPerAuto2018CleanSt<-decostand(SpeseManutPerAuto2018Clean,"max", MARGIN = 2)
# Show new dataframe with standardization value
View(SpeseManutPerAuto2018CleanSt)