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


hist(mpg)
