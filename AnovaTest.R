# Anova test with 5 models
> modBase<-lm(Spese ~ OreT + Anni + Km + Km16 + Ore16)
> mod1<-lm(Spese ~ OreT + Anni + Km + Km16)
> mod2<-lm(Spese ~ OreT + Anni + Km)
> mod3<-lm(Spese ~ OreT + Anni)
> mod4<-lm(Spese~ Anni)
> anova(modBase, mod1,mod2, mod3, mod4)
#Analysis of Variance Table

#Model 1: Spese ~ OreT + Anni + Km + Km16 + Ore16
#Model 2: Spese ~ OreT + Anni + Km + Km16
#Model 3: Spese ~ OreT + Anni + Km
#Model 4: Spese ~ OreT + Anni
#Model 5: Spese ~ Anni
#Res.Df       RSS Df Sum of Sq      F Pr(>F)
#1     52 179118007                           
#2     53 179728907 -1   -610900 0.1774 0.6754
#3     54 179976209 -1   -247302 0.0718 0.7898
#4     55 180612227 -1   -636018 0.1846 0.6692
#5     56 181049546 -1   -437319 0.1270 0.7230

#So the best model is Model 1 e.t. the modBase