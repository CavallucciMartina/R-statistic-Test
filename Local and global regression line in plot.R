library(ISLR)
#Import the Cars Data Frame
data(Auto)

#Instruct R to look up data in the Auto file with the attach () function
attach(Auto)

#Linear regression 
reg<- lm(mpg~horsepower)
plot(horsepower,mpg)
abline(reg)

#Local regression curve
lowreg <- lowess(mpg~horsepower)
lines(lowreg, col = "red")