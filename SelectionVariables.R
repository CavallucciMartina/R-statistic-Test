TableTotPlus <- read.delim("C:/Users/.../TableTotPlus.txt", header=FALSE)
attach(TableReportSpese2016)
library(leaps)
leaps<-regsubsets(Spese~ OreT + Ore16 + Anni + Km + Km16,data=TableReportSpese2016,nbest=10)
# View best regression model according to the adjusted R
plot(leaps, scale="adjr2")
# View best regression model according to the BIC
plot(leaps, scale="bic")
#Start forward selection 
# Starting model
null<-lm(Spese~1,data=TableReportSpese2016)
# Model with all variables
full<-lm(Spese~.,data=TableReportSpese2016)
#Forward selection
step(null, scope=list(lower=null, upper=full), direction="forward")
#Start:  AIC=874.73
#Spese ~ 1

#Df Sum of Sq       RSS    AIC
#+ Anni   1  17679936 181049546 871.32
#+ OreT   1  10806358 187923124 873.48
#+ Ore16  1  10182697 188546785 873.68
#<none>               198729482 874.73
#+ Km16   1   5792268 192937214 875.01
#+ Km     1   3768424 194961058 875.62

#Step:  AIC=871.32
#Spese ~ Anni

#Df Sum of Sq       RSS    AIC
#<none>               181049546 871.32
#+ Km     1    554360 180495186 873.14
#+ Ore16  1    532094 180517452 873.15
#+ OreT   1    437319 180612227 873.18
#+ Km16   1    368366 180681180 873.20

#Call:
#  lm(formula = Spese ~ Anni)

#Coefficients:
#  (Intercept)         Anni  
#175.2        122.5  

# According with this procedure, the best model is Spese ~ Anni


#Backward elimination
step(full, data=TableReportSpese2016, direction="backward")
#Start:  AIC=878.7
#Spese ~ OreT + Anni + Km + Km16 + Ore16

#Df Sum of Sq       RSS    AIC
#- OreT   1      1654 179119661 876.70
#- Km     1    378646 179496653 876.82
#- Km16   1    495219 179613226 876.86
#- Ore16  1    610900 179728907 876.90
#- Anni   1   4868032 183986039 878.26
#<none>               179118007 878.70

#Step:  AIC=876.7
#Spese ~ Anni + Km + Km16 + Ore16

#Df Sum of Sq       RSS    AIC
#- Km     1    389018 179508679 874.83
#- Km16   1    499137 179618798 874.86
#- Ore16  1   1271810 180391470 875.11
#- Anni   1   5258916 184378577 876.38
#<none>               179119661 876.70

#Step:  AIC=874.83
#Spese ~ Anni + Km16 + Ore16

#Df Sum of Sq       RSS    AIC
#- Km16   1   1008774 180517452 873.15
#- Ore16  1   1172501 180681180 873.20
#<none>               179508679 874.83
#- Anni   1   8887712 188396391 875.63

#Step:  AIC=873.15
#Spese ~ Anni + Ore16

#Df Sum of Sq       RSS    AIC
#- Ore16  1    532094 181049546 871.32
#<none>               180517452 873.15
#- Anni   1   8029332 188546785 873.68

#Step:  AIC=871.32
#Spese ~ Anni

#Df Sum of Sq       RSS    AIC
#<none>              181049546 871.32
#- Anni  1  17679936 198729482 874.73

#Call:
#  lm(formula = Spese ~ Anni, data = TableReportSpese2016)

#Coefficients:
#  (Intercept)         Anni  
#175.2        122.5  

# Stepwise regression

step(null, scope = list(upper=full), data=TableReportSpese2016, direction="both")
#Start:  AIC=874.73
#Spese ~ 1

#Df Sum of Sq       RSS    AIC
#+ Anni   1  17679936 181049546 871.32
#+ OreT   1  10806358 187923124 873.48
#+ Ore16  1  10182697 188546785 873.68
#<none>               198729482 874.73
#+ Km16   1   5792268 192937214 875.01
#+ Km     1   3768424 194961058 875.62

#Step:  AIC=871.32
#Spese ~ Anni

#Df Sum of Sq       RSS    AIC
#<none>               181049546 871.32
#+ Km     1    554360 180495186 873.14
#+ Ore16  1    532094 180517452 873.15
#+ OreT   1    437319 180612227 873.18
#+ Km16   1    368366 180681180 873.20
#- Anni   1  17679936 198729482 874.73

#Call:
#  lm(formula = Spese ~ Anni)

#Coefficients:
#  (Intercept)         Anni  
#175.2        122.5

# Both algorithms give rise to results that are equivalent to the forward selection procedure. 