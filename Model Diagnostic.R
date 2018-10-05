library(ISLR)
#Import the Cars Data Frame
data(Auto)

#Instruct R to look up data in the Auto file with the attach () function
attach(Auto)

reg<- lm(horsepower ~ mpg )
plot(horsepower,mpg)

#Show the confidence interval of the linear regression
IntConf <- predict(reg, interval="confidence")
#In the resulting matrix, columns 2 and 3 find the
#lower and upper values ??respectively of the
#prediction confidence interval. The two lines of the
#confidence interval should be centered on the x axis
#(where the mpg is).

plot(horsepower ~ mpg)
abline(reg)
lines(mpg, IntConf[,2], lty=3, col="blue")
lines(mpg, IntConf[,3], lty=3, col="blue")
par(mfcol = c (2,2))
plot(reg)