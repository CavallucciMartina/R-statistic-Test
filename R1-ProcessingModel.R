library(ISLR)
library(MASS)
library(corrplot) # We'll use corrplot later on in this example too.
library(dplyr)
library(ggplot2)
library(visreg) # This library will allow us to show multivariate graphs.
library(rgl)
library(knitr)
library(scatterplot3d)

df <- read_excel("C:/Users/utente/Desktop/Rimini/REPORT1-SPESE/DB-pulito.xlsx")
View(df)
attach(df)
str(df)
df$Carb<-as.factor(df$Carb)
df$Carb<-as.numeric(df$Carb)
str(df)
summary(df) # statistic index of all variables
##############
#Per ogni campo del df 
hist(anni) #per comprendere visivamente la frequenza
boxplot(anni) # per visualizzare media,quantili,min e max
summary(anni) # fornisce i dati sopra precisi e scritti.
plot(anni) # usefull?
#############
# Plot matrix of all variables.
plot(df, col="navy", main="Matrix Scatterplot")
#Before fitting the data to a model lets create a test and train set of the Data. 
#Train set will be used to train or fit the model and test set will be used to check
#the performance of the model. We will split the data to train, test set using 
#an 80:20 ratio.
require(caTools)
sample = sample.split(df,SplitRatio = 0.80) # splits the data in the ratio mentioned 
#in SplitRatio. After splitting marks these rows as logical TRUE and the the remaining
#are marked as logical FALSE
train1 =subset(df,sample ==TRUE) # creates a training dataset named 
#train1 with rows which are marked as TRUE
test1=subset(df, sample==FALSE)
summary(train1)
#We will use Least Square method to fit our regression model.
fit1<- lm(Spese16~., data = train1)
summary(fit1)
cor = cor(test1[1:7])
corrplot(cor, method = "number")
# The Spese16 is  strongly correlated to anni,and kmTot; but there is a strong relation between
#anni,kmTot, km16,Spese16,oreTot
#This situation is called collinearity.The problem of collinearity in the
#response is that it is difficult to find the individual effect on response. 
#We should drop use only one of the collinear variables.

#As the km16 don't show any significant relation in the first model with Spese16
#we will exclude km16. Out of km16,ore16,oreTot
#the output of the first model shows that anni and kmtot have a highly
#significant relation. 
fit2 <- lm(Spese16~ anni+kmtot+Carb,data = train1)
summary(fit2)
plot(fit2, which =1)
#This plot shows some of the outliers lying far away from the middle of the graph.
#We will try a different type of transformation on both predictors and the response
#value and see how the performance of model changes. In the next model,
#we will use the natural log to the Spese16 using log() and see the change
#in performance of the model.
fit3 <- lm(log(Spese16)~anni+kmTot+Carb,data = train1)
summary(fit3)
#Previous test don't shows significant model regression
#----leaps (regression subset selection) -- Select best model with leaps----
library(leaps)
regsubsets.out <-
  regsubsets(Spese16~.,
             data = df,
             nbest = 1,       # 1 best model for each number of predictors
             nvmax = NULL,    # NULL for no limit on number of variables
             force.in = NULL, force.out = NULL,
             method = "exhaustive")

regsubsets.out
summary.out <- summary(regsubsets.out)
as.data.frame(summary.out$outmat)
plot(regsubsets.out, scale = "adjr2", main = "Adjusted R^2")
layout(matrix(1:2, ncol = 2))
res.legend <-
  subsets(regsubsets.out, statistic="adjr2", legend = FALSE, min.size = 5, main = "Adjusted R^2")

res.legend <-
  subsets(regsubsets.out, statistic="cp", legend = FALSE, min.size = 5, main = "Mallow Cp")
abline(a = 1, b = 1, lty = 2)
res.legend
which.max(summary.out$adjr2)
#[1] 1 
summary.out$which[1,]
best.model<-lm(Spese16~anni, data = df)

##----bestglm (Best subset GLM)----
#... to do with https://rstudio-pubs-static.s3.amazonaws.com/2897_9220b21cfc0c43a396ff9abf122bb351.html

##----Other leaps test----
library(leaps)
leaps<-regsubsets(Spese16~anni+kmTot+km16+ore16+oreTot+Carb,data=df,nbest=10)
plot(leaps, scale="adjr2")
plot(leaps, scale="bic")
null<-lm(Spese16~1,data=df)
full<-lm(Spese16~.,data=df)
#---forward---show the best model, in this case the best is Spese16~anni
step(null, scope=list(lower=null, upper=full), direction="forward")
#---backward elimination ---
step(full, data=df, direction="backward")
#---both direction----
step(null, scope = list(upper=full), data=df, direction="both")
# Both algorithms give rise to results that are equivalent to the forward selection procedure. 