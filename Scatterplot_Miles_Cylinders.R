#Install ISLR package and use it
library(ISLR)
#Import the Cars Data Frame
data(Auto)
#Show the Data Frame
head(Auto)
#Show all the headers of the Data Frame

#Show info about Data Frame
str(Auto)

#Instruct R to look up data in the Auto file with the attach () function
attach(Auto)

#plot() produce a scatterplot of quantitative variables
#mpg = miles per gallon
#cylinders = Number of cylinders between 4 and 8
plot(cylinders,mpg)



