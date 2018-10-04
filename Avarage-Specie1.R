#How to open a txt file, each element of a cell must be separated by a tab.
#It's possible to export a cvs file in a txt file
#header=T indicates that in the first line there are headers of the table
table.df <- read.table(file.choose(),header=T) 
attach(table.df)

#To recognize the factors of numbers
Data<-factor(Data)

#To view the dataframe data
table.df
#Average of the abundance of species 1 in the two different sites
tapply (Specie1,Sito,mean) 
#A 56,9 B 43,7