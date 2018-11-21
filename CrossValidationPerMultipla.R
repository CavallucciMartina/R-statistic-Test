DataFrame<-iris
View(DataFrame)
library(MASS, quietly = TRUE)
library(caret)
str(DataFrame)
library(caTools)
attach(DataFrame)
ind = createDataPartition(Species, p = 2/3, list = FALSE)
trainDF<-DataFrame[ind,]
testDF<-DataFrame[-ind,]
ControlParameters<-trainControl(method = "cv", number = 5, savePredictions = TRUE, classProbs = TRUE )
parameterGrid<-expand.grid(mtry=c(2,3,4))
modelRandom <- train(Species ~.,
                     data = trainDF, 
                     method ="rf",
                     trControl = ControlParameters,
                     tuneGrid= parameterGrid
)
modelRandom
predictions<-predict(modelRandom,testDF)
t<-table(predictions=predictions, actual = testDF$Species)
t

