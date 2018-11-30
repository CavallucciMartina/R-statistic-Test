## Multiple regression with backward method
TableTot <- read.delim("C:/Users/../TableTot.txt")
attach(TableTot)
fm<-lm(Spese~ Ore + Anni + Km)
summary(fm)
coef(fm)
plot(fm)
summary(fm, correlation=T)$correlation ## correlazioni tra i coefficienti
confint(fm) ## intervalli di confidenza al 95%
## Remove "Ore" because its p-value > 0.05 ( fixed threshold)
fm1<-update(fm, . ~ .-Ore)
summary(fm1)
anova(fm,fm1)
coef(fm1)