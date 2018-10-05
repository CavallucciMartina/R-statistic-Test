library(ISLR)
#Import the Cars Data Frame
data(Auto)

#Instruct R to look up data in the Auto file with the attach () function
attach(Auto)


reg<- lm(mpg~horsepower)
plot(horsepower,mpg)
abline(reg)